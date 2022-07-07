`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/06 15:30:30
// Design Name: 
// Module Name: EXMEM
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


module EXMEM(
    input wire          clk_i,
    input wire          rst_n,
    input wire [31:0]   ex_pc4,
    input wire [31:0]   ex_c,
    input wire          ex_rf_wE,
    input wire [4:0]    ex_wR,
    input wire [1:0]    ex_wb_sel,
    input wire [31:0]   ex_rD2,
    input wire          ex_dmem_wE,
    input wire          ex_rf_rE1,
    input wire          ex_rf_rE2,
    output reg [31:0]   mem_pc4,
    output reg [31:0]   mem_c,
    output reg          mem_rf_wE,
    output reg [4:0]    mem_wR,
    output reg [1:0]    mem_wb_sel,
    output reg [31:0]   mem_rD2,
    output reg          mem_dmem_wE,
    output reg          mem_rf_rE1,
    output reg          mem_rf_rE2
    );


always@(posedge clk_i or negedge rst_n)begin 
    if(~rst_n) mem_rf_rE1 <= 1'b0;
    else mem_rf_rE1 <= ex_rf_rE1;
end
always@(posedge clk_i or negedge rst_n)begin 
    if(~rst_n) mem_rf_rE2 <= 1'b0;
    else mem_rf_rE2 <= ex_rf_rE2;
end
always@(posedge clk_i or negedge rst_n)begin 
    if(~rst_n) mem_pc4 <= 32'b0;
    else mem_pc4 <= ex_pc4;
end
always@(posedge clk_i or negedge rst_n)begin 
    if(~rst_n) mem_c <= 32'b0;
    else mem_c <= ex_c;
end
always@(posedge clk_i or negedge rst_n)begin 
    if(~rst_n) mem_rf_wE <= 1'b0;
    else mem_rf_wE <= ex_rf_wE;
end
always@(posedge clk_i or negedge rst_n)begin 
    if(~rst_n) mem_wR <= 5'b0;
    else mem_wR <= ex_wR;
end
always@(posedge clk_i or negedge rst_n)begin 
    if(~rst_n) mem_wb_sel <= 2'b0;
    else mem_wb_sel <= ex_wb_sel;
end
always@(posedge clk_i or negedge rst_n)begin 
    if(~rst_n) mem_rD2 <= 32'b0;
    else mem_rD2 <= ex_rD2;
end
always@(posedge clk_i or negedge rst_n)begin 
    if(~rst_n) mem_dmem_wE <= 1'b0; 
    else mem_dmem_wE <= ex_dmem_wE;
end
    





endmodule
