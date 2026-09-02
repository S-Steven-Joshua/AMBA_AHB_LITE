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
        // UNDEFINED INCR BURST (5 Beats, Hsize = 3'b010 / 32-bit word)
        // Master automatically calculates subsequent addresses from Haddr_m
        // ==========================================================

        // Beat 1: Address Phase (NONSEQ) - Provide initial start address
        @(posedge Hclk);
        #1;
        Haddr_m  = 32'h0000_0010;
        Hwdata_m = 32'h1111_1111;
        Hwrite_m = 1'b1;
        Htrans_m = 2'b10; // NONSEQ
        Hburst_m = 3'b001; // INCR
        Hsize_m  = 3'b010; // 32-bit

        // Beat 2: Address Phase (SEQ) + Data Phase 1
        @(posedge Hclk);
        #1;
        Hwdata_m = 32'h2222_2222;
        Htrans_m = 2'b11; // SEQ

        // Beat 3: Address Phase (SEQ) + Data Phase 2
        @(posedge Hclk);
        #1;
        Hwdata_m = 32'h3333_3333;
        Htrans_m = 2'b11; // SEQ

        // Beat 4: Address Phase (SEQ) + Data Phase 3
        @(posedge Hclk);
        #1;
        Hwdata_m = 32'h4444_4444;
        Htrans_m = 2'b11; // SEQ

        // Beat 5: Address Phase (SEQ) + Data Phase 4
        @(posedge Hclk);
        #1;
        Hwdata_m = 32'h5555_5555;
        Htrans_m = 2'b11; // SEQ

        // Final Data Phase 5
        @(posedge Hclk);
        #1;
        Haddr_m  = '0;
        Hwdata_m = '0;
        Hwrite_m = 1'b0;
        Htrans_m = 2'b00; // IDLE

        repeat(10) @(posedge Hclk);
        $finish;
    end

endmodule
