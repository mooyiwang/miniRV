`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/08 14:43:30
// Design Name: 
// Module Name: hazard_handler
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


module hazard_handler(
    input wire [4:0]    id_rs1,
    input wire [4:0]    id_rs2,
    input wire          id_rf_rE1,
    input wire          id_rf_rE2,
    input wire [4:0]    ex_wR,
    input wire [4:0]    mem_wR,
    input wire [4:0]    wb_wR,
    input wire          ex_rf_wE,
    input wire          mem_rf_wE,
    input wire          wb_rf_wE,
    input wire          ex_load,
    input wire          branch,
    output reg [1:0]   rD1_sel,
    output reg [1:0]   rD2_sel,
    output wire          stall,
    output wire          idex_clear,
    output wire         ifid_clear
    );
wire rs1_id_ex_hazard;
wire rs2_id_ex_hazard;
wire rs1_id_mem_hazard;
wire rs2_id_mem_hazard;
wire rs1_id_wb_hazard;
wire rs2_id_wb_hazard;

assign rs1_id_ex_hazard = (id_rs1 == ex_wR) & ex_rf_wE & id_rf_rE1 & (ex_wR != 5'b0);
assign rs2_id_ex_hazard = (id_rs2 == ex_wR) & ex_rf_wE & id_rf_rE2 & (ex_wR != 5'b0);
assign rs1_id_mem_hazard = ~rs1_id_ex_hazard & (id_rs1 == mem_wR) & mem_rf_wE & id_rf_rE1 & (mem_wR != 5'b0);
assign rs2_id_mem_hazard = ~rs2_id_ex_hazard & (id_rs2 == mem_wR) & mem_rf_wE & id_rf_rE2 & (mem_wR != 5'b0);
assign rs1_id_wb_hazard = ~rs1_id_ex_hazard & ~rs1_id_mem_hazard & (id_rs1 == wb_wR) & wb_rf_wE & id_rf_rE1 & (wb_wR != 5'b0);
assign rs2_id_wb_hazard = ~rs2_id_ex_hazard & ~rs2_id_mem_hazard & (id_rs2 == wb_wR) & wb_rf_wE & id_rf_rE2 & (wb_wR != 5'b0);  

assign stall = ex_load & (rs1_id_ex_hazard | rs2_id_ex_hazard);
assign idex_clear = ex_load & (rs1_id_ex_hazard | rs2_id_ex_hazard);
assign ifid_clear = branch;


always@(*)begin 
    if(~ex_load & rs1_id_ex_hazard) rD1_sel = 2'b01;
    else if(rs1_id_mem_hazard) rD1_sel = 2'b10;
    else if(rs1_id_wb_hazard) rD1_sel = 2'b11;
    else rD1_sel = 2'b00;
end

always@(*)begin 
    if(~ex_load & rs2_id_ex_hazard) rD2_sel = 2'b01;
    else if(rs2_id_mem_hazard) rD2_sel = 2'b10;
    else if(rs2_id_wb_hazard) rD2_sel = 2'b11;
    else rD2_sel = 2'b00;
end
endmodule
