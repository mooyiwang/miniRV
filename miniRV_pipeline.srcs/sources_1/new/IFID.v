`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/06 15:29:34
// Design Name: 
// Module Name: IFID
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


module IFID(
    input wire          clk_i,
    input wire          rst_n,
    input wire [31:0]   if_pc,
    input wire [31:0]   if_pc4,
    input wire [31:0]   if_inst,
    output reg [31:0]   id_pc,
    output reg [31:0]   id_pc4,
    output reg [31:0]   id_inst
    );
always@(posedge clk_i or negedge rst_n)begin
    if(~rst_n) id_pc <= 32'b0;
    else id_pc <= if_pc;
end

always@(posedge clk_i or negedge rst_n)begin
    if(~rst_n) id_pc4 <= 32'b0;
    else id_pc4 <= if_pc4;
end

always@(posedge clk_i or negedge rst_n)begin
    if(~rst_n) id_inst <= 32'b0;
    else id_inst <= if_inst;
end

endmodule
