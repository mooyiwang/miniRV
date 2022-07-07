`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/30 14:37:12
// Design Name: 
// Module Name: alu_adder
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


module alu_adder(
    input wire [31:0]   a,
    input wire [31:0]   b,
    input wire          op,
    output wire [31:0]  c
    );

wire [31:0] add;
wire [31:0] sub;
assign add = a + b;
assign sub = a + ~b + 1'b1;
assign c = op? sub: add;

endmodule
