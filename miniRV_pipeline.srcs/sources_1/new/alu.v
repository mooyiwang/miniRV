`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/28 16:06:28
// Design Name: 
// Module Name: alu
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


module alu(
    input wire [31:0]   a,
    input wire [31:0]   b,
    input wire [2:0]    op,
    output wire [31:0]  c
    );

wire [31:0] alg;
wire [31:0] logi;
wire [31:0] shift;
wire        alg_op;
wire [1:0]  logi_op;
wire [1:0]  shift_op;
wire [1:0]  res_sel;
wire [6:0]  alu_op_decoded;

assign alg_op = alu_op_decoded[6];
assign logi_op = alu_op_decoded[5:4];
assign shift_op = alu_op_decoded[3:2];
assign res_sel = alu_op_decoded[1:0];

assign c = res_sel[0]? logi:(res_sel[1]? shift: alg);

alu_adder u_alu_adder(
    .a      (a),
    .b      (b),
    .op     (alg_op),
    .c      (alg)
    );

alu_logicunit u_alu_logicunit(
    .a      (a),
    .b      (b),
    .op     (logi_op),
    .c      (logi)
    );    

alu_bucket_shifter u_alu_bucket_shifter(
    .a      (a),
    .b      (b),
    .op     (shift_op),
    .c      (shift)
    );   
    
alu_opdecode u_alu_opdecode(
    .alu_op     (op),
    .decoded    (alu_op_decoded)
    );
    
    
    
    
    
    
endmodule
