`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:50:50 12/03/2018 
// Design Name: 
// Module Name:    npc 
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
module npc(
    input [31:0] PC4,
    input [25:0] I26,
    input NPCOp,
    output [31:0] NPC
    );
	 
	assign NPC = (NPCOp == 1'b1) ? {PC4[31:28], I26[25:0], 2'b00} :
											 PC4 + {{14{I26[15]}}, I26[15:0], 2'b00};

endmodule
