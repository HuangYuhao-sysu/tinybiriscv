//////////////////////////////////////////////////////////////////////////////////////
//*                                                                              */
//*STATEMENT OF USE                                                              */
//*                                                                              */
//*This information contains confidential and proprietary information of TSMC.   */
//*No part of this information may be reproduced, transmitted, transcribed,      */
//*stored in a retrieval system, or translated into any human or computer        */
//*language, in any form or by any means, electronic, mechanical, magnetic,      */
//*optical, chemical, manual, or otherwise, without the prior written permission */
//*of TSMC. This information was prepared for informational purpose and is for   */
//*use by TSMC's customers only. TSMC reserves the right to make changes in the  */
//*information at any time and without notice.                                   */
//*                                                                              */
///*******************************************************************************/
//*                                                                              */
//*      Usage Limitation: PLEASE READ CAREFULLY FOR CORRECT USAGE               */
//*                                                                              */
//* The model doesn't support the control enable, data and address signals       */
//* transition at positive clock edge.                                           */
//* Please have some timing delays between control/data/address and clock signals*/
//* to ensure the correct behavior.                                              */
//*                                                                              */
//* Please be careful when using non 2^n  memory.                                */
//* In a non-fully decoded array, a write cycle to a nonexistent address location*/
//* does not change the memory array contents and output remains the same.       */
//* In a non-fully decoded array, a read cycle to a nonexistent address location */
//* does not change the memory array contents but the output becomes unknown.    */
//*                                                                              */
//* In the verilog model, the behavior of unknown clock will corrupt the         */
//* memory data and make output unknown regardless of CEB signal.  But in the    */
//* silicon, the unknown clock at CEB high, the memory and output data will be   */
//* held. The verilog model behavior is more conservative in this condition.     */
//*                                                                              */
//* The model doesn't identify physical column and row address                   */
//*                                                                              */
//* The verilog model provides UNIT_DELAY mode for the fast function simulation. */
//* All timing values in the specification are not checked in the UNIT_DELAY mode*/
//* simulation.                                                                  */
//*                                                                              */
//* Template Version : S_01_33101                                                */
//****************************************************************************** */
//*      Macro Usage       : (+define[MACRO] for Verilog compiliers)             */
//* +TSMC_UNIT_DELAY : Enable fast function simulation.                          */
//* +TSMC_NO_WARNING : Disable all runtime warning messages from this model.     */
//* +TSMC_INITIALIZE_MEM : Initialize the memory data in verilog format.         */
//* +TSMC_INITIALIZE_FAULT : Initialize the memory fault data in verilog format. */
//* +TSMC_NO_TESTPINS_WARNING : Disable the wrong test pins connection error     */
//*                             message if necessary.                            */
//****************************************************************************** */
//*        Software         : TSMC MEMORY COMPILER 2010.02.00.a
//*        Technology       : 65 nm CMOS LOGIC Low Power 1P9M 1.2V
//*        Memory Type      : TSMC 65nm Low Power High Performance Single Port SRAM
//*        Library Name     : ts1n65lphsa1024x64m4f (user specify : TS1N65LPHSA1024X64M4F)
//*        Library Version  : 210a
//*        Generated Time   : 2022/02/24, 21:11:02
//*******************************************************************************
`celldefine

`ifdef TSMC_UNIT_DELAY
    `define SRAM_DELAY 0.001000
`endif





module TS1N65LPHSA1024X64M4F(
    A,
    D,
    BWEB,
    WEB,
    CEB,
    CLK,
    RTSEL,
    WTSEL,




    Q
);

// Parameter declarations
parameter N  = 64;                                      // word width
parameter W  = 1024;                                    // word depth
parameter M  = 10;                                      // address width
parameter ADR_WIDTH_COL = 2;                            // column address width
parameter ADR_WIDTH_ROW = M - ADR_WIDTH_COL;            // row address width
parameter MUX = 4;                                     // column mux width


input [M - 1:0] A;         // write address bus
input [N - 1:0] D;          // input data bus
input [N - 1:0] BWEB;       // active-low bit-wise write-enable bus
input WEB;                  // active-low write-enable
input CEB;                  // active-low chip select
input CLK;                 // write clock




output [N - 1:0] Q;

// Test Mode
input [1:0] RTSEL;
input [2:0] WTSEL;

wire [1:0] RTSEL_i;
wire [2:0] WTSEL_i;

wire [N - 1:0] b_D;
wire [N - 1:0] b_BWEB;
wire [M - 1:0] b_A;

wire b_WEB;
wire b_CEB;


wire b_CLK;


reg [N - 1:0] Q_n;


wire CE = ~CEB;
wire WE = ~CEB & ~WEB;
// Register File  Control Signal Buffers
//      Normal

buf iD0 (b_D[0], D[0]);
buf iD1 (b_D[1], D[1]);
buf iD2 (b_D[2], D[2]);
buf iD3 (b_D[3], D[3]);
buf iD4 (b_D[4], D[4]);
buf iD5 (b_D[5], D[5]);
buf iD6 (b_D[6], D[6]);
buf iD7 (b_D[7], D[7]);
buf iD8 (b_D[8], D[8]);
buf iD9 (b_D[9], D[9]);
buf iD10 (b_D[10], D[10]);
buf iD11 (b_D[11], D[11]);
buf iD12 (b_D[12], D[12]);
buf iD13 (b_D[13], D[13]);
buf iD14 (b_D[14], D[14]);
buf iD15 (b_D[15], D[15]);
buf iD16 (b_D[16], D[16]);
buf iD17 (b_D[17], D[17]);
buf iD18 (b_D[18], D[18]);
buf iD19 (b_D[19], D[19]);
buf iD20 (b_D[20], D[20]);
buf iD21 (b_D[21], D[21]);
buf iD22 (b_D[22], D[22]);
buf iD23 (b_D[23], D[23]);
buf iD24 (b_D[24], D[24]);
buf iD25 (b_D[25], D[25]);
buf iD26 (b_D[26], D[26]);
buf iD27 (b_D[27], D[27]);
buf iD28 (b_D[28], D[28]);
buf iD29 (b_D[29], D[29]);
buf iD30 (b_D[30], D[30]);
buf iD31 (b_D[31], D[31]);
buf iD32 (b_D[32], D[32]);
buf iD33 (b_D[33], D[33]);
buf iD34 (b_D[34], D[34]);
buf iD35 (b_D[35], D[35]);
buf iD36 (b_D[36], D[36]);
buf iD37 (b_D[37], D[37]);
buf iD38 (b_D[38], D[38]);
buf iD39 (b_D[39], D[39]);
buf iD40 (b_D[40], D[40]);
buf iD41 (b_D[41], D[41]);
buf iD42 (b_D[42], D[42]);
buf iD43 (b_D[43], D[43]);
buf iD44 (b_D[44], D[44]);
buf iD45 (b_D[45], D[45]);
buf iD46 (b_D[46], D[46]);
buf iD47 (b_D[47], D[47]);
buf iD48 (b_D[48], D[48]);
buf iD49 (b_D[49], D[49]);
buf iD50 (b_D[50], D[50]);
buf iD51 (b_D[51], D[51]);
buf iD52 (b_D[52], D[52]);
buf iD53 (b_D[53], D[53]);
buf iD54 (b_D[54], D[54]);
buf iD55 (b_D[55], D[55]);
buf iD56 (b_D[56], D[56]);
buf iD57 (b_D[57], D[57]);
buf iD58 (b_D[58], D[58]);
buf iD59 (b_D[59], D[59]);
buf iD60 (b_D[60], D[60]);
buf iD61 (b_D[61], D[61]);
buf iD62 (b_D[62], D[62]);
buf iD63 (b_D[63], D[63]);

