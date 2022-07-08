`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/07 17:26:31
// Design Name: 
// Module Name: hazard_detect
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


module hazard_detect(
    input wire [4:0]    id_rs1,
    input wire [4:0]    id_rs2,
    input wire          id_rf_rE1,
    input wire          id_rf_rE2,
    input wire [4:0]    ex_rd,
    input wire [4:0]    mem_rd,
    input wire [4:0]    wb_rd,
    input wire          ex_rf_wE,
    input wire          mem_rf_wE,
    input wire          wb_rf_wE,
    output reg [1:0]   rD1_sel,
    output reg [1:0]   rD2_sel
    );
wire rs1_id_ex_hazard;
wire rs2_id_ex_hazard;
wire rs1_id_mem_hazard;
wire rs2_id_mem_hazard;
wire rs1_id_wb_hazard;
wire rs2_id_wb_hazard;

assign rs1_id_ex_hazard = (id_rs1 == ex_rd) & ex_rf_wE & id_rf_rE1 & (ex_rd != 5'b0);
assign rs2_id_ex_hazard = (id_rs2 == ex_rd) & ex_rf_wE & id_rf_rE2 & (ex_rd != 5'b0);
assign rs1_id_mem_hazard = ~rs1_id_ex_hazard & (id_rs1 == mem_rd) & mem_rf_wE & id_rf_rE1 & (ex_rd != 5'b0);
assign rs2_id_mem_hazard = ~rs2_id_ex_hazard & (id_rs2 == mem_rd) & mem_rf_wE & id_rf_rE2 & (ex_rd != 5'b0);
assign rs1_id_wb_hazard = ~rs1_id_ex_hazard & ~rs1_id_mem_hazard & (id_rs1 == wb_rd) & wb_rf_wE & id_rf_rE1 & (ex_rd != 5'b0);
assign rs2_id_wb_hazard = ~rs2_id_ex_hazard & ~rs2_id_mem_hazard & (id_rs2 == wb_rd) & wb_rf_wE & id_rf_rE2 & (ex_rd != 5'b0);  

always@(*)begin 
    if(rs1_id_ex_hazard) rD1_sel = 2'b01;
    else if(rs1_id_mem_hazard) rD1_sel = 2'b10;
    else if(rs1_id_wb_hazard) rD1_sel = 2'b11;
    else rD1_sel = 2'b00;
end

always@(*)begin 
    if(rs2_id_ex_hazard) rD2_sel = 2'b01;
    else if(rs2_id_mem_hazard) rD2_sel = 2'b10;
    else if(rs2_id_wb_hazard) rD2_sel = 2'b11;
    else rD2_sel = 2'b00;
end

endmodule
