`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.08.2026 10:18:20
// Design Name: 
// Module Name: ahb_master_lite
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ahb_master_lite(
    input logic Hclk,//system clk
    input logic Hrstn,// active low rest
    //driven from the tb assuming a single master
    input logic [31:0] Haddr_m,
    input logic [31:0] Hwdata_m,
    input logic        Hwrite_m,
    input logic [1:0]  Htrans_m,
    input logic [2:0]  Hburst_m,
    input logic [2:0]  Hsize_m,
    //from the slave
    input logic Hready,
    input logic Hresp,
    output logic [31:0] Hrdata,
    //output for the ahb_lite master

    output logic [31:0] Haddr,
    output logic [31:0] Hwdata,
    output logic        Hwrite,//1 for write 0 for read
    output logic [1:0]  Htrans,
    output logic [2:0]  Hburst,
    output logic [2:0]  Hsize
    );

    //latching os signal;
    logic Hwrite_reg;

    logic [2:0] Hburst_reg;
    logic [2:0] Hsize_reg;
    logic [31:0] Hwdata_reg;
    logic [31:0] Haddr_reg;
    typedef enum logic [1:0] {idle,busy,nonseq,seq}  state_t;
    state_t state;
    
    logic [32:0] address_boundary;
    logic [7:0] transfer_byte;//maxiumum is 128 bytes 
    assign transfer_byte=1<<Hsize_reg;//to determine the number of byte;

    logic [5:0] last_beats;//maximum is 16
    always_comb 
    begin
        case(Hburst_reg)
            3'b010,3'b011:
            begin
                last_beats=5'b0011;//increment or wrap 4
            end
            3'b100,3'b101:
            begin
                last_beats=5'b0111;//increment or wrap 8
            end
            3'b110,3'b111:
            begin
                last_beats=5'b1111;//increment or wrap 16
            end
        default:last_beats=5'b0000;
        endcase
    end
    
    assign address_boundary=(last_beats+1) * transfer_byte;
    logic [3:0] beat_counter;
    //assign beat_counter=num_beats;

    always_ff @ (posedge Hclk)
    begin
        if(!Hrstn)
        begin
            state<=idle;
        end
        else
        begin
            case(state)
            idle:
            begin
                if(Htrans_m==2'b10 && Hready && !Hresp)
                begin
                    //Hwdata_reg<=Hwdata_m;
                    state<=nonseq;
                end
                else
                begin
                    state<=idle;
                end
            end
            busy:
            begin
                if((Hburst_reg==3'b010 || Hburst_reg==3'b100 || Hburst_reg==3'b110 || Hburst_reg==3'b011 || Hburst_reg==3'b101 || Hburst_reg==3'b111) && Hready && Htrans_m==2'b11)// for defined incr and wrap
                begin
                    state<=seq;
                end
                else if ((Hburst_reg==3'b001 && Htrans_m==2'b11) && Hready)//for undefined incr and contine in the same burst
                begin
                    state<=seq;
                end
                else if((Hburst_reg==3'b001 && Htrans_m==2'b10) && Hready)//for undefined incr and new burst
                begin
                    state<=nonseq;
                end
                else if((Hburst_reg==3'b001 && Htrans_m==2'b00) && Hready)//for undefined incr and new burst
                begin
                    state<=idle;
                end
                else 
                begin
                    state<=busy;
                end
            end
            nonseq:
            begin
                if((Htrans_m==2'b00 && Hburst_reg==3'b000) && Hready && !Hresp)
                begin
                    state<=idle;
                end
                else if ((!(Hburst_reg==3'b000) && Htrans_m==2'b01) && Hready && !Hresp)
                begin
                    state<=busy;
                end
                else if ((!(Hburst_reg==3'b000) && Htrans_m==2'b11) && Hready && !Hresp)
                begin
                    state<=seq;
                end
                else if((Htrans_m==2'b01 && Hburst_reg==3'b000) && Hready && !Hresp)
                begin
                    state<=nonseq;
                end
                else if(Hresp && !Hready)
                begin
                    state<=idle;
                end
                else
                begin
                    state<=nonseq;
                end
            end
            seq:
            begin
                if(((Htrans_m==2'b00) && Hburst_reg==3'b001) && Hready && !Hresp)
                begin
                    state<=idle;
                end
                else if(((Htrans_m==2'b01)) && Hready)
                begin
                    state<=busy;
                end
                else if(((Htrans_m==2'b10)  && Hburst_reg==3'b001) && Hready && !Hresp)
                begin
                    state<=nonseq;
                end
                else if((!(Hburst_reg==3'b001) && (beat_counter==last_beats) && Htrans_m==2'b00) && Hready && !Hresp)
                begin
                    state<=idle;
                end
                else if((!(Hburst_reg==3'b001) && (beat_counter==last_beats) && Htrans_m==2'b10) && Hready && !Hresp)
                begin
                    state<=nonseq;
                end
                else if(Hresp)
                begin
                    state<=idle;
                end
                else
                begin
                    state<=seq;
                end
            end
            default:
            begin
                state<=idle;
            end
            endcase
        end
    end

    //for increment the next address is address + no. of bytes
    //for wrap we need to check if it is within the address boundary
    //lower address =Haddr & ~(Address Boundary-1)
    //upper boundary=lowe address + address boundary(in hexadecimal)
    //counter for predefined wrap or incre then load the counter in the nonseq and subract one 
    //hold the counter value in the busy state 
    //decerment the counter value in the seq
    //beat counter
    always_ff @ (posedge Hclk)
    begin
        if(!Hrstn)
        begin
            beat_counter<='0;
        end
        else 
        begin
            case(state)
                idle:
                begin
                    beat_counter<='0;
                end
                busy:
                begin 
                    if((Hburst_reg==3'b000) || (Hburst_reg==3'b001))//single and undefined increment
                    begin
                        beat_counter<='0;
                    end
                    else
                    begin
                        beat_counter<=beat_counter;//for other state
                    end
                end
                nonseq:
                begin
                    beat_counter<='0;
                end
                seq:
                begin
                    if((Hburst_reg==3'b000) || (Hburst_reg==3'b001))
                    begin
                        beat_counter<='0;
                    end
                    else if(Hready && ! ((Hburst_reg==3'b000) || (Hburst_reg==3'b001)))
                    begin
                        beat_counter<=beat_counter + 1'b1;
                    end
                    else 
                    begin
                        beat_counter<=beat_counter;
                    end
                end
            default:beat_counter<='0;
            endcase
        end
    end
    //address
    logic [32:0] start_wrap;
    logic [32:0] end_wrap;
    logic [32:0] wrap_address;
    always_comb 
    begin
        if(Hburst_reg==3'b010 || Hburst_reg==3'b100 || Hburst_reg==3'b110)
        begin
            start_wrap=wrap_address & ~(address_boundary- 1);
            end_wrap=address_boundary+start_wrap - 1;
        end
        else
        begin
            start_wrap='0;
            end_wrap='0;
        end
    end
    
    logic [1:0] prev_trans;
    
    always_ff @ (posedge Hclk)
    begin
        if(Hrstn)
        begin
            prev_trans<=Htrans_m;
        end
        else
        begin
            prev_trans<='0;
        end
    end

// for address
    always_ff @(posedge Hclk)
    begin
        if (!Hrstn || (!Hready && Hresp))
        begin
            Haddr_reg <= '0;
            wrap_address<='0;
        end
        else if(Hready && Htrans_m==2'b10)
        begin
            Haddr_reg<=Haddr_m;
            wrap_address<=Haddr_m;
        end
        else if(Htrans_m == 2'b01 && Hready && (prev_trans == 2'b10 || prev_trans == 2'b11))
        begin
            Haddr_reg <= Haddr_reg + transfer_byte; 
        end
        else if (Htrans_m == 2'b11 && Hready)
        begin

            // Undefined INCR
            if (Hburst_reg == 3'b001)
            begin
                if(prev_trans != 2'b01)
                Haddr_reg <= Haddr_reg + transfer_byte;
                else 
                Haddr_reg <= Haddr_reg;
            end

            // Defined INCR
            else if ((Hburst_reg == 3'b011) ||
                    (Hburst_reg == 3'b101) ||
                    (Hburst_reg == 3'b111))
            begin
                if(prev_trans != 2'b01)
                Haddr_reg <= Haddr_reg + transfer_byte;
                else
                Haddr_reg <= Haddr_reg;
            end

            // WRAP
            else if ((Hburst_reg == 3'b010) ||
                    (Hburst_reg == 3'b100) ||
                    (Hburst_reg == 3'b110))
            begin
                if(prev_trans != 2'b01)
                begin
                    if ((Haddr_reg + transfer_byte) > end_wrap)
                        Haddr_reg <= start_wrap;
                    else
                        Haddr_reg <= Haddr_reg + transfer_byte;
                end
                else
                begin
                    if((Haddr_reg + transfer_byte) > end_wrap)
                        Haddr_reg <= start_wrap;
                    else
                        Haddr_reg <= Haddr_reg;
                end
            end
        end
    end
    logic [31:0] pipeline;
    always_ff @ (posedge Hclk)
        begin
            if(!Hrstn || (!Hready && Hresp))
            begin
                //data_out   <= '0;

                Hwdata_reg <= '0;
                Hwrite_reg <= '0;
                Hburst_reg <= '0;
                Hsize_reg  <= '0;
                pipeline   <= '0;
            end
            else if (Hresp)
            begin
                Hwdata_reg <= '0;
            end
            else if (Hready && !Hresp)
            begin
                // 1. Shift pipeline data into Hwdata_reg for the current data phase
                Hwdata_reg <= pipeline;
                
                // 2. Capture incoming testbench write data into the pipeline
                if (Htrans_m == 2'b10 || Htrans_m == 2'b11) 
                begin
//                    if(Hwrite_m)
//                    begin
                        pipeline <= Hwdata_m;
//                    end
//                    else
//                    begin
//                        data_out<=Hrdata;
//                    end
                end

                // 3. Latch control/burst parameters on a new transaction (NONSEQ)
                if (Htrans_m == 2'b10) begin
                    Hburst_reg <= Hburst_m;
                    Hsize_reg  <= Hsize_m;
                    Hwrite_reg <= Hwrite_m;
                end
            end
        end
    
    always_comb 
    begin
        Haddr=Haddr_reg;
        Hwrite=Hwrite_reg;
        if(Hready && !Hresp)
        begin
            Hwdata=Hwdata_reg;
        end
        else 
        begin
            Hwdata='0;
        end
        Hsize=Hsize_reg;
        Hburst=Hburst_reg;
        case(state)
        idle  : Htrans = 2'b00;
        busy  : Htrans = 2'b01;
        nonseq: Htrans = 2'b10;
        seq   : Htrans = 2'b11;
        endcase
    end





endmodule:ahb_master_lite
