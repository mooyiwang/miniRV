`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/05 20:27:43
// Design Name: 
// Module Name: top
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


module top(
    input wire          clk,
    input wire          rst_i,
    input wire [23:0]   switch_i,
    output wire [23:0]  led_o,
    output wire [7:0]   digit_ledx_en_o,
    output wire [7:0]   digit_led_cx_o
    );
    
wire rst_n;
wire clk_g;
wire locked;
wire [31:0] pc;
wire [31:0] inst;
wire [31:0] adr;
wire        wE;
wire [31:0] wD;
wire [31:0] rD;

assign rst_n = ~rst_i;

bus_bridge  u_bus_bridge(
    .clk_i          (clk_g),
    .rst_n          (rst_n),
    .adr            (adr),
    .wE             (wE),
    .wD             (wD),
    .rD             (rD),
    .switch_i       (switch_i),
    .led_o          (led_o),
    .digit_ledx_en_o(digit_ledx_en_o),
    .digit_led_cx_o (digit_led_cx_o)
    );

miniRV u_miniRV(
    .clk            (clk_g),
    .rst_n          (rst_n),
    .if_pc             (pc),
    .if_inst           (inst),
    .adr            (adr),
    .wE             (wE),
    .wD             (wD),
    .rD             (rD)
    );

prgrom u_irom(
    .a   (pc[15:2]),
    .spo (inst)
    );
    
cpuclk u_cpuclk(
    .clk_in1    (clk),
    .locked     (locked),
    .clk_out1   (clk_g)
    );
    

endmodule
