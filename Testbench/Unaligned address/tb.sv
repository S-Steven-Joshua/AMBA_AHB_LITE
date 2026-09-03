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
        // PART 1: WRAP4 WORD BURST WRITE WITH UNALIGNED START ADDRESS
        // Hsize = 3'b010 (Word), Start Address = 0x0000_0012 (Unaligned)
        // 16-byte wrapping boundary block: [0x10 to 0x1F]
        // ==========================================================

        // Beat 1: Address Phase (NONSEQ) - Unaligned start address
        @(posedge Hclk);
        #1;
        Haddr_m  = 32'h0000_0012; // Unaligned word address
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

        // Beat 3: Address Phase (SEQ) + Data Phase 2
        @(posedge Hclk);
        #1;
        Hwdata_m = 32'h3333_3333; // Data for beat 3
        Htrans_m = 2'b11;         // SEQ

        // Beat 4: Address Phase (SEQ) + Data Phase 3
        @(posedge Hclk);
        #1;
        Hwdata_m = 32'h4444_4444; // Data for beat 4
        Htrans_m = 2'b11;         // SEQ

        // Final Data Phase 4 completion
        @(posedge Hclk);
        #1;
        Haddr_m  = '0;
        Hwdata_m = '0;
        Hwrite_m = 1'b0;
        Htrans_m = 2'b00;         // IDLE

        // Pause between write and read bursts
        repeat(3) @(posedge Hclk);

        // ==========================================================
        // PART 2: WRAP4 WORD BURST READ WITH UNALIGNED START ADDRESS
        // ==========================================================

        // Beat 1: Address Phase (NONSEQ)
        @(posedge Hclk);
        #1;
        Haddr_m  = 32'h0000_0012; // Same unaligned start address
        Hwrite_m = 1'b0;          // Read mode
        Htrans_m = 2'b10;         // NONSEQ
        Hburst_m = 3'b010;        // WRAP4
        Hsize_m  = 3'b010;        // Word (32-bit)

        // Beats 2 to 4: Address Phase (SEQ)
        repeat(3) begin
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
