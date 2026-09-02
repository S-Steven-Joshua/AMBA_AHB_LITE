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

    // Single Write task
    task ahb_write(input [31:0] addr, input [31:0] data, input [2:0] size);
        @(posedge Hclk);
        #1;
        Haddr_m  = addr;
        Hwdata_m = data;
        Hwrite_m = 1'b1;
        Htrans_m = 2'b10; // NONSEQ
        Hsize_m  = size;
        
        @(posedge Hclk);
        #1;
        Haddr_m  = '0;
        Hwdata_m = '0;
        Hwrite_m = 1'b0;
        Htrans_m = 2'b00; // IDLE
    endtask

    // Single Read task
    task ahb_read(input [31:0] addr, input [2:0] size);
        @(posedge Hclk);
        #1;
        Haddr_m  = addr;
        Hwrite_m = 1'b0; // Read
        Htrans_m = 2'b10; // NONSEQ
        Hsize_m  = size;
        
        @(posedge Hclk);
        #1;
        Haddr_m  = '0;
        Htrans_m = 2'b00; // IDLE
    endtask

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
        // 1. BYTE (1-Byte) WRITE & READ
        // ==========================================================
        ahb_write(32'h0000_0010, 32'h0000_00AB, 3'b000);
        repeat(2) @(posedge Hclk);
        ahb_read(32'h0000_0010, 3'b000);
        repeat(2) @(posedge Hclk);

        // ==========================================================
        // 2. HALFWORD (2-Byte) WRITE & READ
        // ==========================================================
        ahb_write(32'h0000_0012, 32'h0000_ABCD, 3'b001);
        repeat(2) @(posedge Hclk);
        ahb_read(32'h0000_0012, 3'b001);
        repeat(2) @(posedge Hclk);

        // ==========================================================
        // 3. WORD (4-Byte) WRITE & READ
        // ==========================================================
        ahb_write(32'h0000_0014, 32'hDEAD_BEEF, 3'b010);
        repeat(2) @(posedge Hclk);
        ahb_read(32'h0000_0014, 3'b010);

        repeat(10) @(posedge Hclk);
        $finish;
    end

endmodule
