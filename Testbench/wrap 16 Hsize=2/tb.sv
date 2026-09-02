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
        // PART 1: WRAP16 WORD BURST WRITE (16 Beats, Hsize = 3'b010)
        // 64-byte boundary wrapping block [0x00 to 0x3F].
        // Start address at 0x20 (exact middle) to test wrap-around.
        // ==========================================================

        // Beat 1: Address Phase (NONSEQ)
        @(posedge Hclk);
        #1;
        Haddr_m  = 32'h0000_0020; // Middle start address (64-byte aligned boundary block)
        Hwdata_m = 32'h0000_0001; // Data for beat 1
        Hwrite_m = 1'b1;          // Write mode
        Htrans_m = 2'b10;         // NONSEQ
        Hburst_m = 3'b110;        // WRAP16 (3'b110)
        Hsize_m  = 3'b010;        // Word (32-bit)

        // Beats 2 to 16: Address Phase (SEQ) + Data Phases 
        // (Addresses progress: 0x20 -> ... -> 0x3C, then wrap to 0x00 -> 0x1C)
        @(posedge Hclk); #1; Hwdata_m = 32'h0000_0002; Htrans_m = 2'b11;
        @(posedge Hclk); #1; Hwdata_m = 32'h0000_0003; Htrans_m = 2'b11;
        @(posedge Hclk); #1; Hwdata_m = 32'h0000_0004; Htrans_m = 2'b11;
        @(posedge Hclk); #1; Hwdata_m = 32'h0000_0005; Htrans_m = 2'b11;
        @(posedge Hclk); #1; Hwdata_m = 32'h0000_0006; Htrans_m = 2'b11;
        @(posedge Hclk); #1; Hwdata_m = 32'h0000_0007; Htrans_m = 2'b11;
        @(posedge Hclk); #1; Hwdata_m = 32'h0000_0008; Htrans_m = 2'b11;
        @(posedge Hclk); #1; Hwdata_m = 32'h0000_0009; Htrans_m = 2'b11;
        @(posedge Hclk); #1; Hwdata_m = 32'h0000_000A; Htrans_m = 2'b11;
        @(posedge Hclk); #1; Hwdata_m = 32'h0000_000B; Htrans_m = 2'b11;
        @(posedge Hclk); #1; Hwdata_m = 32'h0000_000C; Htrans_m = 2'b11;
        @(posedge Hclk); #1; Hwdata_m = 32'h0000_000D; Htrans_m = 2'b11;
        @(posedge Hclk); #1; Hwdata_m = 32'h0000_000E; Htrans_m = 2'b11;
        @(posedge Hclk); #1; Hwdata_m = 32'h0000_000F; Htrans_m = 2'b11;
        @(posedge Hclk); #1; Hwdata_m = 32'h0000_0010; Htrans_m = 2'b11;

        // Final Data Phase 16
        @(posedge Hclk);
        #1;
        Haddr_m  = '0;
        Hwdata_m = '0;
        Hwrite_m = 1'b0;
        Htrans_m = 2'b00;         // IDLE

        // Pause between write and read bursts
        repeat(3) @(posedge Hclk);

        // ==========================================================
        // PART 2: WRAP16 WORD BURST READ (16 Beats, Hsize = 3'b010)
        // ==========================================================

        // Beat 1: Address Phase (NONSEQ)
        @(posedge Hclk);
        #1;
        Haddr_m  = 32'h0000_0020; // Same middle start address
        Hwrite_m = 1'b0;          // Read mode
        Htrans_m = 2'b10;         // NONSEQ
        Hburst_m = 3'b110;        // WRAP16
        Hsize_m  = 3'b010;        // Word (32-bit)

        // Beats 2 to 16: Address Phase (SEQ)
        repeat(15) begin
            @(posedge Hclk);
            #1;
            Htrans_m = 2'b11;     // SEQ
        end

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
