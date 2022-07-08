`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/28 14:38:08
// Design Name: 
// Module Name: idecode
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


module idecode(
    input wire          clk_i,
    input wire          rst_n,
    input wire [31:0]   pc,
    input wire [31:0]   inst,
    input wire [31:0]   wD,
    input wire [2:0]    sext_op,
    input wire          br_op,
    input wire          rf_wE,
    input wire [4:0]    rf_wR,
    input wire          pcbja_sel,
    input wire [1:0]    rD1_sel,
    input wire [1:0]    rD2_sel,
    input wire [31:0]   ex_D,
    input wire [31:0]   mem_D,
    input wire [31:0]   wb_D,
    output wire [31:0]  ext,
    output wire [31:0]  rD1,
    output wire [31:0]  rD2,
    output wire [4:0]   wR,
    output wire         br_eq,
    output wire         br_lt,
    output wire [31:0]  pcbj
    );

wire [31:0] rf_rD1;
wire [31:0] rf_rD2;
assign wR = inst[11:7];
assign rD1= rD1_sel[0]? (rD1_sel[1]? wb_D: ex_D):(rD1_sel[1]? mem_D: rf_rD1);
assign rD2 = rD2_sel[0]? (rD2_sel[1]? wb_D: ex_D):(rD2_sel[1]? mem_D: rf_rD2);

sext u_sext(
    .imm        (inst[31:7]),
    .op         (sext_op),
    .ext        (ext)
    );

rsfile u_rsfile(
    .clk_i      (clk_i),
    .rst_n      (rst_n),
    .rR1        (inst[19:15]),
    .rR2        (inst[24:20]),
    .wR         (rf_wR),
    .wE         (rf_wE),
    .wD         (wD),
    .rD1        (rf_rD1),
    .rD2        (rf_rD2)
    );
wire [31:0] base;
assign base = pcbja_sel? pc:rD1;
assign pcbj = base + ext;

branchcomp u_branchcomp(
    .a          (rD1),
    .b          (rD2),
    .op         (br_op),
    .eq         (br_eq),
    .lt         (br_lt)
    );

endmodule