buf iBWEB0 (b_BWEB[0], BWEB[0]);
buf iBWEB1 (b_BWEB[1], BWEB[1]);
buf iBWEB2 (b_BWEB[2], BWEB[2]);
buf iBWEB3 (b_BWEB[3], BWEB[3]);
buf iBWEB4 (b_BWEB[4], BWEB[4]);
buf iBWEB5 (b_BWEB[5], BWEB[5]);
buf iBWEB6 (b_BWEB[6], BWEB[6]);
buf iBWEB7 (b_BWEB[7], BWEB[7]);
buf iBWEB8 (b_BWEB[8], BWEB[8]);
buf iBWEB9 (b_BWEB[9], BWEB[9]);
buf iBWEB10 (b_BWEB[10], BWEB[10]);
buf iBWEB11 (b_BWEB[11], BWEB[11]);
buf iBWEB12 (b_BWEB[12], BWEB[12]);
buf iBWEB13 (b_BWEB[13], BWEB[13]);
buf iBWEB14 (b_BWEB[14], BWEB[14]);
buf iBWEB15 (b_BWEB[15], BWEB[15]);
buf iBWEB16 (b_BWEB[16], BWEB[16]);
buf iBWEB17 (b_BWEB[17], BWEB[17]);
buf iBWEB18 (b_BWEB[18], BWEB[18]);
buf iBWEB19 (b_BWEB[19], BWEB[19]);
buf iBWEB20 (b_BWEB[20], BWEB[20]);
buf iBWEB21 (b_BWEB[21], BWEB[21]);
buf iBWEB22 (b_BWEB[22], BWEB[22]);
buf iBWEB23 (b_BWEB[23], BWEB[23]);
buf iBWEB24 (b_BWEB[24], BWEB[24]);
buf iBWEB25 (b_BWEB[25], BWEB[25]);
buf iBWEB26 (b_BWEB[26], BWEB[26]);
buf iBWEB27 (b_BWEB[27], BWEB[27]);
buf iBWEB28 (b_BWEB[28], BWEB[28]);
buf iBWEB29 (b_BWEB[29], BWEB[29]);
buf iBWEB30 (b_BWEB[30], BWEB[30]);
buf iBWEB31 (b_BWEB[31], BWEB[31]);
buf iBWEB32 (b_BWEB[32], BWEB[32]);
buf iBWEB33 (b_BWEB[33], BWEB[33]);
buf iBWEB34 (b_BWEB[34], BWEB[34]);
buf iBWEB35 (b_BWEB[35], BWEB[35]);
buf iBWEB36 (b_BWEB[36], BWEB[36]);
buf iBWEB37 (b_BWEB[37], BWEB[37]);
buf iBWEB38 (b_BWEB[38], BWEB[38]);
buf iBWEB39 (b_BWEB[39], BWEB[39]);
buf iBWEB40 (b_BWEB[40], BWEB[40]);
buf iBWEB41 (b_BWEB[41], BWEB[41]);
buf iBWEB42 (b_BWEB[42], BWEB[42]);
buf iBWEB43 (b_BWEB[43], BWEB[43]);
buf iBWEB44 (b_BWEB[44], BWEB[44]);
buf iBWEB45 (b_BWEB[45], BWEB[45]);
buf iBWEB46 (b_BWEB[46], BWEB[46]);
buf iBWEB47 (b_BWEB[47], BWEB[47]);
buf iBWEB48 (b_BWEB[48], BWEB[48]);
buf iBWEB49 (b_BWEB[49], BWEB[49]);
buf iBWEB50 (b_BWEB[50], BWEB[50]);
buf iBWEB51 (b_BWEB[51], BWEB[51]);
buf iBWEB52 (b_BWEB[52], BWEB[52]);
buf iBWEB53 (b_BWEB[53], BWEB[53]);
buf iBWEB54 (b_BWEB[54], BWEB[54]);
buf iBWEB55 (b_BWEB[55], BWEB[55]);
buf iBWEB56 (b_BWEB[56], BWEB[56]);
buf iBWEB57 (b_BWEB[57], BWEB[57]);
buf iBWEB58 (b_BWEB[58], BWEB[58]);
buf iBWEB59 (b_BWEB[59], BWEB[59]);
buf iBWEB60 (b_BWEB[60], BWEB[60]);
buf iBWEB61 (b_BWEB[61], BWEB[61]);
buf iBWEB62 (b_BWEB[62], BWEB[62]);
buf iBWEB63 (b_BWEB[63], BWEB[63]);

buf iA0 (b_A[0], A[0]);
buf iA1 (b_A[1], A[1]);
buf iA2 (b_A[2], A[2]);
buf iA3 (b_A[3], A[3]);
buf iA4 (b_A[4], A[4]);
buf iA5 (b_A[5], A[5]);
buf iA6 (b_A[6], A[6]);
buf iA7 (b_A[7], A[7]);
buf iA8 (b_A[8], A[8]);
buf iA9 (b_A[9], A[9]);

buf iWEB (b_WEB, WEB);
buf iCEB (b_CEB, CEB);


buf iCLK (b_CLK, CLK);

