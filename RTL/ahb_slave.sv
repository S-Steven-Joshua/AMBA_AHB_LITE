`timescale 1ns / 1ps 

module ahb_slave(
    input  logic        Hclk,
    input  logic        Hrstn,
    input  logic [31:0] Haddr,
    input  logic [31:0] Hwdata,
    input  logic        Hwrite,
    input  logic [1:0]  Htrans,
    input  logic [2:0]  Hburst,
    input  logic [2:0]  Hsize,

    output logic        Hready,
    output logic        Hresp,
    output logic [31:0] Hrdata
);

    logic [31:0] ram [255:0];
    integer i;

    typedef enum logic [1:0] {
        normal,
        error_wait,
        error_done
    } state_t;

    state_t state;

    logic aligned;

    logic [31:0] Haddr_reg;
    logic        Hwrite_reg;
    logic [2:0]  Hsize_reg;
    logic [1:0]  Htrans_reg;




    always_ff @(posedge Hclk)
    begin
        if (!Hrstn)
        begin
            Haddr_reg  <= '0;
            Hwrite_reg <= 1'b0;
            Hsize_reg  <= '0;
            Htrans_reg <= 2'b00;
        end
        else
        begin
            if (Htrans == 2'b10 || Htrans == 2'b11)
            begin
                Haddr_reg  <= Haddr;
                Hwrite_reg <= Hwrite;
                Hsize_reg  <= Hsize;
                Htrans_reg <= Htrans;
            end
            else if (Htrans == 2'b00 || Htrans == 2'b01)
            begin
                Htrans_reg <= 2'b00;
                Hsize_reg  <= 3'b000;
                Hwrite_reg <= 1'b0;
                Haddr_reg  <= '0;
            end
        end
    end



    always_comb
    begin
        if (Htrans == 2'b10 || Htrans == 2'b00)
        begin
            case (Hsize)

                3'b000:
                    aligned = 1'b1;

                3'b001:
                    aligned = (Haddr[0] == 1'b0);

                3'b010:
                    aligned = (Haddr[1:0] == 2'b00);

                default:
                    aligned = 1'b0;

            endcase
        end
        else
        begin
            aligned = 1'b1;
        end
    end




    always_ff @(posedge Hclk)
    begin
        if (!Hrstn)
        begin
            Hready <= 1'b1;
            Hresp  <= 1'b0;
            state  <= normal;
        end
        else
        begin
            Hready <= 1'b1;
            Hresp  <= 1'b0;

            case (state)

                normal:
                begin
                    if ((Htrans == 2'b00 || Htrans == 2'b01) &&
                        !(Htrans_reg == 2'b10 || Htrans_reg == 2'b11))
                    begin
                        state <= normal;
                    end

                    else if (
                        (
                            (Htrans_reg == 2'b10 || Htrans_reg == 2'b11) ||
                            (
                                (Htrans == 2'b10 || Htrans == 2'b11) &&
                                (Haddr >= 32'h0000_0000 &&
                                 Haddr <= 32'h0000_03FF) &&
                                aligned
                            )
                        )
                    )
                    begin
                        state <= normal;
                    end

                    else
                    begin
                        state <= error_done;
                        Hready<=1'b0;
                        Hresp<=1'b1;
                    end
                end


                error_wait:
                begin
                    Hready <= 1'b0;
                    Hresp  <= 1'b1;
                    state  <= error_done;
                end


                error_done:
                begin
                    Hready <= 1'b1;
                    Hresp  <= 1'b1;
                    state  <= normal;
                end


                default:
                    state <= normal;

            endcase
        end
    end



    always_comb
    begin

        Hrdata = 32'h0000_0000;



        if (!Hrstn)
        begin
            for (i = 0; i < 256; i = i + 1)
            begin
                ram[i] = 32'h0000_0000;
            end
        end

        else
        begin

            if (
                (Haddr_reg >= 32'h0000_0000) &&
                (Haddr_reg <= 32'h0000_03FF) &&
                Hwrite_reg
            )
            begin

                case (Hsize_reg)
                    3'b000:
                    begin
                        case (Haddr_reg[1:0])

                            2'b00:
                                ram[Haddr_reg[9:2]][7:0] =
                                    Hwdata[7:0];

                            2'b01:
                                ram[Haddr_reg[9:2]][15:8] =
                                    Hwdata[7:0];

                            2'b10:
                                ram[Haddr_reg[9:2]][23:16] =
                                    Hwdata[7:0];

                            2'b11:
                                ram[Haddr_reg[9:2]][31:24] =
                                    Hwdata[7:0];

                        endcase
                    end

                    3'b001:
                    begin
                        if (Haddr_reg[1] == 1'b0)
                            ram[Haddr_reg[9:2]][15:0] =
                                Hwdata[15:0];
                        else
                            ram[Haddr_reg[9:2]][31:16] =
                                Hwdata[15:0];
                    end

                    3'b010:
                    begin
                        ram[Haddr_reg[9:2]] = Hwdata;
                    end


                    default:
                    begin
                    end

                endcase
            end

            else if (
                (Haddr_reg >= 32'h0000_0000) &&
                (Haddr_reg <= 32'h0000_03FF) &&
                !Hwrite_reg
            )
            begin

                case (Hsize_reg)

                    3'b000:
                    begin
                        case (Haddr_reg[1:0])

                            2'b00:
                                Hrdata =
                                    {24'h000000,
                                     ram[Haddr_reg[9:2]][7:0]};

                            2'b01:
                                Hrdata =
                                    {24'h000000,
                                     ram[Haddr_reg[9:2]][15:8]};

                            2'b10:
                                Hrdata =
                                    {24'h000000,
                                     ram[Haddr_reg[9:2]][23:16]};

                            2'b11:
                                Hrdata =
                                    {24'h000000,
                                     ram[Haddr_reg[9:2]][31:24]};

                        endcase
                    end


                    3'b001:
                    begin
                        if (Haddr_reg[1] == 1'b0)
                            Hrdata =
                                {16'h0000,
                                 ram[Haddr_reg[9:2]][15:0]};
                        else
                            Hrdata =
                                {16'h0000,
                                 ram[Haddr_reg[9:2]][31:16]};
                    end



                    3'b010:
                    begin
                        Hrdata = ram[Haddr_reg[9:2]];
                    end


                    default:
                    begin
                        Hrdata = 32'h0000_0000;
                    end

                endcase
            end
        end
    end

endmodule