`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:07:51 12/04/2018 
// Design Name: 
// Module Name:    hazard 
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
module hazard(
    input [31:0] Instr,
    input Clk,
    input Reset,
    output StallF,
    output StallD,
    output FlushE,
    output [2:0] Forward_RS_D_Sel,
    output [2:0] Forward_RT_D_Sel,
    output [2:0] Forward_RS_E_Sel,
    output [2:0] Forward_RT_E_Sel,
    output [2:0] Forward_RT_M_Sel
    );

	`include "header.v"
	
	wire [4:0] A1D, A2D, A3D;
	wire [3:0] icD;
	reg [4:0] A1E, A2E, A3E, A1M, A2M, A3M, A1W, A2W, A3W;
	reg [3:0] icE, icM, icW;
	
	// Stall
	wire stall;
	assign StallF = stall;
	assign StallD = stall;
	assign FlushE = stall;
	
	assign stall = stall_E || stall_M;
		assign stall_E = (A3E != 5'b0 && (
							  (icE == `hzd_cal_r && stall_E_cal_r) || 
							  (icE == `hzd_cal_i && stall_E_cal_i) || 
							  (icE == `hzd_load && stall_E_load)));
			assign stall_E_cal_r = ((icD == `hzd_b && 
												((A1D != 5'b0 && A1D == A3E) || (A2D != 5'b0 && A2D == A3E))) || 
										  (icD == `hzd_jr && 
												A1D != 5'b0 && A1D == A3E) || 
										  (icD == `hzd_jalr && 
												A1D != 5'b0 && A1D == A3E));
			assign stall_E_cal_i = ((icD == `hzd_b && 
												((A1D != 5'b0 && A1D == A3E) || (A2D != 5'b0 && A2D == A3E))) || 
										  (icD == `hzd_jr && 
												A1D != 5'b0 && A1D == A3E) || 
										  (icD == `hzd_jalr && 
												A1D != 5'b0 && A1D == A3E));
			assign stall_E_load = ((icD == `hzd_b && 
												((A1D != 5'b0 && A1D == A3E) || (A2D != 5'b0 && A2D == A3E))) ||
										 (icD == `hzd_cal_r && 
												(A1D == A3E || A2D == A3E)) ||
										 (icD == `hzd_cal_i && 
												A1D != 5'b0 && A1D == A3E) ||
										 (icD == `hzd_load && 
												A1D != 5'b0 && A1D == A3E) ||
										 (icD == `hzd_store && 
												A1D != 5'b0 && A1D == A3E) ||
										 (icD == `hzd_jr && 
												A1D != 5'b0 && A1D == A3E) || 
										 (icD == `hzd_jalr && 
												A1D != 5'b0 && A1D == A3E));
		assign stall_M = (A3M != 5'b0 && 
							  icM == `hzd_load && stall_M_load);
			assign stall_M_load = ((icD == `hzd_b && 
												(A1D != 5'b0 && A1D == A3M || A2D != 5'b0 && A2D == A3M)) || 
										 (icD == `hzd_jr && 
												A1D != 5'b0 && A1D == A3M) || 
										 (icD == `hzd_jalr && 
												A1D != 5'b0 && A1D == A3M));
	
	// Forward
	assign Forward_RS_D_Sel = ((A1D != 5'b0 && A3E != 5'b0 && A1D == A3E && 
												(icE == `hzd_jal || icE == `hzd_jalr)) ? `mf_pc4e :
										(A1D != 5'b0 && A3M != 5'b0 && A1D == A3M && 
												(icM == `hzd_cal_r || icM == `hzd_cal_i)) ? `mf_ao :
										(A1D != 5'b0 && A3M != 5'b0 && A1D == A3M && 
												(icM == `hzd_jal || icM == `hzd_jalr)) ? `mf_pc4m :
										(A1D != 5'b0 && A3W != 5'b0 && A1D == A3W && 
												(icW == `hzd_cal_r || icW == `hzd_cal_i || icW == `hzd_load || icW == `hzd_jal || icW == `hzd_jalr)) ? `mf_wd :
										`mf_rd);
	
	assign Forward_RT_D_Sel = ((A2D != 5'b0 && A3E != 5'b0 && A2D == A3E && 
												(icE == `hzd_jal || icE == `hzd_jalr)) ? `mf_pc4e :
										(A2D != 5'b0 && A3M != 5'b0 && A2D == A3M && 
												(icM == `hzd_cal_r || icM == `hzd_cal_i)) ? `mf_ao :
										(A2D != 5'b0 && A3M != 5'b0 && A2D == A3M && 
												(icM == `hzd_jal || icM == `hzd_jalr)) ? `mf_pc4m :
										(A2D != 5'b0 && A3W != 5'b0 && A2D == A3W && 
												(icW == `hzd_cal_r || icW == `hzd_cal_i || icW == `hzd_load || icW == `hzd_jal || icW == `hzd_jalr)) ? `mf_wd :
										`mf_rd);
	
	assign Forward_RS_E_Sel = ((A1E != 5'b0 && A3M != 5'b0 && A1E == A3M && 
												(icM == `hzd_cal_r || icM == `hzd_cal_i)) ? `mf_ao :
										(A1E != 5'b0 && A3M != 5'b0 && A1E == A3M && 
												(icM == `hzd_jal || icM == `hzd_jalr)) ? `mf_pc4m :
										(A1E != 5'b0 && A3W != 5'b0 && A1E == A3W && 
												(icW == `hzd_cal_r || icW == `hzd_cal_i || icW == `hzd_load || icW == `hzd_jal || icW == `hzd_jalr)) ? `mf_wd :
										`mf_rd);
	
	assign Forward_RT_E_Sel = ((A2E != 5'b0 && A3M != 5'b0 && A2E == A3M && 
												(icM == `hzd_cal_r || icM == `hzd_cal_i)) ? `mf_ao :
										(A2E != 5'b0 && A3M != 5'b0 && A2E == A3M && 
												(icM == `hzd_jal || icM == `hzd_jalr)) ? `mf_pc4m :
										(A2E != 5'b0 && A3W != 5'b0 && A2E == A3W && 
												(icW == `hzd_cal_r || icW == `hzd_cal_i || icW == `hzd_load || icW == `hzd_jal || icW == `hzd_jalr)) ? `mf_wd :
										`mf_rd);
	
	assign Forward_RT_M_Sel = ((A2M != 5'b0 && A3W != 5'b0 && A2M == A3W && 
												(icW == `hzd_cal_r || icW == `hzd_cal_i || icW == `hzd_load || icW == `hzd_jal || icW == `hzd_jalr)) ? `mf_wd :
										`mf_rd);
	
	
	initial begin
		A1E = 5'b0; A2E = 5'b0; A3E = 5'b0; 
		A1M = 5'b0; A2M = 5'b0; A3M = 5'b0; 
		A1W = 5'b0; A2W = 5'b0; A3W = 5'b0; 
		icE = 4'b0; icM = 4'b0; icW = 4'b0;
	end
	always @(posedge Clk) begin
		if (Reset) begin
			A1E <= 5'b0; A2E <= 5'b0; A3E <= 5'b0; 
			A1M <= 5'b0; A2M <= 5'b0; A3M <= 5'b0; 
			A1W <= 5'b0; A2W <= 5'b0; A3W <= 5'b0; 
			icE <= 4'b0; icM <= 4'b0; icW <= 4'b0;
		end else if (stall) begin
			A1E <= 5'b0; A2E <= 5'b0; A3E <= 5'b0; 
			A1M <= A1E; A2M <= A2E; A3M <= A3E; 
			A1W <= A1M; A2W <= A2M; A3W <= A3M; 
			icE <= icD; icM <= icE; icW <= icM;
		end else begin
			A1E <= A1D; A2E <= A2D; A3E <= A3D; 
			A1M <= A1E; A2M <= A2E; A3M <= A3E; 
			A1W <= A1M; A2W <= A2M; A3W <= A3M; 
			icE <= icD; icM <= icE; icW <= icM;
		end
	end
	
	ATDecoder at (
    .Instr(Instr), 
    .A1(A1D), 
    .A2(A2D), 
    .A3(A3D), 
    .ic(icD)
    );
	 


endmodule
