`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.09.2026 19:32:15
// Design Name: 
// Module Name: ahb_top
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


module ahb_top(
    input logic Hclk,
    input logic Hrstn,
    input logic [31:0] Haddr_m,
    input logic [31:0] Hwdata_m,
    input logic        Hwrite_m,
    input logic [1:0]  Htrans_m,
    input logic [2:0]  Hburst_m,
    input logic [2:0]  Hsize_m,
    
    output logic Hready,
    output logic Hresp,
    output logic [31:0] Hrdata,

    
    output logic [31:0] Haddr,
    output logic [31:0] Hwdata,
    output logic        Hwrite,
    output logic [1:0]  Htrans,
    output logic [2:0]  Hburst,
    output logic [2:0]  Hsize
    );
    
    ahb_master_lite master(.Hclk(Hclk),.Hrstn(Hrstn),.Haddr_m(Haddr_m),.Hwdata_m(Hwdata_m),
                           .Hwrite_m(Hwrite_m),.Htrans_m(Htrans_m),.Hburst_m(Hburst_m),
                           .Hsize_m(Hsize_m),.Hready(Hready),.Hresp(Hresp),.Hrdata(Hrdata),
                           .Haddr(Haddr),.Hwdata(Hwdata),.Hwrite(Hwrite),
                           .Htrans(Htrans),.Hburst(Hburst),.Hsize(Hsize));
    
    ahb_slave slave(.Hclk(Hclk),.Hrstn(Hrstn),.Haddr(Haddr),.Hwdata(Hwdata),.Hwrite(Hwrite),
                    .Htrans(Htrans),.Hburst(Hburst),.Hsize(Hsize),.Hready(Hready),.Hresp(Hresp),
                    .Hrdata(Hrdata));
                           
endmodule:ahb_top
