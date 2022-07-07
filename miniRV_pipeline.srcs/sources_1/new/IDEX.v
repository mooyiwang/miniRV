`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/06 15:30:07
// Design Name: 
// Module Name: IDEX
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


module IDEX(
    input wire          clk_i,
    input wire          rst_n,
    input wire          id_rf_wE,
    input wire [31:0]   id_pc4,
    input wire [31:0]   id_rD1,
    input wire [31:0]   id_rD2,
    input wire [31:0]   id_ext,
    input wire [4:0]    id_wR,
    input wire          id_alua_sel,
    input wire          id_alub_sel,
    input wire [2:0]    id_alu_op,
    input wire          id_dmem_wE,
    input wire [1:0]    id_wb_sel,
//    input wire          id_rf_rE1,
//    input wire          id_rf_rE2,
    output reg          ex_rf_wE,
    output reg [31:0]   ex_pc4,
    output reg [31:0]   ex_rD1,
    output reg [31:0]   ex_rD2,
    output reg [31:0]   ex_ext,
    output reg [4:0]    ex_wR,
    output reg          ex_alua_sel,
    output reg          ex_alub_sel,
    output reg [2:0]    ex_alu_op,
    output reg          ex_dmem_wE,
    output reg [1:0]    ex_wb_sel
//    output reg          ex_rf_rE1,
//    output reg          ex_rf_rE2       
    );

//always@(posedge clk_i or negedge rst_n)begin 
//    if(~rst_n) ex_rf_rE1 <= 1'b0;
//    else ex_rf_rE1 <= id_rf_rE1;
//end
//always@(posedge clk_i or negedge rst_n)begin 
//    if(~rst_n) ex_rf_rE2 <= 1'b0;
//    else ex_rf_rE2 <= id_rf_rE2;
//end
always@(posedge clk_i or negedge rst_n)begin 
    if(~rst_n) ex_rf_wE <= 1'b0;
    else ex_rf_wE <= id_rf_wE;
end
always@(posedge clk_i or negedge rst_n)begin 
    if(~rst_n) ex_pc4 <= 32'b0;
    else ex_pc4 <= id_pc4;   
end
always@(posedge clk_i or negedge rst_n)begin 
    if(~rst_n) ex_rD1 <= 32'b0;
    else ex_rD1 <= id_rD1;
end
always@(posedge clk_i or negedge rst_n)begin 
    if(~rst_n) ex_rD2 <= 32'b0;
    else ex_rD2 <= id_rD2;
end
always@(posedge clk_i or negedge rst_n)begin 
    if(~rst_n) ex_ext <= 32'b0;
    else ex_ext <= id_ext;
end
always@(posedge clk_i or negedge rst_n)begin 
    if(~rst_n) ex_wR <= 5'b0;
    else ex_wR <= id_wR;
end
always@(posedge clk_i or negedge rst_n)begin 
    if(~rst_n) ex_alua_sel <= 1'b0;
    else ex_alua_sel <= id_alua_sel;
end
always@(posedge clk_i or negedge rst_n)begin 
    if(~rst_n) ex_alub_sel <= 1'b0;
    else ex_alub_sel <= id_alub_sel;
end
always@(posedge clk_i or negedge rst_n)begin 
    if(~rst_n) ex_alu_op <= 3'b0;
    else ex_alu_op <= id_alu_op;
end
always@(posedge clk_i or negedge rst_n)begin 
    if(~rst_n) ex_dmem_wE <= 1'b0;
    else ex_dmem_wE <= id_dmem_wE;
end
always@(posedge clk_i or negedge rst_n)begin 
    if(~rst_n) ex_wb_sel <= 2'b0;
    else ex_wb_sel <= id_wb_sel;
end
endmodule