nmos iQ0 (Q[0], Q_n[0], 1'b1);
nmos iQ1 (Q[1], Q_n[1], 1'b1);
nmos iQ2 (Q[2], Q_n[2], 1'b1);
nmos iQ3 (Q[3], Q_n[3], 1'b1);
nmos iQ4 (Q[4], Q_n[4], 1'b1);
nmos iQ5 (Q[5], Q_n[5], 1'b1);
nmos iQ6 (Q[6], Q_n[6], 1'b1);
nmos iQ7 (Q[7], Q_n[7], 1'b1);
nmos iQ8 (Q[8], Q_n[8], 1'b1);
nmos iQ9 (Q[9], Q_n[9], 1'b1);
nmos iQ10 (Q[10], Q_n[10], 1'b1);
nmos iQ11 (Q[11], Q_n[11], 1'b1);
nmos iQ12 (Q[12], Q_n[12], 1'b1);
nmos iQ13 (Q[13], Q_n[13], 1'b1);
nmos iQ14 (Q[14], Q_n[14], 1'b1);
nmos iQ15 (Q[15], Q_n[15], 1'b1);
nmos iQ16 (Q[16], Q_n[16], 1'b1);
nmos iQ17 (Q[17], Q_n[17], 1'b1);
nmos iQ18 (Q[18], Q_n[18], 1'b1);
nmos iQ19 (Q[19], Q_n[19], 1'b1);
nmos iQ20 (Q[20], Q_n[20], 1'b1);
nmos iQ21 (Q[21], Q_n[21], 1'b1);
nmos iQ22 (Q[22], Q_n[22], 1'b1);
nmos iQ23 (Q[23], Q_n[23], 1'b1);
nmos iQ24 (Q[24], Q_n[24], 1'b1);
nmos iQ25 (Q[25], Q_n[25], 1'b1);
nmos iQ26 (Q[26], Q_n[26], 1'b1);
nmos iQ27 (Q[27], Q_n[27], 1'b1);
nmos iQ28 (Q[28], Q_n[28], 1'b1);
nmos iQ29 (Q[29], Q_n[29], 1'b1);
nmos iQ30 (Q[30], Q_n[30], 1'b1);
nmos iQ31 (Q[31], Q_n[31], 1'b1);
nmos iQ32 (Q[32], Q_n[32], 1'b1);
nmos iQ33 (Q[33], Q_n[33], 1'b1);
nmos iQ34 (Q[34], Q_n[34], 1'b1);
nmos iQ35 (Q[35], Q_n[35], 1'b1);
nmos iQ36 (Q[36], Q_n[36], 1'b1);
nmos iQ37 (Q[37], Q_n[37], 1'b1);
nmos iQ38 (Q[38], Q_n[38], 1'b1);
nmos iQ39 (Q[39], Q_n[39], 1'b1);
nmos iQ40 (Q[40], Q_n[40], 1'b1);
nmos iQ41 (Q[41], Q_n[41], 1'b1);
nmos iQ42 (Q[42], Q_n[42], 1'b1);
nmos iQ43 (Q[43], Q_n[43], 1'b1);
nmos iQ44 (Q[44], Q_n[44], 1'b1);
nmos iQ45 (Q[45], Q_n[45], 1'b1);
nmos iQ46 (Q[46], Q_n[46], 1'b1);
nmos iQ47 (Q[47], Q_n[47], 1'b1);
nmos iQ48 (Q[48], Q_n[48], 1'b1);
nmos iQ49 (Q[49], Q_n[49], 1'b1);
nmos iQ50 (Q[50], Q_n[50], 1'b1);
nmos iQ51 (Q[51], Q_n[51], 1'b1);
nmos iQ52 (Q[52], Q_n[52], 1'b1);
nmos iQ53 (Q[53], Q_n[53], 1'b1);
nmos iQ54 (Q[54], Q_n[54], 1'b1);
nmos iQ55 (Q[55], Q_n[55], 1'b1);
nmos iQ56 (Q[56], Q_n[56], 1'b1);
nmos iQ57 (Q[57], Q_n[57], 1'b1);
nmos iQ58 (Q[58], Q_n[58], 1'b1);
nmos iQ59 (Q[59], Q_n[59], 1'b1);
nmos iQ60 (Q[60], Q_n[60], 1'b1);
nmos iQ61 (Q[61], Q_n[61], 1'b1);
nmos iQ62 (Q[62], Q_n[62], 1'b1);
nmos iQ63 (Q[63], Q_n[63], 1'b1);
//      Repair



// Test Mode
buf (RTSEL_i[0], RTSEL[0]);
buf (RTSEL_i[1], RTSEL[1]);
buf (WTSEL_i[0], WTSEL[0]);
buf (WTSEL_i[1], WTSEL[1]);
buf (WTSEL_i[2], WTSEL[2]);

// M-by-N core memory
reg [N - 1:0] mem[W - 1:0];
reg [N - 1:0] mem_sa0[W - 1:0];
reg [N - 1:0] mem_sa1[W - 1:0];






// latched input signal
reg [M - 1:0] AL;
reg WEBL;
reg CEBL;
reg [N - 1:0] DL;
reg [N - 1:0] BWEBL;


`ifdef TSMC_UNIT_DELAY
`else
// Timing Check notifiers
reg notifier_CLK;      // notifier for clock CLK timing violations.
reg notifier_D0;         // notifier for D and DM timing violations.
reg notifier_D1;         // notifier for D and DM timing violations.
reg notifier_D2;         // notifier for D and DM timing violations.
reg notifier_D3;         // notifier for D and DM timing violations.
reg notifier_D4;         // notifier for D and DM timing violations.
reg notifier_D5;         // notifier for D and DM timing violations.
reg notifier_D6;         // notifier for D and DM timing violations.
reg notifier_D7;         // notifier for D and DM timing violations.
reg notifier_D8;         // notifier for D and DM timing violations.
reg notifier_D9;         // notifier for D and DM timing violations.
reg notifier_D10;         // notifier for D and DM timing violations.
reg notifier_D11;         // notifier for D and DM timing violations.
reg notifier_D12;         // notifier for D and DM timing violations.
reg notifier_D13;         // notifier for D and DM timing violations.
reg notifier_D14;         // notifier for D and DM timing violations.
reg notifier_D15;         // notifier for D and DM timing violations.
reg notifier_D16;         // notifier for D and DM timing violations.
reg notifier_D17;         // notifier for D and DM timing violations.
reg notifier_D18;         // notifier for D and DM timing violations.
reg notifier_D19;         // notifier for D and DM timing violations.
reg notifier_D20;         // notifier for D and DM timing violations.
reg notifier_D21;         // notifier for D and DM timing violations.
reg notifier_D22;         // notifier for D and DM timing violations.
reg notifier_D23;         // notifier for D and DM timing violations.
reg notifier_D24;         // notifier for D and DM timing violations.
reg notifier_D25;         // notifier for D and DM timing violations.
reg notifier_D26;         // notifier for D and DM timing violations.
reg notifier_D27;         // notifier for D and DM timing violations.
reg notifier_D28;         // notifier for D and DM timing violations.
reg notifier_D29;         // notifier for D and DM timing violations.
reg notifier_D30;         // notifier for D and DM timing violations.
reg notifier_D31;         // notifier for D and DM timing violations.
reg notifier_D32;         // notifier for D and DM timing violations.
reg notifier_D33;         // notifier for D and DM timing violations.
reg notifier_D34;         // notifier for D and DM timing violations.
reg notifier_D35;         // notifier for D and DM timing violations.
reg notifier_D36;         // notifier for D and DM timing violations.
reg notifier_D37;         // notifier for D and DM timing violations.
reg notifier_D38;         // notifier for D and DM timing violations.
reg notifier_D39;         // notifier for D and DM timing violations.
reg notifier_D40;         // notifier for D and DM timing violations.
reg notifier_D41;         // notifier for D and DM timing violations.
reg notifier_D42;         // notifier for D and DM timing violations.
reg notifier_D43;         // notifier for D and DM timing violations.
reg notifier_D44;         // notifier for D and DM timing violations.
reg notifier_D45;         // notifier for D and DM timing violations.
reg notifier_D46;         // notifier for D and DM timing violations.
reg notifier_D47;         // notifier for D and DM timing violations.
reg notifier_D48;         // notifier for D and DM timing violations.
reg notifier_D49;         // notifier for D and DM timing violations.
reg notifier_D50;         // notifier for D and DM timing violations.
reg notifier_D51;         // notifier for D and DM timing violations.
reg notifier_D52;         // notifier for D and DM timing violations.
reg notifier_D53;         // notifier for D and DM timing violations.
reg notifier_D54;         // notifier for D and DM timing violations.
reg notifier_D55;         // notifier for D and DM timing violations.
reg notifier_D56;         // notifier for D and DM timing violations.
reg notifier_D57;         // notifier for D and DM timing violations.
reg notifier_D58;         // notifier for D and DM timing violations.
reg notifier_D59;         // notifier for D and DM timing violations.
reg notifier_D60;         // notifier for D and DM timing violations.
reg notifier_D61;         // notifier for D and DM timing violations.
reg notifier_D62;         // notifier for D and DM timing violations.
reg notifier_D63;         // notifier for D and DM timing violations.
reg notifier_BWEB0;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB1;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB2;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB3;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB4;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB5;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB6;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB7;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB8;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB9;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB10;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB11;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB12;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB13;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB14;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB15;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB16;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB17;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB18;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB19;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB20;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB21;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB22;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB23;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB24;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB25;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB26;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB27;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB28;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB29;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB30;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB31;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB32;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB33;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB34;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB35;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB36;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB37;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB38;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB39;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB40;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB41;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB42;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB43;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB44;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB45;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB46;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB47;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB48;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB49;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB50;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB51;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB52;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB53;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB54;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB55;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB56;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB57;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB58;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB59;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB60;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB61;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB62;         // notifier for BWEB and BWEBM timing violations.
reg notifier_BWEB63;         // notifier for BWEB and BWEBM timing violations.
reg notifier_WEB;       // notifier for WEB & BWEB timing violations.
reg notifier_CEB;       // notifier for CEB & CEBM timing violations.
reg notifier_A;        // notifier for A & AM timing violations.
`endif
integer i;


`ifdef TSMC_UNIT_DELAY
`else
specify
    specparam PATHPULSE$ = ( 0, 0.001 );


specparam tckl = 0.462;
specparam tckh = 0.404;
specparam tcyc = 1.834;

specparam tas = 0.222;
specparam tah = 0.097;
specparam tds = 0.206;
specparam tdh = 0.098;
specparam tcebs = 0.462;
specparam tcebh = 0.101;
specparam twebs = 0.253;
specparam twebh = 0.070;
specparam tbwebs = 0.219;
specparam tbwebh = 0.075;




// CLK-2-Q
specparam tcd = 1.259;
specparam thold = 1.212;




  
  $width(negedge CLK, tckl, 0, notifier_CLK);
  $width(posedge CLK, tckh, 0, notifier_CLK);
  $period(posedge CLK, tcyc, notifier_CLK);
  
  $setuphold(posedge CLK, posedge CEB, tcebs, tcebh, notifier_CEB);
  $setuphold(posedge CLK, negedge CEB, tcebs, tcebh, notifier_CEB);
  
  
  $setuphold(posedge CLK &&& CE, posedge WEB, twebs, twebh, notifier_WEB);
  $setuphold(posedge CLK &&& CE, negedge WEB, twebs, twebh, notifier_WEB);

  $setuphold(posedge CLK &&& CE, posedge A[0], tas, tah, notifier_A);
  $setuphold(posedge CLK &&& CE, negedge A[0], tas, tah, notifier_A);
  $setuphold(posedge CLK &&& CE, posedge A[1], tas, tah, notifier_A);
  $setuphold(posedge CLK &&& CE, negedge A[1], tas, tah, notifier_A);
  $setuphold(posedge CLK &&& CE, posedge A[2], tas, tah, notifier_A);
  $setuphold(posedge CLK &&& CE, negedge A[2], tas, tah, notifier_A);
  $setuphold(posedge CLK &&& CE, posedge A[3], tas, tah, notifier_A);
  $setuphold(posedge CLK &&& CE, negedge A[3], tas, tah, notifier_A);
  $setuphold(posedge CLK &&& CE, posedge A[4], tas, tah, notifier_A);
  $setuphold(posedge CLK &&& CE, negedge A[4], tas, tah, notifier_A);
  $setuphold(posedge CLK &&& CE, posedge A[5], tas, tah, notifier_A);
  $setuphold(posedge CLK &&& CE, negedge A[5], tas, tah, notifier_A);
  $setuphold(posedge CLK &&& CE, posedge A[6], tas, tah, notifier_A);
  $setuphold(posedge CLK &&& CE, negedge A[6], tas, tah, notifier_A);
  $setuphold(posedge CLK &&& CE, posedge A[7], tas, tah, notifier_A);
  $setuphold(posedge CLK &&& CE, negedge A[7], tas, tah, notifier_A);
  $setuphold(posedge CLK &&& CE, posedge A[8], tas, tah, notifier_A);
  $setuphold(posedge CLK &&& CE, negedge A[8], tas, tah, notifier_A);
  $setuphold(posedge CLK &&& CE, posedge A[9], tas, tah, notifier_A);
  $setuphold(posedge CLK &&& CE, negedge A[9], tas, tah, notifier_A);

  $setuphold(posedge CLK &&& WE, posedge D[0], tds, tdh, notifier_D0);
  $setuphold(posedge CLK &&& WE, negedge D[0], tds, tdh, notifier_D0);
  $setuphold(posedge CLK &&& WE, posedge D[1], tds, tdh, notifier_D1);
  $setuphold(posedge CLK &&& WE, negedge D[1], tds, tdh, notifier_D1);
  $setuphold(posedge CLK &&& WE, posedge D[2], tds, tdh, notifier_D2);
  $setuphold(posedge CLK &&& WE, negedge D[2], tds, tdh, notifier_D2);
  $setuphold(posedge CLK &&& WE, posedge D[3], tds, tdh, notifier_D3);
  $setuphold(posedge CLK &&& WE, negedge D[3], tds, tdh, notifier_D3);
  $setuphold(posedge CLK &&& WE, posedge D[4], tds, tdh, notifier_D4);
  $setuphold(posedge CLK &&& WE, negedge D[4], tds, tdh, notifier_D4);
  $setuphold(posedge CLK &&& WE, posedge D[5], tds, tdh, notifier_D5);
  $setuphold(posedge CLK &&& WE, negedge D[5], tds, tdh, notifier_D5);
  $setuphold(posedge CLK &&& WE, posedge D[6], tds, tdh, notifier_D6);
  $setuphold(posedge CLK &&& WE, negedge D[6], tds, tdh, notifier_D6);
  $setuphold(posedge CLK &&& WE, posedge D[7], tds, tdh, notifier_D7);
  $setuphold(posedge CLK &&& WE, negedge D[7], tds, tdh, notifier_D7);
  $setuphold(posedge CLK &&& WE, posedge D[8], tds, tdh, notifier_D8);
  $setuphold(posedge CLK &&& WE, negedge D[8], tds, tdh, notifier_D8);
  $setuphold(posedge CLK &&& WE, posedge D[9], tds, tdh, notifier_D9);
  $setuphold(posedge CLK &&& WE, negedge D[9], tds, tdh, notifier_D9);
  $setuphold(posedge CLK &&& WE, posedge D[10], tds, tdh, notifier_D10);
  $setuphold(posedge CLK &&& WE, negedge D[10], tds, tdh, notifier_D10);
  $setuphold(posedge CLK &&& WE, posedge D[11], tds, tdh, notifier_D11);
  $setuphold(posedge CLK &&& WE, negedge D[11], tds, tdh, notifier_D11);
  $setuphold(posedge CLK &&& WE, posedge D[12], tds, tdh, notifier_D12);
  $setuphold(posedge CLK &&& WE, negedge D[12], tds, tdh, notifier_D12);
  $setuphold(posedge CLK &&& WE, posedge D[13], tds, tdh, notifier_D13);
  $setuphold(posedge CLK &&& WE, negedge D[13], tds, tdh, notifier_D13);
  $setuphold(posedge CLK &&& WE, posedge D[14], tds, tdh, notifier_D14);
  $setuphold(posedge CLK &&& WE, negedge D[14], tds, tdh, notifier_D14);
  $setuphold(posedge CLK &&& WE, posedge D[15], tds, tdh, notifier_D15);
  $setuphold(posedge CLK &&& WE, negedge D[15], tds, tdh, notifier_D15);
  $setuphold(posedge CLK &&& WE, posedge D[16], tds, tdh, notifier_D16);
  $setuphold(posedge CLK &&& WE, negedge D[16], tds, tdh, notifier_D16);
  $setuphold(posedge CLK &&& WE, posedge D[17], tds, tdh, notifier_D17);
  $setuphold(posedge CLK &&& WE, negedge D[17], tds, tdh, notifier_D17);
  $setuphold(posedge CLK &&& WE, posedge D[18], tds, tdh, notifier_D18);
  $setuphold(posedge CLK &&& WE, negedge D[18], tds, tdh, notifier_D18);
  $setuphold(posedge CLK &&& WE, posedge D[19], tds, tdh, notifier_D19);
  $setuphold(posedge CLK &&& WE, negedge D[19], tds, tdh, notifier_D19);
  $setuphold(posedge CLK &&& WE, posedge D[20], tds, tdh, notifier_D20);
  $setuphold(posedge CLK &&& WE, negedge D[20], tds, tdh, notifier_D20);
  $setuphold(posedge CLK &&& WE, posedge D[21], tds, tdh, notifier_D21);
  $setuphold(posedge CLK &&& WE, negedge D[21], tds, tdh, notifier_D21);
  $setuphold(posedge CLK &&& WE, posedge D[22], tds, tdh, notifier_D22);
  $setuphold(posedge CLK &&& WE, negedge D[22], tds, tdh, notifier_D22);
  $setuphold(posedge CLK &&& WE, posedge D[23], tds, tdh, notifier_D23);
  $setuphold(posedge CLK &&& WE, negedge D[23], tds, tdh, notifier_D23);
  $setuphold(posedge CLK &&& WE, posedge D[24], tds, tdh, notifier_D24);
  $setuphold(posedge CLK &&& WE, negedge D[24], tds, tdh, notifier_D24);
  $setuphold(posedge CLK &&& WE, posedge D[25], tds, tdh, notifier_D25);
  $setuphold(posedge CLK &&& WE, negedge D[25], tds, tdh, notifier_D25);
  $setuphold(posedge CLK &&& WE, posedge D[26], tds, tdh, notifier_D26);
  $setuphold(posedge CLK &&& WE, negedge D[26], tds, tdh, notifier_D26);
  $setuphold(posedge CLK &&& WE, posedge D[27], tds, tdh, notifier_D27);
  $setuphold(posedge CLK &&& WE, negedge D[27], tds, tdh, notifier_D27);
  $setuphold(posedge CLK &&& WE, posedge D[28], tds, tdh, notifier_D28);
  $setuphold(posedge CLK &&& WE, negedge D[28], tds, tdh, notifier_D28);
  $setuphold(posedge CLK &&& WE, posedge D[29], tds, tdh, notifier_D29);
  $setuphold(posedge CLK &&& WE, negedge D[29], tds, tdh, notifier_D29);
  $setuphold(posedge CLK &&& WE, posedge D[30], tds, tdh, notifier_D30);
  $setuphold(posedge CLK &&& WE, negedge D[30], tds, tdh, notifier_D30);
  $setuphold(posedge CLK &&& WE, posedge D[31], tds, tdh, notifier_D31);
  $setuphold(posedge CLK &&& WE, negedge D[31], tds, tdh, notifier_D31);
  $setuphold(posedge CLK &&& WE, posedge D[32], tds, tdh, notifier_D32);
  $setuphold(posedge CLK &&& WE, negedge D[32], tds, tdh, notifier_D32);
  $setuphold(posedge CLK &&& WE, posedge D[33], tds, tdh, notifier_D33);
  $setuphold(posedge CLK &&& WE, negedge D[33], tds, tdh, notifier_D33);
  $setuphold(posedge CLK &&& WE, posedge D[34], tds, tdh, notifier_D34);
  $setuphold(posedge CLK &&& WE, negedge D[34], tds, tdh, notifier_D34);
  $setuphold(posedge CLK &&& WE, posedge D[35], tds, tdh, notifier_D35);
  $setuphold(posedge CLK &&& WE, negedge D[35], tds, tdh, notifier_D35);
  $setuphold(posedge CLK &&& WE, posedge D[36], tds, tdh, notifier_D36);
  $setuphold(posedge CLK &&& WE, negedge D[36], tds, tdh, notifier_D36);
  $setuphold(posedge CLK &&& WE, posedge D[37], tds, tdh, notifier_D37);
  $setuphold(posedge CLK &&& WE, negedge D[37], tds, tdh, notifier_D37);
  $setuphold(posedge CLK &&& WE, posedge D[38], tds, tdh, notifier_D38);
  $setuphold(posedge CLK &&& WE, negedge D[38], tds, tdh, notifier_D38);
  $setuphold(posedge CLK &&& WE, posedge D[39], tds, tdh, notifier_D39);
  $setuphold(posedge CLK &&& WE, negedge D[39], tds, tdh, notifier_D39);
  $setuphold(posedge CLK &&& WE, posedge D[40], tds, tdh, notifier_D40);
  $setuphold(posedge CLK &&& WE, negedge D[40], tds, tdh, notifier_D40);
  $setuphold(posedge CLK &&& WE, posedge D[41], tds, tdh, notifier_D41);
  $setuphold(posedge CLK &&& WE, negedge D[41], tds, tdh, notifier_D41);
  $setuphold(posedge CLK &&& WE, posedge D[42], tds, tdh, notifier_D42);
  $setuphold(posedge CLK &&& WE, negedge D[42], tds, tdh, notifier_D42);
  $setuphold(posedge CLK &&& WE, posedge D[43], tds, tdh, notifier_D43);
  $setuphold(posedge CLK &&& WE, negedge D[43], tds, tdh, notifier_D43);
  $setuphold(posedge CLK &&& WE, posedge D[44], tds, tdh, notifier_D44);
  $setuphold(posedge CLK &&& WE, negedge D[44], tds, tdh, notifier_D44);
  $setuphold(posedge CLK &&& WE, posedge D[45], tds, tdh, notifier_D45);
  $setuphold(posedge CLK &&& WE, negedge D[45], tds, tdh, notifier_D45);
  $setuphold(posedge CLK &&& WE, posedge D[46], tds, tdh, notifier_D46);
  $setuphold(posedge CLK &&& WE, negedge D[46], tds, tdh, notifier_D46);
  $setuphold(posedge CLK &&& WE, posedge D[47], tds, tdh, notifier_D47);
  $setuphold(posedge CLK &&& WE, negedge D[47], tds, tdh, notifier_D47);
  $setuphold(posedge CLK &&& WE, posedge D[48], tds, tdh, notifier_D48);
  $setuphold(posedge CLK &&& WE, negedge D[48], tds, tdh, notifier_D48);
  $setuphold(posedge CLK &&& WE, posedge D[49], tds, tdh, notifier_D49);
  $setuphold(posedge CLK &&& WE, negedge D[49], tds, tdh, notifier_D49);
  $setuphold(posedge CLK &&& WE, posedge D[50], tds, tdh, notifier_D50);
  $setuphold(posedge CLK &&& WE, negedge D[50], tds, tdh, notifier_D50);
  $setuphold(posedge CLK &&& WE, posedge D[51], tds, tdh, notifier_D51);
  $setuphold(posedge CLK &&& WE, negedge D[51], tds, tdh, notifier_D51);
  $setuphold(posedge CLK &&& WE, posedge D[52], tds, tdh, notifier_D52);
  $setuphold(posedge CLK &&& WE, negedge D[52], tds, tdh, notifier_D52);
  $setuphold(posedge CLK &&& WE, posedge D[53], tds, tdh, notifier_D53);
  $setuphold(posedge CLK &&& WE, negedge D[53], tds, tdh, notifier_D53);
  $setuphold(posedge CLK &&& WE, posedge D[54], tds, tdh, notifier_D54);
  $setuphold(posedge CLK &&& WE, negedge D[54], tds, tdh, notifier_D54);
  $setuphold(posedge CLK &&& WE, posedge D[55], tds, tdh, notifier_D55);
  $setuphold(posedge CLK &&& WE, negedge D[55], tds, tdh, notifier_D55);
  $setuphold(posedge CLK &&& WE, posedge D[56], tds, tdh, notifier_D56);
  $setuphold(posedge CLK &&& WE, negedge D[56], tds, tdh, notifier_D56);
  $setuphold(posedge CLK &&& WE, posedge D[57], tds, tdh, notifier_D57);
  $setuphold(posedge CLK &&& WE, negedge D[57], tds, tdh, notifier_D57);
  $setuphold(posedge CLK &&& WE, posedge D[58], tds, tdh, notifier_D58);
  $setuphold(posedge CLK &&& WE, negedge D[58], tds, tdh, notifier_D58);
  $setuphold(posedge CLK &&& WE, posedge D[59], tds, tdh, notifier_D59);
  $setuphold(posedge CLK &&& WE, negedge D[59], tds, tdh, notifier_D59);
  $setuphold(posedge CLK &&& WE, posedge D[60], tds, tdh, notifier_D60);
  $setuphold(posedge CLK &&& WE, negedge D[60], tds, tdh, notifier_D60);
  $setuphold(posedge CLK &&& WE, posedge D[61], tds, tdh, notifier_D61);
  $setuphold(posedge CLK &&& WE, negedge D[61], tds, tdh, notifier_D61);
  $setuphold(posedge CLK &&& WE, posedge D[62], tds, tdh, notifier_D62);
  $setuphold(posedge CLK &&& WE, negedge D[62], tds, tdh, notifier_D62);
  $setuphold(posedge CLK &&& WE, posedge D[63], tds, tdh, notifier_D63);
  $setuphold(posedge CLK &&& WE, negedge D[63], tds, tdh, notifier_D63);
  $setuphold(posedge CLK &&& WE, posedge BWEB[0], tbwebs, tbwebh, notifier_BWEB0);
  $setuphold(posedge CLK &&& WE, negedge BWEB[0], tbwebs, tbwebh, notifier_BWEB0);
  $setuphold(posedge CLK &&& WE, posedge BWEB[1], tbwebs, tbwebh, notifier_BWEB1);
  $setuphold(posedge CLK &&& WE, negedge BWEB[1], tbwebs, tbwebh, notifier_BWEB1);
  $setuphold(posedge CLK &&& WE, posedge BWEB[2], tbwebs, tbwebh, notifier_BWEB2);
  $setuphold(posedge CLK &&& WE, negedge BWEB[2], tbwebs, tbwebh, notifier_BWEB2);
  $setuphold(posedge CLK &&& WE, posedge BWEB[3], tbwebs, tbwebh, notifier_BWEB3);
  $setuphold(posedge CLK &&& WE, negedge BWEB[3], tbwebs, tbwebh, notifier_BWEB3);
  $setuphold(posedge CLK &&& WE, posedge BWEB[4], tbwebs, tbwebh, notifier_BWEB4);
  $setuphold(posedge CLK &&& WE, negedge BWEB[4], tbwebs, tbwebh, notifier_BWEB4);
  $setuphold(posedge CLK &&& WE, posedge BWEB[5], tbwebs, tbwebh, notifier_BWEB5);
  $setuphold(posedge CLK &&& WE, negedge BWEB[5], tbwebs, tbwebh, notifier_BWEB5);
  $setuphold(posedge CLK &&& WE, posedge BWEB[6], tbwebs, tbwebh, notifier_BWEB6);
  $setuphold(posedge CLK &&& WE, negedge BWEB[6], tbwebs, tbwebh, notifier_BWEB6);
  $setuphold(posedge CLK &&& WE, posedge BWEB[7], tbwebs, tbwebh, notifier_BWEB7);
  $setuphold(posedge CLK &&& WE, negedge BWEB[7], tbwebs, tbwebh, notifier_BWEB7);
  $setuphold(posedge CLK &&& WE, posedge BWEB[8], tbwebs, tbwebh, notifier_BWEB8);
  $setuphold(posedge CLK &&& WE, negedge BWEB[8], tbwebs, tbwebh, notifier_BWEB8);
  $setuphold(posedge CLK &&& WE, posedge BWEB[9], tbwebs, tbwebh, notifier_BWEB9);
  $setuphold(posedge CLK &&& WE, negedge BWEB[9], tbwebs, tbwebh, notifier_BWEB9);
  $setuphold(posedge CLK &&& WE, posedge BWEB[10], tbwebs, tbwebh, notifier_BWEB10);
  $setuphold(posedge CLK &&& WE, negedge BWEB[10], tbwebs, tbwebh, notifier_BWEB10);
  $setuphold(posedge CLK &&& WE, posedge BWEB[11], tbwebs, tbwebh, notifier_BWEB11);
  $setuphold(posedge CLK &&& WE, negedge BWEB[11], tbwebs, tbwebh, notifier_BWEB11);
  $setuphold(posedge CLK &&& WE, posedge BWEB[12], tbwebs, tbwebh, notifier_BWEB12);
  $setuphold(posedge CLK &&& WE, negedge BWEB[12], tbwebs, tbwebh, notifier_BWEB12);
  $setuphold(posedge CLK &&& WE, posedge BWEB[13], tbwebs, tbwebh, notifier_BWEB13);
  $setuphold(posedge CLK &&& WE, negedge BWEB[13], tbwebs, tbwebh, notifier_BWEB13);
  $setuphold(posedge CLK &&& WE, posedge BWEB[14], tbwebs, tbwebh, notifier_BWEB14);
  $setuphold(posedge CLK &&& WE, negedge BWEB[14], tbwebs, tbwebh, notifier_BWEB14);
  $setuphold(posedge CLK &&& WE, posedge BWEB[15], tbwebs, tbwebh, notifier_BWEB15);
  $setuphold(posedge CLK &&& WE, negedge BWEB[15], tbwebs, tbwebh, notifier_BWEB15);
  $setuphold(posedge CLK &&& WE, posedge BWEB[16], tbwebs, tbwebh, notifier_BWEB16);
  $setuphold(posedge CLK &&& WE, negedge BWEB[16], tbwebs, tbwebh, notifier_BWEB16);
  $setuphold(posedge CLK &&& WE, posedge BWEB[17], tbwebs, tbwebh, notifier_BWEB17);
  $setuphold(posedge CLK &&& WE, negedge BWEB[17], tbwebs, tbwebh, notifier_BWEB17);
  $setuphold(posedge CLK &&& WE, posedge BWEB[18], tbwebs, tbwebh, notifier_BWEB18);
  $setuphold(posedge CLK &&& WE, negedge BWEB[18], tbwebs, tbwebh, notifier_BWEB18);
  $setuphold(posedge CLK &&& WE, posedge BWEB[19], tbwebs, tbwebh, notifier_BWEB19);
  $setuphold(posedge CLK &&& WE, negedge BWEB[19], tbwebs, tbwebh, notifier_BWEB19);
  $setuphold(posedge CLK &&& WE, posedge BWEB[20], tbwebs, tbwebh, notifier_BWEB20);
  $setuphold(posedge CLK &&& WE, negedge BWEB[20], tbwebs, tbwebh, notifier_BWEB20);
  $setuphold(posedge CLK &&& WE, posedge BWEB[21], tbwebs, tbwebh, notifier_BWEB21);
  $setuphold(posedge CLK &&& WE, negedge BWEB[21], tbwebs, tbwebh, notifier_BWEB21);
  $setuphold(posedge CLK &&& WE, posedge BWEB[22], tbwebs, tbwebh, notifier_BWEB22);
  $setuphold(posedge CLK &&& WE, negedge BWEB[22], tbwebs, tbwebh, notifier_BWEB22);
  $setuphold(posedge CLK &&& WE, posedge BWEB[23], tbwebs, tbwebh, notifier_BWEB23);
  $setuphold(posedge CLK &&& WE, negedge BWEB[23], tbwebs, tbwebh, notifier_BWEB23);
  $setuphold(posedge CLK &&& WE, posedge BWEB[24], tbwebs, tbwebh, notifier_BWEB24);
  $setuphold(posedge CLK &&& WE, negedge BWEB[24], tbwebs, tbwebh, notifier_BWEB24);
  $setuphold(posedge CLK &&& WE, posedge BWEB[25], tbwebs, tbwebh, notifier_BWEB25);
  $setuphold(posedge CLK &&& WE, negedge BWEB[25], tbwebs, tbwebh, notifier_BWEB25);
  $setuphold(posedge CLK &&& WE, posedge BWEB[26], tbwebs, tbwebh, notifier_BWEB26);
  $setuphold(posedge CLK &&& WE, negedge BWEB[26], tbwebs, tbwebh, notifier_BWEB26);
  $setuphold(posedge CLK &&& WE, posedge BWEB[27], tbwebs, tbwebh, notifier_BWEB27);
  $setuphold(posedge CLK &&& WE, negedge BWEB[27], tbwebs, tbwebh, notifier_BWEB27);
  $setuphold(posedge CLK &&& WE, posedge BWEB[28], tbwebs, tbwebh, notifier_BWEB28);
  $setuphold(posedge CLK &&& WE, negedge BWEB[28], tbwebs, tbwebh, notifier_BWEB28);
  $setuphold(posedge CLK &&& WE, posedge BWEB[29], tbwebs, tbwebh, notifier_BWEB29);
  $setuphold(posedge CLK &&& WE, negedge BWEB[29], tbwebs, tbwebh, notifier_BWEB29);
  $setuphold(posedge CLK &&& WE, posedge BWEB[30], tbwebs, tbwebh, notifier_BWEB30);
  $setuphold(posedge CLK &&& WE, negedge BWEB[30], tbwebs, tbwebh, notifier_BWEB30);
  $setuphold(posedge CLK &&& WE, posedge BWEB[31], tbwebs, tbwebh, notifier_BWEB31);
  $setuphold(posedge CLK &&& WE, negedge BWEB[31], tbwebs, tbwebh, notifier_BWEB31);
  $setuphold(posedge CLK &&& WE, posedge BWEB[32], tbwebs, tbwebh, notifier_BWEB32);
  $setuphold(posedge CLK &&& WE, negedge BWEB[32], tbwebs, tbwebh, notifier_BWEB32);
  $setuphold(posedge CLK &&& WE, posedge BWEB[33], tbwebs, tbwebh, notifier_BWEB33);
  $setuphold(posedge CLK &&& WE, negedge BWEB[33], tbwebs, tbwebh, notifier_BWEB33);
  $setuphold(posedge CLK &&& WE, posedge BWEB[34], tbwebs, tbwebh, notifier_BWEB34);
  $setuphold(posedge CLK &&& WE, negedge BWEB[34], tbwebs, tbwebh, notifier_BWEB34);
  $setuphold(posedge CLK &&& WE, posedge BWEB[35], tbwebs, tbwebh, notifier_BWEB35);
  $setuphold(posedge CLK &&& WE, negedge BWEB[35], tbwebs, tbwebh, notifier_BWEB35);
  $setuphold(posedge CLK &&& WE, posedge BWEB[36], tbwebs, tbwebh, notifier_BWEB36);
  $setuphold(posedge CLK &&& WE, negedge BWEB[36], tbwebs, tbwebh, notifier_BWEB36);
  $setuphold(posedge CLK &&& WE, posedge BWEB[37], tbwebs, tbwebh, notifier_BWEB37);
  $setuphold(posedge CLK &&& WE, negedge BWEB[37], tbwebs, tbwebh, notifier_BWEB37);
  $setuphold(posedge CLK &&& WE, posedge BWEB[38], tbwebs, tbwebh, notifier_BWEB38);
  $setuphold(posedge CLK &&& WE, negedge BWEB[38], tbwebs, tbwebh, notifier_BWEB38);
  $setuphold(posedge CLK &&& WE, posedge BWEB[39], tbwebs, tbwebh, notifier_BWEB39);
  $setuphold(posedge CLK &&& WE, negedge BWEB[39], tbwebs, tbwebh, notifier_BWEB39);
  $setuphold(posedge CLK &&& WE, posedge BWEB[40], tbwebs, tbwebh, notifier_BWEB40);
  $setuphold(posedge CLK &&& WE, negedge BWEB[40], tbwebs, tbwebh, notifier_BWEB40);
  $setuphold(posedge CLK &&& WE, posedge BWEB[41], tbwebs, tbwebh, notifier_BWEB41);
  $setuphold(posedge CLK &&& WE, negedge BWEB[41], tbwebs, tbwebh, notifier_BWEB41);
  $setuphold(posedge CLK &&& WE, posedge BWEB[42], tbwebs, tbwebh, notifier_BWEB42);
  $setuphold(posedge CLK &&& WE, negedge BWEB[42], tbwebs, tbwebh, notifier_BWEB42);
  $setuphold(posedge CLK &&& WE, posedge BWEB[43], tbwebs, tbwebh, notifier_BWEB43);
  $setuphold(posedge CLK &&& WE, negedge BWEB[43], tbwebs, tbwebh, notifier_BWEB43);
  $setuphold(posedge CLK &&& WE, posedge BWEB[44], tbwebs, tbwebh, notifier_BWEB44);
  $setuphold(posedge CLK &&& WE, negedge BWEB[44], tbwebs, tbwebh, notifier_BWEB44);
  $setuphold(posedge CLK &&& WE, posedge BWEB[45], tbwebs, tbwebh, notifier_BWEB45);
  $setuphold(posedge CLK &&& WE, negedge BWEB[45], tbwebs, tbwebh, notifier_BWEB45);
  $setuphold(posedge CLK &&& WE, posedge BWEB[46], tbwebs, tbwebh, notifier_BWEB46);
  $setuphold(posedge CLK &&& WE, negedge BWEB[46], tbwebs, tbwebh, notifier_BWEB46);
  $setuphold(posedge CLK &&& WE, posedge BWEB[47], tbwebs, tbwebh, notifier_BWEB47);
  $setuphold(posedge CLK &&& WE, negedge BWEB[47], tbwebs, tbwebh, notifier_BWEB47);
  $setuphold(posedge CLK &&& WE, posedge BWEB[48], tbwebs, tbwebh, notifier_BWEB48);
  $setuphold(posedge CLK &&& WE, negedge BWEB[48], tbwebs, tbwebh, notifier_BWEB48);
  $setuphold(posedge CLK &&& WE, posedge BWEB[49], tbwebs, tbwebh, notifier_BWEB49);
  $setuphold(posedge CLK &&& WE, negedge BWEB[49], tbwebs, tbwebh, notifier_BWEB49);
  $setuphold(posedge CLK &&& WE, posedge BWEB[50], tbwebs, tbwebh, notifier_BWEB50);
  $setuphold(posedge CLK &&& WE, negedge BWEB[50], tbwebs, tbwebh, notifier_BWEB50);
  $setuphold(posedge CLK &&& WE, posedge BWEB[51], tbwebs, tbwebh, notifier_BWEB51);
  $setuphold(posedge CLK &&& WE, negedge BWEB[51], tbwebs, tbwebh, notifier_BWEB51);
  $setuphold(posedge CLK &&& WE, posedge BWEB[52], tbwebs, tbwebh, notifier_BWEB52);
  $setuphold(posedge CLK &&& WE, negedge BWEB[52], tbwebs, tbwebh, notifier_BWEB52);
  $setuphold(posedge CLK &&& WE, posedge BWEB[53], tbwebs, tbwebh, notifier_BWEB53);
  $setuphold(posedge CLK &&& WE, negedge BWEB[53], tbwebs, tbwebh, notifier_BWEB53);
  $setuphold(posedge CLK &&& WE, posedge BWEB[54], tbwebs, tbwebh, notifier_BWEB54);
  $setuphold(posedge CLK &&& WE, negedge BWEB[54], tbwebs, tbwebh, notifier_BWEB54);
  $setuphold(posedge CLK &&& WE, posedge BWEB[55], tbwebs, tbwebh, notifier_BWEB55);
  $setuphold(posedge CLK &&& WE, negedge BWEB[55], tbwebs, tbwebh, notifier_BWEB55);
  $setuphold(posedge CLK &&& WE, posedge BWEB[56], tbwebs, tbwebh, notifier_BWEB56);
  $setuphold(posedge CLK &&& WE, negedge BWEB[56], tbwebs, tbwebh, notifier_BWEB56);
  $setuphold(posedge CLK &&& WE, posedge BWEB[57], tbwebs, tbwebh, notifier_BWEB57);
  $setuphold(posedge CLK &&& WE, negedge BWEB[57], tbwebs, tbwebh, notifier_BWEB57);
  $setuphold(posedge CLK &&& WE, posedge BWEB[58], tbwebs, tbwebh, notifier_BWEB58);
  $setuphold(posedge CLK &&& WE, negedge BWEB[58], tbwebs, tbwebh, notifier_BWEB58);
  $setuphold(posedge CLK &&& WE, posedge BWEB[59], tbwebs, tbwebh, notifier_BWEB59);
  $setuphold(posedge CLK &&& WE, negedge BWEB[59], tbwebs, tbwebh, notifier_BWEB59);
  $setuphold(posedge CLK &&& WE, posedge BWEB[60], tbwebs, tbwebh, notifier_BWEB60);
  $setuphold(posedge CLK &&& WE, negedge BWEB[60], tbwebs, tbwebh, notifier_BWEB60);
  $setuphold(posedge CLK &&& WE, posedge BWEB[61], tbwebs, tbwebh, notifier_BWEB61);
  $setuphold(posedge CLK &&& WE, negedge BWEB[61], tbwebs, tbwebh, notifier_BWEB61);
  $setuphold(posedge CLK &&& WE, posedge BWEB[62], tbwebs, tbwebh, notifier_BWEB62);
  $setuphold(posedge CLK &&& WE, negedge BWEB[62], tbwebs, tbwebh, notifier_BWEB62);
  $setuphold(posedge CLK &&& WE, posedge BWEB[63], tbwebs, tbwebh, notifier_BWEB63);
  $setuphold(posedge CLK &&& WE, negedge BWEB[63], tbwebs, tbwebh, notifier_BWEB63);













  (posedge CLK => (Q[0] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[1] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[2] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[3] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[4] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[5] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[6] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[7] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[8] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[9] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[10] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[11] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[12] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[13] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[14] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[15] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[16] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[17] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[18] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[19] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[20] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[21] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[22] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[23] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[24] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[25] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[26] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[27] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[28] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[29] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[30] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[31] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[32] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[33] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[34] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[35] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[36] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[37] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[38] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[39] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[40] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[41] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[42] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[43] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[44] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[45] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[46] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[47] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[48] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[49] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[50] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[51] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[52] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[53] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[54] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[55] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[56] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[57] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[58] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[59] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[60] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[61] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[62] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);
  (posedge CLK => (Q[63] +: 1'bx)) = (tcd,tcd,thold,tcd,thold,tcd);


endspecify
`endif


initial begin
    for ( i = 0; i < W; i = i + 1) begin
        mem_sa0[i] = {N{1'b1}};
        mem_sa1[i] = {N{1'b0}};
    end
end

`ifndef TSMC_NO_TESTPINS_WARNING
always @(b_CLK or RTSEL_i) begin
    if (RTSEL_i !== 2'b00 && $realtime !=0) begin
        $display("\tError %m : input RTSEL should be set to 2'b00 at simulation time %.1f\n", $realtime);
        $display("\tError %m : Please refer the datasheet for the RTSEL setting in the different segment and mux configuration\n");
        corrupt_mem;
        Q_n= {N{1'bx}}; 
    end
end

always @(b_CLK or WTSEL_i) begin
    if (WTSEL_i !== 3'b000 && $realtime !=0) begin
        $display("\tError %m : input WTSEL should be set to 3'b000 at simulation time %.1f\n", $realtime);
        $display("\tError %m : Please refer the datasheet for the WTSEL setting in the different segment and mux configuration\n");
        corrupt_mem;
        Q_n= {N{1'bx}}; 
    end
end
`endif






`ifndef TSMC_UNIT_DELAY

always @(notifier_CEB) begin
    corrupt_mem;
    Q_n = {N{1'bx}};
end
always @(notifier_A) begin
    corrupt_mem;
    if(WEBL === 1'b1) begin
        Q_n = {N{1'bx}};
    end
end

always @(notifier_BWEB0) begin
    mem[AL][0] = 1'bx;
end
always @(notifier_BWEB1) begin
    mem[AL][1] = 1'bx;
end
always @(notifier_BWEB2) begin
    mem[AL][2] = 1'bx;
end
always @(notifier_BWEB3) begin
    mem[AL][3] = 1'bx;
end
always @(notifier_BWEB4) begin
    mem[AL][4] = 1'bx;
end
always @(notifier_BWEB5) begin
    mem[AL][5] = 1'bx;
end
always @(notifier_BWEB6) begin
    mem[AL][6] = 1'bx;
end
always @(notifier_BWEB7) begin
    mem[AL][7] = 1'bx;
end
always @(notifier_BWEB8) begin
    mem[AL][8] = 1'bx;
end
always @(notifier_BWEB9) begin
    mem[AL][9] = 1'bx;
end
always @(notifier_BWEB10) begin
    mem[AL][10] = 1'bx;
end
always @(notifier_BWEB11) begin
    mem[AL][11] = 1'bx;
end
always @(notifier_BWEB12) begin
    mem[AL][12] = 1'bx;
end
always @(notifier_BWEB13) begin
    mem[AL][13] = 1'bx;
end
always @(notifier_BWEB14) begin
    mem[AL][14] = 1'bx;
end
always @(notifier_BWEB15) begin
    mem[AL][15] = 1'bx;
end
always @(notifier_BWEB16) begin
    mem[AL][16] = 1'bx;
end
always @(notifier_BWEB17) begin
    mem[AL][17] = 1'bx;
end
always @(notifier_BWEB18) begin
    mem[AL][18] = 1'bx;
end
always @(notifier_BWEB19) begin
    mem[AL][19] = 1'bx;
end
always @(notifier_BWEB20) begin
    mem[AL][20] = 1'bx;
end
always @(notifier_BWEB21) begin
    mem[AL][21] = 1'bx;
end
always @(notifier_BWEB22) begin
    mem[AL][22] = 1'bx;
end
always @(notifier_BWEB23) begin
    mem[AL][23] = 1'bx;
end
always @(notifier_BWEB24) begin
    mem[AL][24] = 1'bx;
end
always @(notifier_BWEB25) begin
    mem[AL][25] = 1'bx;
end
always @(notifier_BWEB26) begin
    mem[AL][26] = 1'bx;
end
always @(notifier_BWEB27) begin
    mem[AL][27] = 1'bx;
end
always @(notifier_BWEB28) begin
    mem[AL][28] = 1'bx;
end
always @(notifier_BWEB29) begin
    mem[AL][29] = 1'bx;
end
always @(notifier_BWEB30) begin
    mem[AL][30] = 1'bx;
end
always @(notifier_BWEB31) begin
    mem[AL][31] = 1'bx;
end
always @(notifier_BWEB32) begin
    mem[AL][32] = 1'bx;
end
always @(notifier_BWEB33) begin
    mem[AL][33] = 1'bx;
end
always @(notifier_BWEB34) begin
    mem[AL][34] = 1'bx;
end
always @(notifier_BWEB35) begin
    mem[AL][35] = 1'bx;
end
always @(notifier_BWEB36) begin
    mem[AL][36] = 1'bx;
end
always @(notifier_BWEB37) begin
    mem[AL][37] = 1'bx;
end
always @(notifier_BWEB38) begin
    mem[AL][38] = 1'bx;
end
always @(notifier_BWEB39) begin
    mem[AL][39] = 1'bx;
end
always @(notifier_BWEB40) begin
    mem[AL][40] = 1'bx;
end
always @(notifier_BWEB41) begin
    mem[AL][41] = 1'bx;
end
always @(notifier_BWEB42) begin
    mem[AL][42] = 1'bx;
end
always @(notifier_BWEB43) begin
    mem[AL][43] = 1'bx;
end
always @(notifier_BWEB44) begin
    mem[AL][44] = 1'bx;
end
always @(notifier_BWEB45) begin
    mem[AL][45] = 1'bx;
end
always @(notifier_BWEB46) begin
    mem[AL][46] = 1'bx;
end
always @(notifier_BWEB47) begin
    mem[AL][47] = 1'bx;
end
always @(notifier_BWEB48) begin
    mem[AL][48] = 1'bx;
end
always @(notifier_BWEB49) begin
    mem[AL][49] = 1'bx;
end
always @(notifier_BWEB50) begin
    mem[AL][50] = 1'bx;
end
always @(notifier_BWEB51) begin
    mem[AL][51] = 1'bx;
end
always @(notifier_BWEB52) begin
    mem[AL][52] = 1'bx;
end
always @(notifier_BWEB53) begin
    mem[AL][53] = 1'bx;
end
always @(notifier_BWEB54) begin
    mem[AL][54] = 1'bx;
end
always @(notifier_BWEB55) begin
    mem[AL][55] = 1'bx;
end
always @(notifier_BWEB56) begin
    mem[AL][56] = 1'bx;
end
always @(notifier_BWEB57) begin
    mem[AL][57] = 1'bx;
end
always @(notifier_BWEB58) begin
    mem[AL][58] = 1'bx;
end
always @(notifier_BWEB59) begin
    mem[AL][59] = 1'bx;
end
always @(notifier_BWEB60) begin
    mem[AL][60] = 1'bx;
end
always @(notifier_BWEB61) begin
    mem[AL][61] = 1'bx;
end
always @(notifier_BWEB62) begin
    mem[AL][62] = 1'bx;
end
always @(notifier_BWEB63) begin
    mem[AL][63] = 1'bx;
end

always @(notifier_D0) begin
    mem[AL][0] = 1'bx;
end
always @(notifier_D1) begin
    mem[AL][1] = 1'bx;
end
always @(notifier_D2) begin
    mem[AL][2] = 1'bx;
end
always @(notifier_D3) begin
    mem[AL][3] = 1'bx;
end
always @(notifier_D4) begin
    mem[AL][4] = 1'bx;
end
always @(notifier_D5) begin
    mem[AL][5] = 1'bx;
end
always @(notifier_D6) begin
    mem[AL][6] = 1'bx;
end
always @(notifier_D7) begin
    mem[AL][7] = 1'bx;
end
always @(notifier_D8) begin
    mem[AL][8] = 1'bx;
end
always @(notifier_D9) begin
    mem[AL][9] = 1'bx;
end
always @(notifier_D10) begin
    mem[AL][10] = 1'bx;
end
always @(notifier_D11) begin
    mem[AL][11] = 1'bx;
end
always @(notifier_D12) begin
    mem[AL][12] = 1'bx;
end
always @(notifier_D13) begin
    mem[AL][13] = 1'bx;
end
always @(notifier_D14) begin
    mem[AL][14] = 1'bx;
end
always @(notifier_D15) begin
    mem[AL][15] = 1'bx;
end
always @(notifier_D16) begin
    mem[AL][16] = 1'bx;
end
always @(notifier_D17) begin
    mem[AL][17] = 1'bx;
end
always @(notifier_D18) begin
    mem[AL][18] = 1'bx;
end
always @(notifier_D19) begin
    mem[AL][19] = 1'bx;
end
always @(notifier_D20) begin
    mem[AL][20] = 1'bx;
end
always @(notifier_D21) begin
    mem[AL][21] = 1'bx;
end
always @(notifier_D22) begin
    mem[AL][22] = 1'bx;
end
always @(notifier_D23) begin
    mem[AL][23] = 1'bx;
end
always @(notifier_D24) begin
    mem[AL][24] = 1'bx;
end
always @(notifier_D25) begin
    mem[AL][25] = 1'bx;
end
always @(notifier_D26) begin
    mem[AL][26] = 1'bx;
end
always @(notifier_D27) begin
    mem[AL][27] = 1'bx;
end
always @(notifier_D28) begin
    mem[AL][28] = 1'bx;
end
always @(notifier_D29) begin
    mem[AL][29] = 1'bx;
end
always @(notifier_D30) begin
    mem[AL][30] = 1'bx;
end
always @(notifier_D31) begin
    mem[AL][31] = 1'bx;
end
always @(notifier_D32) begin
    mem[AL][32] = 1'bx;
end
always @(notifier_D33) begin
    mem[AL][33] = 1'bx;
end
always @(notifier_D34) begin
    mem[AL][34] = 1'bx;
end
always @(notifier_D35) begin
    mem[AL][35] = 1'bx;
end
always @(notifier_D36) begin
    mem[AL][36] = 1'bx;
end
always @(notifier_D37) begin
    mem[AL][37] = 1'bx;
end
always @(notifier_D38) begin
    mem[AL][38] = 1'bx;
end
always @(notifier_D39) begin
    mem[AL][39] = 1'bx;
end
always @(notifier_D40) begin
    mem[AL][40] = 1'bx;
end
always @(notifier_D41) begin
    mem[AL][41] = 1'bx;
end
always @(notifier_D42) begin
    mem[AL][42] = 1'bx;
end
always @(notifier_D43) begin
    mem[AL][43] = 1'bx;
end
always @(notifier_D44) begin
    mem[AL][44] = 1'bx;
end
always @(notifier_D45) begin
    mem[AL][45] = 1'bx;
end
always @(notifier_D46) begin
    mem[AL][46] = 1'bx;
end
always @(notifier_D47) begin
    mem[AL][47] = 1'bx;
end
always @(notifier_D48) begin
    mem[AL][48] = 1'bx;
end
always @(notifier_D49) begin
    mem[AL][49] = 1'bx;
end
always @(notifier_D50) begin
    mem[AL][50] = 1'bx;
end
always @(notifier_D51) begin
    mem[AL][51] = 1'bx;
end
always @(notifier_D52) begin
    mem[AL][52] = 1'bx;
end
always @(notifier_D53) begin
    mem[AL][53] = 1'bx;
end
always @(notifier_D54) begin
    mem[AL][54] = 1'bx;
end
always @(notifier_D55) begin
    mem[AL][55] = 1'bx;
end
always @(notifier_D56) begin
    mem[AL][56] = 1'bx;
end
always @(notifier_D57) begin
    mem[AL][57] = 1'bx;
end
always @(notifier_D58) begin
    mem[AL][58] = 1'bx;
end
always @(notifier_D59) begin
    mem[AL][59] = 1'bx;
end
always @(notifier_D60) begin
    mem[AL][60] = 1'bx;
end
always @(notifier_D61) begin
    mem[AL][61] = 1'bx;
end
always @(notifier_D62) begin
    mem[AL][62] = 1'bx;
end
always @(notifier_D63) begin
    mem[AL][63] = 1'bx;
end

always @(notifier_WEB or notifier_CLK) begin
    corrupt_mem;
    Q_n = {N{1'bx}};
end
`endif

always @(b_CLK) begin
    if (b_CLK === 1'bx) begin
        corrupt_mem;    //update
        Q_n= {N{1'bx}}; //update
`ifndef TSMC_NO_WARNING
        $display("Warning! Unknown violation %m \tinput CLK unknown/high-Z at simulation time %.3f\n", $realtime);
`endif
    end
end



always @(posedge b_CLK) begin
    if (b_CLK === 1'bx) begin

        corrupt_mem;

        Q_n= {N{1'bx}};
    end
    else begin

            AL = b_A;
            WEBL = b_WEB;
            CEBL = b_CEB;
            DL = b_D;
            BWEBL = b_BWEB;

        if (CEBL === 1'bx) begin

            $display("Warning! Unknown violation %m \tinput CEB unknown/high-Z at simulation time %.3f\n", $realtime);

            corrupt_mem;
            Q_n = {N{1'bx}};
        end
        else if (CEBL === 1'b0) begin
            if (WEBL === 1'bx ) begin
`ifndef TSMC_NO_WARNING
                $display("Warning! Unknown violation %m \tinput WEB unknown/high-Z at simulation time %.3f\n", $realtime);

`endif
        

                corrupt_mem;
                Q_n = {N{1'bx}};

            end
            else if (WEBL === 1'b0) begin

                if(^AL === 1'bx) begin
                    corrupt_mem;
`ifndef TSMC_NO_WARNING
                    $display("Warning! Unknown violation %m \tinput A unknown/high-Z at simulation time %.3f\n", $realtime);
`endif
                end
                else if(AL > W - 1) begin
`ifndef TSMC_NO_WARNING
                    $display("Warning! Out of range access to %m \tinput A cannot be decoded to a valid address at simulation time %.3f\n", $realtime);
`endif

                end
                
                else if(^BWEBL === 1'bx) begin
`ifndef TSMC_NO_WARNING
                    $display("Warning! Unknown violation %m \tinput BWEB unknown/high-Z at simulation time %.3f\n", $realtime);

`endif
                    for(i=0; i<N; i=i+1) begin
                        mem[AL][i] = 1'bx;
                    end
                end
                else if(^DL === 1'bx) begin
`ifndef TSMC_NO_WARNING
                    $display("Warning! Unknown violation %m \tinput D unknown/high-Z at simulation time %.3f\n", $realtime);

`endif
                    mem[AL] = (DL & (~BWEBL)) ^ (mem[AL] & BWEBL);
                end

        
        
                else begin
                    mem[AL] = (DL & (~BWEBL)) ^ (mem[AL] & BWEBL);
                end
            end
            else if (WEBL === 1'b1) begin
                if(^AL === 1'bx) begin
`ifndef TSMC_NO_WARNING
                    $display("Warning! Unknown violation %m \tinput A unknown/high-Z at simulation time %.3f\n", $realtime);

`endif
                    Q_n = {N{1'bx}};
                end
                else if(AL > W - 1) begin
        `ifndef TSMC_NO_WARNING
                    $display("Warning! Out of range access to %m \tinput A cannot be decoded to a valid address at simulation time %.3f\n", $realtime);
        `endif
                end
                else if(^BWEBL === 1'bx) begin
`ifndef TSMC_NO_WARNING
                    $display("Warning! Unknown violation %m \tinput BWEB unknown/high-Z at simulation time %.3f\n", $realtime);

`endif
                end
                else if(^DL === 1'bx) begin
`ifndef TSMC_NO_WARNING
                    $display("Warning! Unknown violation %m \tinput D unknown/high-Z at simulation time %.3f\n", $realtime);

`endif
                end



    `ifdef TSMC_UNIT_DELAY
                #(`SRAM_DELAY);
                Q_n = (mem[AL] & mem_sa0[AL]) | mem_sa1[AL];
    `else
                Q_n = {N{1'bx}};
                #0.001
                Q_n = (mem[AL] & mem_sa0[AL]) | mem_sa1[AL];
    `endif

            end
        end // end of if (CEBL === 1'b0)
    end
end


task corrupt_mem;   // USAGE: call this task to set core memory to unknown.
    integer i;
    begin 
        for (i = 0; i < W; i = i + 1) begin	 
            mem[i]	= {N{1'bx}};
        end
    end 
endtask

// Task for Loading a perdefined set of data from an external file.
task PreloadData;   // USAGE: initial inst.loadLP2PRF ("file_name");
    input [W*N:1] infile;  // Max 256 character File Name
    begin
        $display ("%m: Reading file, %0s, into the register file", infile);
        $readmemh (infile, mem, 0, W-1);
    end
endtask







task InjectSA;     // USAGE: inst.InjectSA(address, index, redundancy);
    input [M - 1:0] address;
    input [5:0] index;
    input redundancy;
    integer sum;
    integer i;
    reg sa1;
    reg sa0;
    begin 
        if (redundancy === 1'b0) begin
            mem_sa0[address][index] = 1'b0;
            mem_sa1[address][index] = 1'b0;
            sum = 0;
            for (i = 0; i < N; i = i + 1) begin
                if (~mem_sa0[address][i] == 1'b1) begin
                    sum = sum +1 ;
                end
                if (mem_sa1[address][i] == 1'b1) begin
                    sum = sum +1 ;
                end
            end
            $display ("A s-a-0 error injected at address location %d = %b, current SA errors in this address is %d", address, ({N{1'bx}} &
            mem_sa0[address]) | mem_sa1[address], sum);
        end 
        else if (redundancy === 1'b1) begin
            mem_sa1[address][index] = 1'b1;
            mem_sa0[address][index] = 1'b1;
            sum = 0;
            for (i = 0; i < N; i = i + 1) begin
                if (~mem_sa0[address][i] == 1'b1) begin
                    sum = sum +1 ;
                end
                if (mem_sa1[address][i] == 1'b1) begin
                    sum = sum +1 ;
                end
            end
            $display ("A s-a-1 error injected at address location %d = %b, current SA errors in this address is %d", address, ({N{1'bx}} &
            mem_sa0[address]) | mem_sa1[address], sum);
        end
    end 
endtask

// Task for printing the memory between specified addresses..
task PrintMemoryFromTo;     // USAGE: inst.PrintMemoryFromTo(from, to);
    input [M - 1:0] from;   // memory content are printed, start from this address.
    input [M - 1:0] to;     // memory content are printed, end at this address.
    integer i;
    begin 
        $display ("Dumping register file...");
        $display("@    Address, content-----");
        for (i = from; i <= to; i = i + 1) begin
            if(i<W) begin
                $display("@%d, %b", i, mem[i]);
            end
            else begin
                $display("Warning! task PrintMemoryFromTo out of range (A = %d)!\n", i);
            end
        end 
    end
endtask

// Task for printing entire memory, including normal array and redundancy array.
task PrintMemory;   // USAGE: inst.PrintMemory;
    integer i;
    begin
        $display ("Dumping register file...");
        $display("@    Address, content-----");
        for (i = 0; i < W; i = i + 1) begin
            $display("@%d, %b", i, mem[i]);
        end 
    end
endtask

endmodule

`endcelldefine
