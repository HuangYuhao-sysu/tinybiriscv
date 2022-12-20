//*******************************************************************************
//*        Software       : TSMC MEMORY COMPILER 2010.02.00.a.210a
//*        Technology     : 65nm CMOS LOGIC Low Power LowK Cu 1P9M 1.2V
//*                         Standard-Vt logic, High Density SRAM 6T bit cell
//*        Memory Type    : TSMC 65nm Low Power SP SRAM Without Redundancy
//*        Library Name   : ts1n65lphsa1024x64m4f_210a ( user specify: TS1N65LPHSA1024X64M4F)
//*        Generated Time : 2022/02/24, 21:11:02
//*******************************************************************************

//*******************************************************************************
//*
//*STATEMENT OF USE
//*
//*This information contains confidential and proprietary information of TSMC.
//*No part of this information may be reproduced, transmitted, transcribed,
//*stored in a retrieval system, or translated into any human or computer
//*language, in any form or by any means, electronic, mechanical, magnetic,
//*optical, chemical, manual, or otherwise, without the prior written permission
//*of TSMC. This information was prepared for informational purpose and is for
//*use by TSMC's customers only. TSMC reserves the right to make changes in the
//*information at any time and without notice.
//*
//*******************************************************************************

`timescale 1ns/1ps


module TS1N65LPHSA1024X64M4F (
			CLK, CEB, WEB,
			A, D, BWEB,	

 			WTSEL,
                        RTSEL,
			Q);

			
parameter numWord = 1024;
parameter numRow = 256;
parameter numCM = 4;
parameter numBit = 64;
parameter numWordAddr = 10;
parameter numRowAddr = 8;
parameter numCMAddr = 2;
parameter numSRSize = 10;


//=== IO Ports ===//




// Normal Mode Input
input CLK;
input CEB;
input WEB;
input [numWordAddr-1:0] A;
input [numBit-1:0] D;
input [numBit-1:0] BWEB;


// BIST Mode Input


// Data Output
output [numBit-1:0] Q;



// Test Mode
input [2:0] WTSEL;
input [1:0] RTSEL;


//=== Data Structure ===//
//reg [numBit-1:0] MEMORY [numWord-1:0]  ;
reg [numBit-1:0] Q;
wire [numBit-1:0] Q_tmp;

reg [numBit-1:0] WB;
wire iCEB = CEB;
wire iWEB = WEB;
wire [numWordAddr-1:0] iA = A;
wire [numBit-1:0] iD = D;
wire [numBit-1:0] iBWEB = BWEB;
integer i, j;


//=== Operation ===//

RAM_1bit sram_IO0 (CLK, iCEB, iWEB, iBWEB[0], iA, iD[0], Q_tmp[0]);
RAM_1bit sram_IO1 (CLK, iCEB, iWEB, iBWEB[1], iA, iD[1], Q_tmp[1]);
RAM_1bit sram_IO2 (CLK, iCEB, iWEB, iBWEB[2], iA, iD[2], Q_tmp[2]);
RAM_1bit sram_IO3 (CLK, iCEB, iWEB, iBWEB[3], iA, iD[3], Q_tmp[3]);
RAM_1bit sram_IO4 (CLK, iCEB, iWEB, iBWEB[4], iA, iD[4], Q_tmp[4]);
RAM_1bit sram_IO5 (CLK, iCEB, iWEB, iBWEB[5], iA, iD[5], Q_tmp[5]);
RAM_1bit sram_IO6 (CLK, iCEB, iWEB, iBWEB[6], iA, iD[6], Q_tmp[6]);
RAM_1bit sram_IO7 (CLK, iCEB, iWEB, iBWEB[7], iA, iD[7], Q_tmp[7]);
RAM_1bit sram_IO8 (CLK, iCEB, iWEB, iBWEB[8], iA, iD[8], Q_tmp[8]);
RAM_1bit sram_IO9 (CLK, iCEB, iWEB, iBWEB[9], iA, iD[9], Q_tmp[9]);
RAM_1bit sram_IO10 (CLK, iCEB, iWEB, iBWEB[10], iA, iD[10], Q_tmp[10]);
RAM_1bit sram_IO11 (CLK, iCEB, iWEB, iBWEB[11], iA, iD[11], Q_tmp[11]);
RAM_1bit sram_IO12 (CLK, iCEB, iWEB, iBWEB[12], iA, iD[12], Q_tmp[12]);
RAM_1bit sram_IO13 (CLK, iCEB, iWEB, iBWEB[13], iA, iD[13], Q_tmp[13]);
RAM_1bit sram_IO14 (CLK, iCEB, iWEB, iBWEB[14], iA, iD[14], Q_tmp[14]);
RAM_1bit sram_IO15 (CLK, iCEB, iWEB, iBWEB[15], iA, iD[15], Q_tmp[15]);
RAM_1bit sram_IO16 (CLK, iCEB, iWEB, iBWEB[16], iA, iD[16], Q_tmp[16]);
RAM_1bit sram_IO17 (CLK, iCEB, iWEB, iBWEB[17], iA, iD[17], Q_tmp[17]);
RAM_1bit sram_IO18 (CLK, iCEB, iWEB, iBWEB[18], iA, iD[18], Q_tmp[18]);
RAM_1bit sram_IO19 (CLK, iCEB, iWEB, iBWEB[19], iA, iD[19], Q_tmp[19]);
RAM_1bit sram_IO20 (CLK, iCEB, iWEB, iBWEB[20], iA, iD[20], Q_tmp[20]);
RAM_1bit sram_IO21 (CLK, iCEB, iWEB, iBWEB[21], iA, iD[21], Q_tmp[21]);
RAM_1bit sram_IO22 (CLK, iCEB, iWEB, iBWEB[22], iA, iD[22], Q_tmp[22]);
RAM_1bit sram_IO23 (CLK, iCEB, iWEB, iBWEB[23], iA, iD[23], Q_tmp[23]);
RAM_1bit sram_IO24 (CLK, iCEB, iWEB, iBWEB[24], iA, iD[24], Q_tmp[24]);
RAM_1bit sram_IO25 (CLK, iCEB, iWEB, iBWEB[25], iA, iD[25], Q_tmp[25]);
RAM_1bit sram_IO26 (CLK, iCEB, iWEB, iBWEB[26], iA, iD[26], Q_tmp[26]);
RAM_1bit sram_IO27 (CLK, iCEB, iWEB, iBWEB[27], iA, iD[27], Q_tmp[27]);
RAM_1bit sram_IO28 (CLK, iCEB, iWEB, iBWEB[28], iA, iD[28], Q_tmp[28]);
RAM_1bit sram_IO29 (CLK, iCEB, iWEB, iBWEB[29], iA, iD[29], Q_tmp[29]);
RAM_1bit sram_IO30 (CLK, iCEB, iWEB, iBWEB[30], iA, iD[30], Q_tmp[30]);
RAM_1bit sram_IO31 (CLK, iCEB, iWEB, iBWEB[31], iA, iD[31], Q_tmp[31]);
RAM_1bit sram_IO32 (CLK, iCEB, iWEB, iBWEB[32], iA, iD[32], Q_tmp[32]);
RAM_1bit sram_IO33 (CLK, iCEB, iWEB, iBWEB[33], iA, iD[33], Q_tmp[33]);
RAM_1bit sram_IO34 (CLK, iCEB, iWEB, iBWEB[34], iA, iD[34], Q_tmp[34]);
RAM_1bit sram_IO35 (CLK, iCEB, iWEB, iBWEB[35], iA, iD[35], Q_tmp[35]);
RAM_1bit sram_IO36 (CLK, iCEB, iWEB, iBWEB[36], iA, iD[36], Q_tmp[36]);
RAM_1bit sram_IO37 (CLK, iCEB, iWEB, iBWEB[37], iA, iD[37], Q_tmp[37]);
RAM_1bit sram_IO38 (CLK, iCEB, iWEB, iBWEB[38], iA, iD[38], Q_tmp[38]);
RAM_1bit sram_IO39 (CLK, iCEB, iWEB, iBWEB[39], iA, iD[39], Q_tmp[39]);
RAM_1bit sram_IO40 (CLK, iCEB, iWEB, iBWEB[40], iA, iD[40], Q_tmp[40]);
RAM_1bit sram_IO41 (CLK, iCEB, iWEB, iBWEB[41], iA, iD[41], Q_tmp[41]);
RAM_1bit sram_IO42 (CLK, iCEB, iWEB, iBWEB[42], iA, iD[42], Q_tmp[42]);
RAM_1bit sram_IO43 (CLK, iCEB, iWEB, iBWEB[43], iA, iD[43], Q_tmp[43]);
RAM_1bit sram_IO44 (CLK, iCEB, iWEB, iBWEB[44], iA, iD[44], Q_tmp[44]);
RAM_1bit sram_IO45 (CLK, iCEB, iWEB, iBWEB[45], iA, iD[45], Q_tmp[45]);
RAM_1bit sram_IO46 (CLK, iCEB, iWEB, iBWEB[46], iA, iD[46], Q_tmp[46]);
RAM_1bit sram_IO47 (CLK, iCEB, iWEB, iBWEB[47], iA, iD[47], Q_tmp[47]);
RAM_1bit sram_IO48 (CLK, iCEB, iWEB, iBWEB[48], iA, iD[48], Q_tmp[48]);
RAM_1bit sram_IO49 (CLK, iCEB, iWEB, iBWEB[49], iA, iD[49], Q_tmp[49]);
RAM_1bit sram_IO50 (CLK, iCEB, iWEB, iBWEB[50], iA, iD[50], Q_tmp[50]);
RAM_1bit sram_IO51 (CLK, iCEB, iWEB, iBWEB[51], iA, iD[51], Q_tmp[51]);
RAM_1bit sram_IO52 (CLK, iCEB, iWEB, iBWEB[52], iA, iD[52], Q_tmp[52]);
RAM_1bit sram_IO53 (CLK, iCEB, iWEB, iBWEB[53], iA, iD[53], Q_tmp[53]);
RAM_1bit sram_IO54 (CLK, iCEB, iWEB, iBWEB[54], iA, iD[54], Q_tmp[54]);
RAM_1bit sram_IO55 (CLK, iCEB, iWEB, iBWEB[55], iA, iD[55], Q_tmp[55]);
RAM_1bit sram_IO56 (CLK, iCEB, iWEB, iBWEB[56], iA, iD[56], Q_tmp[56]);
RAM_1bit sram_IO57 (CLK, iCEB, iWEB, iBWEB[57], iA, iD[57], Q_tmp[57]);
RAM_1bit sram_IO58 (CLK, iCEB, iWEB, iBWEB[58], iA, iD[58], Q_tmp[58]);
RAM_1bit sram_IO59 (CLK, iCEB, iWEB, iBWEB[59], iA, iD[59], Q_tmp[59]);
RAM_1bit sram_IO60 (CLK, iCEB, iWEB, iBWEB[60], iA, iD[60], Q_tmp[60]);
RAM_1bit sram_IO61 (CLK, iCEB, iWEB, iBWEB[61], iA, iD[61], Q_tmp[61]);
RAM_1bit sram_IO62 (CLK, iCEB, iWEB, iBWEB[62], iA, iD[62], Q_tmp[62]);
RAM_1bit sram_IO63 (CLK, iCEB, iWEB, iBWEB[63], iA, iD[63], Q_tmp[63]);



assign Q = Q_tmp;

endmodule



// 1 bit SRAM 
module RAM_1bit (CLK_i, CEB_i, WEB_i, BWEB_i, A_i, D_i, Q_i);

parameter numWord = 1024;
parameter numRow = 256;
parameter numCM = 4;
parameter numBit = 64;
parameter numWordAddr = 10;
parameter numRowAddr = 8;
parameter numCMAddr = 2;
parameter numSRSize = 10;

input CLK_i;
input CEB_i;
input WEB_i;
input [0:0] BWEB_i;
input [numWordAddr-1:0] A_i;
input [0:0] D_i;

output [0:0] Q_i;

reg [0:0]Q_i;
reg [0:0] MEMORY [numWord-1:0];


event WRITE_OP;

// Write Mode
and u_aw1_0 (WB, !WEB_i, !CEB_i, !BWEB_i);

always @ (posedge CLK_i)
  if (WB) begin
    MEMORY[A_i] = D_i;
    #0; -> WRITE_OP;
  end

// READ Mode
and u_rw1_0 (RB, WEB_i, !CEB_i);

always @ (posedge CLK_i)
  if (RB) begin
     Q_i = MEMORY[A_i];
  end


endmodule

