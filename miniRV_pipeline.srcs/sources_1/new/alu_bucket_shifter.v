`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/30 14:38:08
// Design Name: 
// Module Name: alu_bucket_shifter
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


module alu_bucket_shifter(
    input wire [31:0]   a,
    input wire [31:0]   b,
    input wire [1:0]    op,
    output wire [31:0]   c
    );

reg [31:0] res;
assign c = res;

always@(*) begin 
    case(op)
        2'b00, 2'b11:begin
            res = b[0]? {a[30:0], 1'b0} : a;
            res = b[1]? {res[29:0], 2'b0} : res;
            res = b[2]? {res[27:0], 4'b0} : res;
            res = b[3]? {res[23:0], 8'b0} : res;
            res = b[4]? {res[15:0], 16'b0} : res;
        end
        2'b01:begin
            res = b[0]? {1'b0, a[31:1]} : a;
            res = b[1]? {2'b0, res[31:2]} : res;
            res = b[2]? {4'b0, res[31:4]} : res;
            res = b[3]? {8'b0, res[31:8]} : res;
            res = b[4]? {16'b0, res[31:16]} : res;
        end
        2'b10:begin 
            res = b[0]? {a[31],a[31:1]} : a;
            res = b[1]? {{2{res[31]}},res[31:2]} : res;
            res = b[2]? {{4{res[31]}}, res[31:4]} : res;
            res = b[3]? {{8{res[31]}}, res[31:8]} : res;
            res = b[4]? {{16{res[31]}}, res[31:16]} : res;
        end
    endcase
end

endmodule
