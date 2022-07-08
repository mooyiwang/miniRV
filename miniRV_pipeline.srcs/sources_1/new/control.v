`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/30 16:24:24
// Design Name: 
// Module Name: control
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


module control(
    input wire [6:0]    opcode,
    input wire [2:0]    func3,
    input wire [6:0]    func7,
    output reg          pc_jump,
    output reg          pc_beq,
    output reg          pc_bne,
    output reg          pc_blt,
    output reg          pc_bge,
    output reg [2:0]    sext_op,
    output reg          rf_we,
    output reg          pcbja_sel,
    output wire          br_op,
    output reg          alua_sel,
    output reg          alub_sel,
    output reg [2:0]    alu_op,
    output reg          dmem_we,
    output reg [1:0]    wd_sel,
    output reg          rf_rE1,
    output reg          rf_rE2,
    output reg          load
    );

//only consider the 24 instructions
always@(*)begin
    if(opcode==7'h03) load = 1'b1;
    else load = 1'b0;
end

always@(*)begin
    if(opcode==7'h23 || opcode==7'h63) rf_we = 1'b0;
    else rf_we = 1'b1;
end

always@(*)begin
    if(opcode==7'h37 || opcode==7'h6F) rf_rE1 = 1'b0;
    else rf_rE1 = 1'b1;
end

always@(*)begin 
    if(opcode==7'h33 || opcode==7'h23 || opcode==7'h63) rf_rE2 = 1'b1;
    else rf_rE2 = 1'b0;
end

always@(*)begin 
    if(opcode==7'h33 || opcode==7'h13 || opcode==7'h37) wd_sel = 2'b00;
    else if(opcode==7'h03)  wd_sel = 2'b01;
    else if(opcode==7'h67 || opcode==7'h6f)  wd_sel = 2'b10;
end

always@(*)begin 
    if(opcode==7'h03 || opcode==7'h13 || opcode==7'h67) sext_op = 3'b000;
    else if(opcode==7'h23) sext_op = 3'b001;
    else if(opcode==7'h63) sext_op = 3'b010;
    else if(opcode==7'h37) sext_op = 3'b011;
    else if(opcode==7'h6f) sext_op = 3'b100;
end

always@(*)begin 
    if(opcode==7'h67)  pcbja_sel = 1'b0;
    else if(opcode==7'h63 || opcode==7'h6f) pcbja_sel = 1'b1;
end

always@(*)begin 
    if((opcode==7'h33 && func3==3'h0 && func7==7'h00) ||
       (opcode==7'h13 && func3==3'h0)||
       (opcode==7'h03)||
       (opcode==7'h23)||
       (opcode==7'h37))     alu_op = 3'b000;
    else if((opcode==7'h33 && func3==3'h0 && func7==7'h20))   alu_op = 3'b001;
    else if((opcode==7'h33 && func3==3'h7 && func7==7'h00) ||
            (opcode==7'h13 && func3==3'h7 ))                    alu_op = 3'b010;
    else if((opcode==7'h33 && func3==3'h6 && func7==7'h00) ||
            (opcode==7'h13 && func3==3'h6 ))                    alu_op = 3'b011;
    else if((opcode==7'h33 && func3==3'h4 && func7==7'h00) ||
            (opcode==7'h13 && func3==3'h4 ))                    alu_op = 3'b100;
    else if((opcode==7'h33 && func3==3'h1 && func7==7'h00) ||
            (opcode==7'h13 && func3==3'h1 && func7==7'h00))     alu_op = 3'b101;
    else if((opcode==7'h33 && func3==3'h5 && func7==7'h00) ||
            (opcode==7'h13 && func3==3'h5 && func7==7'h00))     alu_op = 3'b110;
    else if((opcode==7'h33 && func3==3'h5 && func7==7'h20) ||
            (opcode==7'h13 && func3==3'h5 && func7==7'h20))     alu_op = 3'b111;
end

always@(*)begin 
    if(opcode==7'h37) alua_sel = 1'b1;
    else alua_sel = 1'b0;
end

always@(*)begin 
    if(opcode==7'h33) alub_sel = 1'b0;
    else alub_sel = 1'b1;
end 

always@(*)begin 
    if(opcode==7'h23) dmem_we = 1'b1;
    else dmem_we = 1'b0;
end 

assign br_op = 1'b0;

always@(*)begin
    if(opcode==7'h67 || opcode==7'h6f) pc_jump = 1'b1;
    else pc_jump = 1'b0;
end
always@(*)begin
    if(opcode==7'h63 && func3==3'h0) pc_beq = 1'b1;
    else pc_beq = 1'b0;
end
always@(*)begin
    if(opcode==7'h63 && func3==3'h1) pc_bne = 1'b1;
    else pc_bne = 1'b0;
end
always@(*)begin
    if(opcode==7'h63 && func3==3'h4) pc_blt = 1'b1;
    else pc_blt = 1'b0;
end
always@(*)begin
    if(opcode==7'h63 && func3==3'h5) pc_bge = 1'b1;
    else pc_bge = 1'b0;
end

endmodule
