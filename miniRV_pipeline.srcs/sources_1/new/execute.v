`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/28 16:05:58
// Design Name: 
// Module Name: execute
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


module execute(
    input wire [31:0]   rD1,
    input wire [31:0]   rD2,
    input wire [31:0]   ext,
    input wire          alua_sel,
    input wire          alub_sel,
    input wire [2:0]    alu_op,
    output wire [31:0]  c
    );

wire [31:0] a;
wire [31:0] b;
assign a = alua_sel? 32'b0: rD1;
assign b = alub_sel? ext: rD2;    

alu u_alu(
    .a      (a),
    .b      (b),
    .c      (c),
    .op     (alu_op)
    );
    
endmodule
