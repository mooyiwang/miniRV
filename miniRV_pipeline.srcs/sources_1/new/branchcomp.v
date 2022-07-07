`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/28 15:51:24
// Design Name: 
// Module Name: branchcomp
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


module branchcomp(
    input wire [31:0]   a,
    input wire [31:0]   b,
    input wire          op,
    output reg          eq,
    output reg          lt
    );
    
wire [31:0] c;
assign c = a + ~b + 1'b1;

always@(*)begin 
    if(c == 32'b0) eq = 1'b1;
    else eq = 1'b0;
end

always@(*) begin
    if(c[31]) lt = 1'b1;
    else lt = 1'b0;
end

    
endmodule
