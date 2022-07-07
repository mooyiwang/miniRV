`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/30 14:37:48
// Design Name: 
// Module Name: alu_logicunit
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


module alu_logicunit(
    input wire [31:0]   a,
    input wire [31:0]   b,
    input wire [1:0]    op,
    output wire [31:0]  c
    );
    
wire [31:0] AND;
wire [31:0] OR;
wire [31:0] XOR;

assign AND = a & b;
assign OR = a | b;
assign XOR = a ^ b;

assign c = op[0]? OR:(op[1]? XOR: AND);
/**
always@(*) begin 
    case(op)
        2'b00:c = AND;
        2'b01:c = OR;
        2'b10:c = XOR;
    endcase
end*/
endmodule
