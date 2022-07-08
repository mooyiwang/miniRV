`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/06 15:30:48
// Design Name: 
// Module Name: MEMWB
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


module MEMWB(
    input wire          clk_i,
    input wire          rst_n,
    input wire [31:0]   mem_rf_wD,
    input wire          mem_rf_wE,
    input wire [4:0]    mem_wR,
    output reg [31:0]   wb_rf_wD,
    output reg          wb_rf_wE,
    output reg [4:0]    wb_wR
    );
    
always@(posedge clk_i or negedge rst_n)begin
    if(~rst_n) wb_rf_wD <= 32'b0;
    else wb_rf_wD <= mem_rf_wD;
end
always@(posedge clk_i or negedge rst_n)begin
    if(~rst_n) wb_rf_wE <= 1'b0;
    else wb_rf_wE <= mem_rf_wE;
end
always@(posedge clk_i or negedge rst_n)begin
    if(~rst_n) wb_wR <= 5'b0;
    else wb_wR <= mem_wR;
end


endmodule
