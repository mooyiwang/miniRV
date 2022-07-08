`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/24 14:13:58
// Design Name: 
// Module Name: miniRV
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


module miniRV(
    input wire          clk,
    input wire          rst_n,
    output wire [31:0]  if_pc,
    input wire [31:0]   if_inst,
    output wire [31:0]  adr,
    output wire         wE,
    output wire [31:0]  wD,
    input wire [31:0]   rD
    );

wire jump;
wire pc_beq;
wire pc_bne;
wire pc_blt;
wire pc_bge;
wire pc_sel;
wire [31:0] pcbj;
wire [31:0] if_pc4;
wire [31:0] id_pc;
wire [31:0] id_pc4;
wire [31:0] id_inst;
wire [2:0]  sext_op;
wire        id_rf_wE;
wire        pcbja_sel;
wire        br_op;
wire        id_alua_sel;
wire        id_alub_sel;
wire [2:0]  id_alu_op;
wire        id_dmem_wE;
wire [1:0]  id_wb_sel;
wire [31:0] wb_rf_wD;
wire        wb_rf_wE;
wire [4:0]  wb_wR;
wire [31:0] id_ext;
wire [31:0] id_rD1;
wire [31:0] id_rD2;
wire [4:0]  id_wR;
wire        br_eq;
wire        br_lt;
wire        ex_rf_wE;
wire [31:0] ex_pc4;
wire [31:0] ex_rD1;
wire [31:0] ex_rD2;
wire [31:0] ex_ext;
wire [4:0]  ex_wR;
wire        ex_alua_sel;
wire        ex_alub_sel;
wire [2:0]  ex_alu_op;
wire        ex_dmem_wE;
wire [1:0]  ex_wb_sel;
wire [31:0] ex_c;
wire [31:0] mem_pc4;
wire [31:0] mem_c;
wire        mem_rf_wE;
wire [4:0]  mem_wR;
wire [1:0]  mem_wb_sel;
wire [31:0] mem_rD2;
wire        mem_dmem_wE;
wire [31:0] mem_rf_wD;
wire [31:0] dmem_rD;
wire id_rf_rE1;
wire id_rf_rE2;
wire [1:0] rD1_sel;
wire [1:0] rD2_sel;
wire [31:0] ex_D;
wire [31:0] mem_D;
wire [31:0] wb_D;
wire id_load;
wire ex_load;
wire mem_load;
wire stall;
wire idex_clear;
wire ifid_clear;

assign mem_rf_wD = mem_wb_sel[0]? dmem_rD: (mem_wb_sel[1]? mem_pc4: mem_c);
assign adr = mem_c;
assign wE = mem_dmem_wE;
assign wD = mem_rD2;
assign dmem_rD = rD;
assign ex_D = ex_c;
assign mem_D = mem_load? dmem_rD:mem_c;
assign wb_D = wb_rf_wD;

MEMWB u_memwb(
    .clk_i      (clk),
    .rst_n      (rst_n),
    .mem_rf_wD  (mem_rf_wD),
    .mem_rf_wE  (mem_rf_wE),
    .mem_wR     (mem_wR),
    .wb_rf_wD   (wb_rf_wD),
    .wb_rf_wE   (wb_rf_wE),
    .wb_wR      (wb_wR)
    );

EXMEM u_exmem(
    .clk_i      (clk),
    .rst_n      (rst_n),
    .ex_pc4     (ex_pc4),
    .ex_c       (ex_c),
    .ex_rf_wE   (ex_rf_wE),
    .ex_wR      (ex_wR),
    .ex_wb_sel  (ex_wb_sel),
    .ex_rD2     (ex_rD2),
    .ex_dmem_wE (ex_dmem_wE),
    .ex_load    (ex_load),
    .mem_pc4     (mem_pc4),
    .mem_c       (mem_c),
    .mem_rf_wE   (mem_rf_wE),
    .mem_wR      (mem_wR),
    .mem_wb_sel  (mem_wb_sel),
    .mem_rD2     (mem_rD2),
    .mem_dmem_wE (mem_dmem_wE),
    .mem_load   (mem_load)
    );
    
execute u_execute(
    .rD1        (ex_rD1),
    .rD2        (ex_rD2),
    .ext        (ex_ext),
    .alua_sel   (ex_alua_sel),
    .alub_sel   (ex_alub_sel),
    .alu_op     (ex_alu_op),
    .c          (ex_c)
    );

IDEX u_idex(
    .clk_i      (clk),
    .rst_n      (rst_n),
    .idex_clear (idex_clear),
    .id_rf_wE   (id_rf_wE),
    .id_pc4     (id_pc4),
    .id_rD1     (id_rD1),
    .id_rD2     (id_rD2),
    .id_ext     (id_ext),
    .id_wR      (id_wR),
    .id_alua_sel(id_alua_sel),
    .id_alub_sel(id_alub_sel),
    .id_alu_op  (id_alu_op),
    .id_dmem_wE (id_dmem_wE),
    .id_wb_sel  (id_wb_sel),
    .id_load    (id_load),
    .ex_rf_wE   (ex_rf_wE),
    .ex_pc4     (ex_pc4),
    .ex_rD1     (ex_rD1),
    .ex_rD2     (ex_rD2),
    .ex_ext     (ex_ext),
    .ex_wR      (ex_wR),
    .ex_alua_sel(ex_alua_sel),
    .ex_alub_sel(ex_alub_sel),
    .ex_alu_op  (ex_alu_op),
    .ex_dmem_wE (ex_dmem_wE),
    .ex_wb_sel  (ex_wb_sel),
    .ex_load    (ex_load)
    );

hazard_handler u_hazard_handler(
    .id_rs1     (id_inst[19:15]),
    .id_rs2     (id_inst[24:20]),
    .id_rf_rE1  (id_rf_rE1),
    .id_rf_rE2  (id_rf_rE2),
    .ex_wR      (ex_wR),
    .mem_wR     (mem_wR),
    .wb_wR      (wb_wR),
    .ex_rf_wE   (ex_rf_wE),
    .mem_rf_wE  (mem_rf_wE),
    .wb_rf_wE   (wb_rf_wE),
    .ex_load    (ex_load),
    .branch     (pc_sel),
    .rD1_sel    (rD1_sel),
    .rD2_sel    (rD2_sel),
    .stall      (stall),
    .idex_clear (idex_clear),
    .ifid_clear (ifid_clear)
    );
idecode u_idecode(
    .clk_i      (clk),
    .rst_n      (rst_n),
    .pc         (id_pc),
    .inst       (id_inst),
    .wD         (wb_rf_wD),
    .sext_op    (sext_op),
    .br_op      (br_op),
    .rf_wE      (wb_rf_wE),
    .rf_wR      (wb_wR),
    .pcbja_sel  (pcbja_sel),
    .rD1_sel    (rD1_sel),
    .rD2_sel    (rD2_sel),
    .ex_D       (ex_D),
    .mem_D      (mem_D),
    .wb_D       (wb_D),
    .ext        (id_ext),
    .rD1        (id_rD1),
    .rD2        (id_rD2),
    .wR         (id_wR),
    .br_eq      (br_eq),
    .br_lt      (br_lt),
    .pcbj       (pcbj)
    );

control u_control(
    .opcode     (id_inst[6:0]),
    .func3      (id_inst[14:12]),
    .func7      (id_inst[31:25]),
    .pc_jump    (jump),
    .pc_beq     (pc_beq),
    .pc_bne     (pc_bne),
    .pc_blt     (pc_blt),
    .pc_bge     (pc_bge),
    .sext_op    (sext_op),
    .rf_we      (id_rf_wE),
    .pcbja_sel  (pcbja_sel),
    .br_op      (br_op),
    .alua_sel   (id_alua_sel),
    .alub_sel   (id_alub_sel),
    .alu_op     (id_alu_op),
    .dmem_we    (id_dmem_wE),
    .wd_sel     (id_wb_sel),
    .rf_rE1     (id_rf_rE1),
    .rf_rE2     (id_rf_rE2),
    .load       (id_load)
    );


IFID u_ifid(
    .clk_i      (clk),
    .rst_n      (rst_n),
    .stall      (stall),
    .ifid_clear (ifid_clear),
    .if_pc      (if_pc),
    .if_pc4     (if_pc4),
    .if_inst    (if_inst),
    .id_pc      (id_pc),
    .id_pc4     (id_pc4),
    .id_inst    (id_inst)
    );

assign pc_sel = jump | (pc_beq & br_eq) | (pc_bne & ~br_eq) | (pc_blt & br_lt) | (pc_bge & ~br_lt);


ifetch u_ifetch(
    .clk_i      (clk),
    .rst_n      (rst_n),
    .stall      (stall),
    .pc_sel     (pc_sel),
    .pcbj       (pcbj),
    .pc         (if_pc),
    .pc4        (if_pc4)
    );
    

    
    
endmodule
