`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:24:26 11/25/2018 
// Design Name: 
// Module Name:    grf 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module grf(
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] Wd,
    input We,
    input Clk,
    input Reset,
    output [31:0] Rd1,
    output [31:0] Rd2
    );

	reg [31:0] generalRegister[31:0];
	integer i;
	initial begin
		for(i=0; i<32; i=i+1) begin
			generalRegister[i] = 0;
		end
	end
	
	assign Rd1 = generalRegister[A1];
	assign Rd2 = generalRegister[A2];
	
	always @(posedge Clk) begin
		if (Reset) begin
			for(i=0; i<32; i=i+1) begin
				generalRegister[i] = 0;
			end
		end else begin
			if (We == 1 && A3 != 0) begin
				generalRegister[A3] = Wd;
			end
		end
	end

endmodule
