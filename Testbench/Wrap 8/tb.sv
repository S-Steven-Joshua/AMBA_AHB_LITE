```systemverilog
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
        Hsize_m  = 3'b001;

        repeat(2) @(posedge Hclk);
        Hrstn = 1'b1;
        @(posedge Hclk);

        // ==========================================================
        // PART 1: WRAP8 HALFWORD BURST WRITE (8 Beats, Hsize = 3'b001)
        // Total bytes = 8 beats * 2 bytes = 16-byte wrapping boundary
        // ==========================================================

        // Beat 1: Address Phase (NONSEQ)
        @(posedge Hclk);
        #1;
        Haddr_m  = 32'h0000_0012; // Start address
        Hwdata_m = 32'h0000_1111; // Data for beat 1
        Hwrite_m = 1'b1;          // Write mode
        Htrans_m = 2'b10;         // NONSEQ
        Hburst_m = 3'b100;        // WRAP8 (3'b100)
        Hsize_m  = 3'b001;        // Halfword (16-bit)

        // Beat 2: Address Phase (SEQ) + Data Phase 1
        @(posedge Hclk); #1; Hwdata_m = 32'h0000_2222; Htrans_m = 2'b11;
        // Beat 3: Address Phase (SEQ) + Data Phase 2
        @(posedge Hclk); #1; Hwdata_m = 32'h0000_3333; Htrans_m = 2'b11;
        // Beat 4: Address Phase (SEQ) + Data Phase 3
        @(posedge Hclk); #1; Hwdata_m = 32'h0000_4444; Htrans_m = 2'b11;
        // Beat 5: Address Phase (SEQ) + Data Phase 4
        @(posedge Hclk); #1; Hwdata_m = 32'h0000_5555; Htrans_m = 2'b11;
        // Beat 6: Address Phase (SEQ) + Data Phase 5
        @(posedge Hclk); #1; Hwdata_m = 32'h0000_6666; Htrans_m = 2'b11;
        // Beat 7: Address Phase (SEQ) + Data Phase 6
        @(posedge Hclk); #1; Hwdata_m = 32'h0000_7777; Htrans_m = 2'b11;
        // Beat 8: Address Phase (SEQ) + Data Phase 7
        @(posedge Hclk); #1; Hwdata_m = 32'h0000_8888; Htrans_m = 2'b11;

        // Final Data Phase 8
        @(posedge Hclk);
        #1;
        Haddr_m  = '0;
        Hwdata_m = '0;
        Hwrite_m = 1'b0;
        Htrans_m = 2'b00;         // IDLE

        // Pause between write and read bursts
        repeat(3) @(posedge Hclk);

        // ==========================================================
        // PART 2: WRAP8 HALFWORD BURST READ (8 Beats, Hsize = 3'b001)
        // ==========================================================

        // Beat 1: Address Phase (NONSEQ)
        @(posedge Hclk);
        #1;
        Haddr_m  = 32'h0000_0012; // Same start address
        Hwrite_m = 1'b0;          // Read mode
        Htrans_m = 2'b10;         // NONSEQ
        Hburst_m = 3'b100;        // WRAP8
        Hsize_m  = 3'b001;        // Halfword (16-bit)

        // Beats 2 to 8: Address Phase (SEQ)
        @(posedge Hclk); #1; Htrans_m = 2'b11;
        @(posedge Hclk); #1; Htrans_m = 2'b11;
        @(posedge Hclk); #1; Htrans_m = 2'b11;
        @(posedge Hclk); #1; Htrans_m = 2'b11;
        @(posedge Hclk); #1; Htrans_m = 2'b11;
        @(posedge Hclk); #1; Htrans_m = 2'b11;
        @(posedge Hclk); #1; Htrans_m = 2'b11;

        // End Read Burst (IDLE)
        @(posedge Hclk);
        #1;
        Haddr_m  = '0;
        Htrans_m = 2'b00;         // IDLE

        // Final simulation settle time
        repeat(10) @(posedge Hclk);
        $finish;
    end

endmodule

```
