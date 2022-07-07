`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/24 17:08:56
// Design Name: 
// Module Name: rsfile
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


module rsfile(
    input wire          clk_i,
    input wire          rst_n,
    input wire [4 :0]   rR1,
    input wire [4 :0]   rR2,
    input wire [4 :0]   wR,
    input wire          wE,
    input wire [31:0]   wD,
    output wire [31:0]   rD1,
    output wire [31:0]   rD2
    );

reg [31:0] REGS[31:0];     
integer i = 0;

always@(posedge clk_i or negedge rst_n) begin
    if(~rst_n) begin 
        for(i=0; i<32; i=i+1) begin
            REGS[i] <= 32'b0;
        end
    end
    else if(wE) begin
        if(wR) REGS[wR] <= wD;
    end
end
        

assign rD1 = REGS[rR1];
assign rD2 = REGS[rR2];

endmodule
