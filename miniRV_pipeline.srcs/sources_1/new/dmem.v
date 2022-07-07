`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/30 16:16:26
// Design Name: 
// Module Name: dmem
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


module dmem(
    input wire          clk_i,
    input wire          rst_n,
    input wire [31:0]   adr,
    input wire [31:0]   wD,
    input wire          wE,
    output wire [31:0]  rD,
    input wire [23:0]   switch_i,
    output wire [23:0]  led_o,
    output wire [7:0]   digit_ledx_en_o,
    output wire [7:0]   digit_led_cx_o
    );



    
dram u_dram(
    .clk    (clk_i),
    .a      (adr[15:2]),
    .d      (wD),
    .we     (wE),
    .spo    (rD)
    );
endmodule
