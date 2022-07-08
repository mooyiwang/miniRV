`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/24 17:03:15
// Design Name: 
// Module Name: ifetch
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


module ifetch(
    input wire          clk_i,
    input wire          rst_n,
    input wire          stall,
    input wire          pc_sel,
    input wire [31:0]   pcbj,
    output reg [31:0]   pc,
    output wire [31:0]  pc4
    );

wire [31:0] pc_next;

assign pc4 = pc + 32'd4;
assign pc_next = pc_sel? pcbj:pc4;

always@(posedge clk_i or negedge rst_n)begin
    if(~rst_n) pc <= 32'b0;
    else if(stall)  pc <= pc;
    else pc <= pc_next;
end

endmodule
