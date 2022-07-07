`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/28 14:50:19
// Design Name: 
// Module Name: sext
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


module sext(
    input wire [24:0]   imm,
    input wire [2:0]    op,
    output wire [31:0]   ext
    );

wire [19:0] upper;
wire [10:0] uup;
wire [31:0] i;
wire [31:0] s;
wire [31:0] b;
wire [31:0] u;
wire [31:0] j;

assign upper = imm[24]? 20'hfffff:20'h0;
assign uup = imm[24]? 11'h7ff:11'h0;
assign i = {upper, imm[24:13]};
assign s = {upper, imm[24:18], imm[4:0]};
assign b = {upper, imm[0], imm[23:18], imm[4:1], 1'b0};
assign u = {imm[24:5], 12'b0};
assign j = {uup, imm[24], imm[12:5], imm[13], imm[23:14], 1'b0};

assign ext = op[0]? (op[1]? u:s):(op[1]? b:(op[2]? j:i));
/**
always@(*)begin 
    case(op)
        3'b000: ext = {upper, imm[24:13]};
        3'b001: ext = {upper, imm[24:18], imm[4:0]};
        3'b010: ext = {upper, imm[0], imm[23:18], imm[4:1], 1'b0};
        3'b011: ext = {imm[24:5], 12'b0};
        3'b100: ext = {uup, imm[24], imm[12:5], imm[13], imm[23:14], 1'b0};
    endcase
end
     */  
endmodule
