`timescale 1ns/1ps

module ahb_top_tb;

    logic        Hclk;
    logic        Hrstn;
    logic [31:0] Haddr_m;
    logic [31:0] Hwdata_m;
    logic        Hwrite_m;
    logic [1:0]  Htrans_m;
    logic [2:0]  Hburst_m;
    logic [2:0]  Hsize_m;
    
    logic        Hready;
    logic        Hresp;
    logic [31:0] Hrdata;
    
    logic [31:0] Haddr;
    logic [31:0] Hwdata;
    logic        Hwrite;
    logic [1:0]  Htrans;
    logic [2:0]  Hburst;
    logic [2:0]  Hsize;

    // RAM array mirror for waveform viewing
    logic [31:0] ram [15:0];

    always_comb begin
        for (int k = 0; k < 16; k++) begin
            ram[k] = dut.slave.ram[k];
        end
    end

    ahb_top dut (
        .Hclk     (Hclk),
        .Hrstn    (Hrstn),
        .Haddr_m  (Haddr_m),
        .Hwdata_m (Hwdata_m),
        .Hwrite_m (Hwrite_m),
        .Htrans_m (Htrans_m),
        .Hburst_m (Hburst_m),
        .Hsize_m  (Hsize_m),
        .Hready   (Hready),
        .Hresp    (Hresp),
        .Hrdata   (Hrdata),
        .Haddr    (Haddr),
        .Hwdata   (Hwdata),
        .Hwrite   (Hwrite),
        .Htrans   (Htrans),
        .Hburst   (Hburst),
        .Hsize    (Hsize)
    );

    initial begin
        Hclk = 1'b0;
        forever #5 Hclk = ~Hclk;
    end

    initial begin
        Hrstn    = 1'b0;
        Haddr_m  = '0;
        Hwdata_m = '0;
        Hwrite_m = 1'b0;
        Htrans_m = 2'b00;
        Hburst_m = 3'b000;
        Hsize_m  = 3'b010;

        repeat(2) @(posedge Hclk);
        Hrstn = 1'b1;
        @(posedge Hclk);

        // ==========================================================
        // WRAP4 WORD BURST WRITE WITH INSERTED BUSY STATE
        // Hsize = 3'b010 (Word), Hburst = 3'b010 (WRAP4)
        // ==========================================================

        // Beat 1: Address Phase (NONSEQ)
        @(posedge Hclk);
        #1;
        Haddr_m  = 32'h0000_0010; // Start address
        Hwdata_m = 32'h1111_1111; // Data for beat 1
        Hwrite_m = 1'b1;          // Write mode
        Htrans_m = 2'b10;         // NONSEQ
        Hburst_m = 3'b010;        // WRAP4
        Hsize_m  = 3'b010;        // Word (32-bit)

        // Beat 2: Address Phase (SEQ) + Data Phase 1
        @(posedge Hclk);
        #1;
        Hwdata_m = 32'h2222_2222; // Data for beat 2
        Htrans_m = 2'b11;         // SEQ

        // Insert BUSY State (Master needs a cycle before providing Beat 3)
        
        @(posedge Hclk);
        #1;
        Htrans_m = 2'b01;         // BUSY state

        // Beat 3: Address Phase (SEQ resumes) + Data Phase 2
        @(posedge Hclk);
        #1;
        Hwdata_m = 32'h3333_3333; // Data for beat 3
        Htrans_m = 2'b11;         // SEQ

        // Beat 4: Address Phase (SEQ - Final beat of WRAP4) + Data Phase 3
        @(posedge Hclk);
        #1;
        Hwdata_m = 32'h4444_4444; // Data for beat 4
        Htrans_m = 2'b11;         // SEQ

        // Final Data Phase 4 completion (IDLE)
        @(posedge Hclk);
        #1;
        Haddr_m  = '0;
        Hwdata_m = '0;
        Hwrite_m = 1'b0;
        Htrans_m = 2'b00;         // IDLE

        // Final simulation settle time
        repeat(10) @(posedge Hclk);
        $finish;
    end

endmodule
