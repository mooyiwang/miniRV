`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/05 22:43:34
// Design Name: 
// Module Name: bus_bridge
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


module bus_bridge(
    input wire          clk_i,
    input wire          rst_n,
    input wire [31:0]   adr,
    input wire          wE,
    input wire [31:0]   wD,
    output reg [31:0]   rD,
    input wire [23:0]   switch_i,
    output wire [23:0]  led_o,
    output wire [7:0]   digit_ledx_en_o,
    output wire [7:0]   digit_led_cx_o
    );
    

wire [31:0] dram_rD;
reg         dram_wE;
wire [31:0] switch_rD;

always@(*)begin
    if(adr==32'hfffff070) rD = switch_rD;
    else rD = dram_rD;
end

digit_driver u_digit_driver(
    .clk            (clk_i),
    .rst_n          (rst_n),
    .adr            (adr),
    .wE             (wE),
    .wD             (wD),
    .led_en         (digit_ledx_en_o),
    .digit_led_cx_o (digit_led_cx_o)
    );
    
LED_driver u_LED_driver(
    .clk_i          (clk_i),
    .rst_n          (rst_n),
    .adr            (adr),
    .wE             (wE),
    .wD             (wD),
    .led_o          (led_o)
    );    
    
switch_driver u_switch_driver(
    .clk_i          (clk_i),
    .switch_i       (switch_i),
    .adr            (adr),
    .rD             (switch_rD)
    );
always@(*)begin
    if(adr==32'hfffff000 || adr==32'hfffff060 || adr==32'hfffff070) dram_wE = 1'b0;
    else dram_wE = wE;
end

dram u_dram(
    .clk    (clk_i),
    .a      (adr[15:2]),
    .d      (wD),
    .we     (dram_wE),
    .spo    (dram_rD)
    );


endmodule
