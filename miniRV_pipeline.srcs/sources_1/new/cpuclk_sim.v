`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/24 15:03:45
// Design Name: 
// Module Name: cpuclk_sim
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


module cpuclk_sim(
    );
    reg fpga_clk = 0;
    wire clk_lock;
    wire pll_clk;
    wire cpu_clk;
    
    always #5 fpga_clk = ~fpga_clk;
    
//    cpuclk UCLK(
//        .clk_in1(fpga_clk),
//        .locked(clk_lock),
//        .clk_out1(pll_clk)
//    );
    
    assign cpu_clk = pll_clk & clk_lock;
    
endmodule
