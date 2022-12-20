// =============================================================================
// Project Name        : tinybiriscv
// Email               : huangyh76@mail2.sysu.edu.cn
// Company             : Sun Yat-Sen University
// Create Time         : 2022/12/17
// File Name           : rib.v
// Module Name         : rib
// Designer            : Huangyh
// Editor              : vs code
//
// *****************************************************************************
// Abstract            : rib for biriscv tcm core
//
// *****************************************************************************
//
// Modification History:
// Date                By              Version             Change Description
// -----------------------------------------------------------------------------
// 2022/12/17       Huangyh             1.0                         none
//
// =============================================================================

`timescale 1ns / 1ps

module rib (
    input               clk,    // Clock
    input               rst_n,    // Asynchronous reset active low

    // master 0, cpu core 访问数据存储
    input       [31:0]  m0_addr_i,
    input       [31:0]  m0_data_i,
    input               m0_rd_i,
    input       [3:0]   m0_wr_i,
    input       [10:0]  m0_req_tag_i,
    input               m0_invalidate_i,
    input               m0_writeback_i,
    input               m0_flush_i,
    output  reg [31:0]  m0_data_o,
    output  reg         m0_ack_o,
    output  reg [10:0]  m0_resp_tag_o,

    // master 1, cpu core 访问指令存储
    input       [31:0]  m1_addr_i,
    input               m1_req_i,   // 其实是cpu访问指令存储读使�??
    output  reg [63:0]  m1_data_o,
    output  reg         m1_ack_o,

    // master 2, jtag master
    input       [31:0]  m2_addr_i,
    input       [31:0]  m2_data_i,
    input               m2_req_i,
    input               m2_we_i,
    output  reg [31:0]  m2_data_o,

    // master 3, uart debug master
    input       [31:0]  m3_addr_i,
    input       [31:0]  m3_data_i,
    input               m3_req_i,
    input               m3_we_i,
    output  reg [31:0]  m3_data_o,

    // slave 0, 指令存储，一次取回两条指�??, 访问SRAM
    input       [63:0]  s0_data_i,
    output  reg [31:0]  s0_addr_o,
    output  reg         s0_ceb_o,   // 低有�??
    output  reg         s0_web_o,   // 低有�??
    output  reg [63:0]  s0_bweb_o,  // 低有�??
    output  reg [63:0]  s0_data_o,

    // slave 1, 数据存储, 访问SRAM
    input       [63:0]  s1_data_i,
    output  reg [31:0]  s1_addr_o,
    output  reg         s1_ceb_o,   // 低有�??
    output  reg         s1_web_o,   // 低有�??
    output  reg [63:0]  s1_bweb_o,  // 低有�??
    output  reg [63:0]  s1_data_o,

    // slave 2, timer
    input       [31:0]  s2_data_i,  // 从设�??2读到的数�??
    output  reg [31:0]  s2_addr_o,  // 从设�??2读�?�写地址
    output  reg [31:0]  s2_data_o,  // 从设�??2写数�??
    output  reg         s2_we_o,    // 从设�??2写标�??

    // slave 3, uart
    input       [31:0]  s3_data_i,  // 从设�??3读到的数�??
    output  reg [31:0]  s3_addr_o,  // 从设�??3读�?�写地址
    output  reg [31:0]  s3_data_o,  // 从设�??3写数�??
    output  reg         s3_we_o,    // 从设�??3写标�??

    // slave 4, gpio
    input       [31:0]  s4_data_i,  // 从设�??4读到的数�??
    output  reg [31:0]  s4_addr_o,  // 从设�??4读�?�写地址
    output  reg [31:0]  s4_data_o,  // 从设�??4写数�??
    output  reg         s4_we_o,    // 从设�??4写标�??

    // slave 5, spi
    input       [31:0]  s5_data_i,  // 从设�??5读到的数�??
    output  reg [31:0]  s5_addr_o,  // 从设�??5读�?�写地址
    output  reg [31:0]  s5_data_o,  // 从设�??5写数�??
    output  reg         s5_we_o,    // 从设�??5写标�??

    output  reg         hold_flag_o
);

/*内存空间分配
|---------------|
|----- SPI -----|
|---------------| 0x5000_0000
|---------------|
|---- GPIO -----|
|---------------| 0x4000_0000
|---------------|
|---- UART -----|
|---------------| 0x3000_0000
|---------------|
|---- TIMER ----|
|---------------| 0x2000_0000
|---------------|
|----- RAM -----|
|---------------| 0x1000_0000
|---------------|
|----- ROM -----|
|---------------| 0x0000_0000
*/

//==============================================================================
// 定义内存空间中高四位以区分不同slave
//==============================================================================
localparam slave_0 = 4'b0000;
localparam slave_1 = 4'b0001;
localparam slave_2 = 4'b0010;
localparam slave_3 = 4'b0011;
localparam slave_4 = 4'b0100;
localparam slave_5 = 4'b0101;

//==============================================================================
// 定义4个master授权标志
//==============================================================================
localparam grant0 = 2'd0;   // cpu core数据存储访问
localparam grant1 = 2'd1;   // cpu core指令存储访问
localparam grant2 = 2'd2;   // jtag 访问
localparam grant3 = 2'd3;   // uart debug 访问

// =========================================================================== \
// ============================= Internal signals ============================
// =========================================================================== /
wire    [3:0]   req;
reg     [1:0]   grant;

// =========================================================================== \
// --------------------------------- Main Code ---------------------------------
// =========================================================================== /

//==============================================================================
// 主设备请求信�??, cpu core数据存储访问，需要读或写时则访问
//==============================================================================
assign req = {m3_req_i, m2_req_i, m1_req_i, (m0_rd_i || (|m0_wr_i))};

//==============================================================================
// 固定优先级仲裁，优先级由高到低为：m3: uart debug, m0: 数据存储, m2: jtag
// m1: 指令存储
//==============================================================================
always @(*) begin
    case (1'b1)
        req[3]: begin
            grant = grant3;
            hold_flag_o = `HoldEnable;
        end
        req[0]: begin
            grant = grant0;
            hold_flag_o = `HoldEnable;
        end
        req[2]: begin
            grant = grant2;
            hold_flag_o = `HoldEnable;
        end
        req[1]: begin
            grant = grant1;
            hold_flag_o = `HoldDisable;
        end
        default : begin
            grant = grant1;
            hold_flag_o = `HoldDisable;
        end
    endcase
end

//==============================================================================
// 根据仲裁结果，生成slave输出
//==============================================================================
always @(*) begin
    s0_addr_o   =  0;
    s0_ceb_o    =  1;
    s0_web_o    =  1;
    s0_bweb_o   =  64'hffff_ffff_ffff_ffff;
    s0_data_o   =  0;
    s1_addr_o   =  0;
    s1_ceb_o    =  1;
    s1_web_o    =  1;
    s1_bweb_o   =  64'hffff_ffff_ffff_ffff;
    s1_data_o   =  0;
    s2_addr_o   =  0;
    s2_data_o   =  0;
    s2_we_o     =  0;
    s3_addr_o   =  0;
    s3_data_o   =  0;
    s3_we_o     =  0;
    s4_addr_o   =  0;
    s4_data_o   =  0;
    s4_we_o     =  0;
    s5_addr_o   =  0;
    s5_data_o   =  0;
    s5_we_o     =  0;

    case (grant)
        grant0: begin   // 授权master0访问 cpu core 数据存储访问
            case (m0_addr_i[31:28])
                slave_0: begin
                    // slave 0输出
                    s0_addr_o    =  {{4'h0}, {m0_addr_i[27:0]}}>>3;
                    s0_ceb_o     =  1'b0;   // ceb低有�??
                    s0_web_o     =  ~(|m0_wr_i);
                    case (m0_addr_i[2])
                        1'b0: begin
                            s0_bweb_o = {32'hffff_ffff,{8{~m0_wr_i[3]}},{8{~m0_wr_i[2]}},{8{~m0_wr_i[1]}},{8{~m0_wr_i[0]}}};
                            s0_data_o = {32'd0, m0_data_i};
                        end
                        1'b1: begin
                            s0_bweb_o = {{8{~m0_wr_i[3]}},{8{~m0_wr_i[2]}},{8{~m0_wr_i[1]}},{8{~m0_wr_i[0]}},32'hffff_ffff};
                            s0_data_o = {m0_data_i, 32'd0};
                        end
                    endcase
                end

                slave_1: begin
                    s1_addr_o    =  {{4'h0}, {m0_addr_i[27:0]}}>>3;
                    s1_ceb_o     =  1'b0;   // ceb低有�??
                    s1_web_o     =  ~(|m0_wr_i);
                    case (m0_addr_i[2])
                        1'b0: begin
                            s1_bweb_o = {32'hffff_ffff,{8{~m0_wr_i[3]}},{8{~m0_wr_i[2]}},{8{~m0_wr_i[1]}},{8{~m0_wr_i[0]}}};
                            s1_data_o = {32'd0, m0_data_i};
                        end
                        1'b1: begin
                            s1_bweb_o = {{8{~m0_wr_i[3]}},{8{~m0_wr_i[2]}},{8{~m0_wr_i[1]}},{8{~m0_wr_i[0]}},32'hffff_ffff};
                            s1_data_o = {m0_data_i, 32'd0};
                        end
                    endcase
                end

                slave_2: begin
                    s2_addr_o    =  {{4'h0}, {m0_addr_i[27:0]}};
                    s2_data_o    =  m0_data_i;
                    s2_we_o      =  |m0_wr_i;
                end

                slave_3: begin
                    s3_addr_o    =  {{4'h0}, {m0_addr_i[27:0]}};
                    s3_data_o    =  m0_data_i;
                    s3_we_o      =  |m0_wr_i;
                end

                slave_4: begin
                    s4_addr_o    =  {{4'h0}, {m0_addr_i[27:0]}};
                    s4_data_o    =  m0_data_i;
                    s4_we_o      =  |m0_wr_i;
                end

                slave_5: begin
                    s5_addr_o    =  {{4'h0}, {m0_addr_i[27:0]}};
                    s5_data_o    =  m0_data_i;
                    s5_we_o      =  |m0_wr_i;
                end
                default : ;
            endcase
        end

        grant1: begin // 授权master1访问 cpu core指令存储访问
            case (m1_addr_i[31:28])
                slave_0: begin
                    // slave 0输出
                    s0_addr_o    =  {{4'h0}, {m1_addr_i[27:0]}}>>3;
                    s0_ceb_o     =  1'b0;   // ceb低有�??
                    s0_web_o     =  1'b1;
                    s0_bweb_o    =  64'hffff_ffff_ffff_ffff;
                    s0_data_o    =  0;
                end

                slave_1: begin
                    // slave 1输出
                    s1_addr_o    =  {{4'h0}, {m1_addr_i[27:0]}}>>3;
                    s1_ceb_o     =  1'b0;   // ceb低有�??
                    s1_web_o     =  1'b1;
                    s1_bweb_o    =  64'hffff_ffff_ffff_ffff;
                    s1_data_o    =  0;
                end

                slave_2: begin
                    s2_addr_o    =  {{4'h0}, {m1_addr_i[27:0]}};
                    s2_data_o    =  0;
                    s2_we_o      =  0;
                end

                slave_3: begin
                    s3_addr_o    =  {{4'h0}, {m1_addr_i[27:0]}};
                    s3_data_o    =  0;
                    s3_we_o      =  0;
                end
                
                slave_4: begin
                    s4_addr_o    =  {{4'h0}, {m1_addr_i[27:0]}};
                    s4_data_o    =  0;
                    s4_we_o      =  0;
                end

                slave_5: begin
                    s5_addr_o    =  {{4'h0}, {m1_addr_i[27:0]}};
                    s5_data_o    =  0;
                    s5_we_o      =  0;
                end

                default : /* default */;
            endcase
        end

        grant2: begin // 授权master2访问，jtag访问
            case (m2_addr_i[31:28])
                slave_0: begin
                    // slave 0输出
                    s0_addr_o    =  {{4'h0}, {m2_addr_i[27:0]}}>>3;
                    s0_ceb_o     =  ~m2_req_i;   // ceb低有�??
                    s0_web_o     =  ~m2_we_i;
                    case (m2_addr_i[2])
                        1'b0: begin
                            s0_bweb_o    =  64'hffff_ffff_0000_0000;
                            s0_data_o    =  {32'd0,m2_data_i};
                        end
                        1'b1: begin
                            s0_bweb_o    =  64'h0000_0000_ffff_ffff;
                            s0_data_o    =  {m2_data_i,32'd0};
                        end
                    endcase
                end

                slave_1: begin
                    // slave 1输出
                    s1_addr_o    =  {{4'h0}, {m2_addr_i[27:0]}}>>3;
                    s1_ceb_o     =  ~m2_req_i;   // ceb低有�??
                    s1_web_o     =  ~m2_we_i;
                    case (m2_addr_i[2])
                        1'b0: begin
                            s1_bweb_o    =  64'hffff_ffff_0000_0000;
                            s1_data_o    =  {32'd0,m2_data_i};
                        end
                        1'b1: begin
                            s1_bweb_o    =  64'h0000_0000_ffff_ffff;
                            s1_data_o    =  {m2_data_i,32'd0};
                        end
                    endcase
                end

                slave_2: begin
                    s2_addr_o    =  {{4'h0}, {m2_addr_i[27:0]}};
                    s2_data_o    =  m2_data_i;
                    s2_we_o      =  m2_we_i;
                end

                slave_3: begin
                    s3_addr_o    =  {{4'h0}, {m2_addr_i[27:0]}};
                    s3_data_o    =  m2_data_i;
                    s3_we_o      =  m2_we_i;
                end
                
                slave_4: begin
                    s4_addr_o    =  {{4'h0}, {m2_addr_i[27:0]}};
                    s4_data_o    =  m2_data_i;
                    s4_we_o      =  m2_we_i;
                end

                slave_5: begin
                    s5_addr_o    =  {{4'h0}, {m2_addr_i[27:0]}};
                    s5_data_o    =  m2_data_i;
                    s5_we_o      =  m2_we_i;
                end
                default : /* default */;
            endcase
        end

        grant3: begin // 授权master3访问，uart debug访问
            case (m3_addr_i[31:28])
                slave_0: begin
                    // slave 0输出
                    s0_addr_o    =  {{4'h0}, {m3_addr_i[27:0]}}>>3;
                    s0_ceb_o     =  ~m3_req_i;   // ceb低有�??
                    s0_web_o     =  ~m3_we_i;
                    case (m3_addr_i[2])
                        1'b0: begin
                            s0_bweb_o    =  64'hffff_ffff_0000_0000;
                            s0_data_o    =  {32'd0,m3_data_i};
                        end
                        1'b1: begin
                            s0_bweb_o    =  64'h0000_0000_ffff_ffff;
                            s0_data_o    =  {m3_data_i,32'd0};
                        end
                    endcase
                end

                slave_1: begin
                    // slave 1输出
                    s1_addr_o    =  {{4'h0}, {m3_addr_i[27:0]}}>>3;
                    s1_ceb_o     =  ~m3_req_i;   // ceb低有�??
                    s1_web_o     =  ~m3_we_i;
                    case (m3_addr_i[2])
                        1'b0: begin
                            s1_bweb_o    =  64'hffff_ffff_0000_0000;
                            s1_data_o    =  {32'd0,m3_data_i};
                        end
                        1'b1: begin
                            s1_bweb_o    =  64'h0000_0000_ffff_ffff;
                            s1_data_o    =  {m3_data_i,32'd0};
                        end
                    endcase
                end

                slave_2: begin
                    s2_addr_o    =  {{4'h0}, {m3_addr_i[27:0]}};
                    s2_data_o    =  m3_data_i;
                    s2_we_o      =  m3_we_i;
                end

                slave_3: begin
                    s3_addr_o    =  {{4'h0}, {m3_addr_i[27:0]}};
                    s3_data_o    =  m3_data_i;
                    s3_we_o      =  m3_we_i;
                end
                
                slave_4: begin
                    s4_addr_o    =  {{4'h0}, {m3_addr_i[27:0]}};
                    s4_data_o    =  m3_data_i;
                    s4_we_o      =  m3_we_i;
                end

                slave_5: begin
                    s5_addr_o    =  {{4'h0}, {m3_addr_i[27:0]}};
                    s5_data_o    =  m3_data_i;
                    s5_we_o      =  m3_we_i;
                end
                default : /* default */;
            endcase
        end
    endcase
end

//==============================================================================
// 根据仲裁结果，在下一周期选择返回给master的数�??
//==============================================================================
reg [1:0]   grant_r;
reg [31:0]  m0_addr_r;
reg [31:0]  m0_data_r;
reg         m0_rd_r;
reg [3:0]   m0_wr_r;
reg [10:0]  m0_req_tag_r;
reg         m0_invalidate_r;
reg         m0_writeback_r;
reg         m0_flush_r;
reg [31:0]  m1_addr_r;
reg         m1_req_r;
reg [31:0]  m2_addr_r;
reg [31:0]  m2_data_r;
reg         m2_req_r;
reg         m2_we_r;
reg [31:0]  m3_addr_r;
reg [31:0]  m3_data_r;
reg         m3_req_r;
reg         m3_we_r;

always @(posedge clk or negedge rst_n) begin
    if (rst_n == 1'b0) begin
        // reset
        grant_r         <=  grant1;
        m0_addr_r       <=  0;
        m0_data_r       <=  0;
        m0_rd_r         <=  0;
        m0_wr_r         <=  0;
        m0_req_tag_r    <=  0;
        m0_invalidate_r <=  0;
        m0_writeback_r  <=  0;
        m0_flush_r      <=  0;
        m1_addr_r       <=  0;
        m1_req_r        <=  0;
        m2_addr_r       <=  0;
        m2_data_r       <=  0;
        m2_req_r        <=  0;
        m2_we_r         <=  0;
        m3_addr_r       <=  0;
        m3_data_r       <=  0;
        m3_req_r        <=  0;
        m3_we_r         <=  0;
    end

    else begin
        grant_r         <= grant           ;
        m0_addr_r       <=  m0_addr_i      ;
        m0_data_r       <=  m0_data_i      ;
        m0_rd_r         <=  m0_rd_i        ;
        m0_wr_r         <=  m0_wr_i        ;
        m0_req_tag_r    <=  m0_req_tag_i   ;
        m0_invalidate_r <=  m0_invalidate_i;
        m0_writeback_r  <=  m0_writeback_i ;
        m0_flush_r      <=  m0_flush_i     ;
        m1_addr_r       <=  m1_addr_i      ;
        m1_req_r        <=  m1_req_i       ;
        m2_addr_r       <=  m2_addr_i      ;
        m2_data_r       <=  m2_data_i      ;
        m2_req_r        <=  m2_req_i       ;
        m2_we_r         <=  m2_we_i        ;
        m3_addr_r       <=  m3_addr_i      ;
        m3_data_r       <=  m3_data_i      ;
        m3_req_r        <=  m3_req_i       ;
        m3_we_r         <=  m3_we_i        ;
    end
end

always @(*) begin
    m0_data_o        =  0;
    m0_ack_o         =  0;
    m0_resp_tag_o    =  0;
    m1_data_o        =  0;
    m1_ack_o         =  0;
    m2_data_o        =  0;
    m3_data_o        =  0;

    case (grant_r)
        grant0: begin
            case (m0_addr_r[31:28])
                slave_0: begin
                    if (m0_addr_r[2] == 1'b0) begin
                        m0_data_o        =  s0_data_i[31:0];
                    end

                    else begin
                        m0_data_o        =  s0_data_i[63:32];
                    end

                    m0_ack_o         =  (m0_rd_r || m0_wr_r != 4'b0 || m0_flush_r || m0_invalidate_r || m0_writeback_r);
                    m0_resp_tag_o    =  m0_req_tag_r;
                end

                slave_1: begin
                    if (m0_addr_r[2] == 1'b0) begin
                        m0_data_o        =  s1_data_i[31:0];
                    end

                    else begin
                        m0_data_o        =  s1_data_i[63:32];
                    end

                    m0_ack_o         =  (m0_rd_r || m0_wr_r != 4'b0 || m0_flush_r || m0_invalidate_r || m0_writeback_r);
                    m0_resp_tag_o    =  m0_req_tag_r;
                end

                slave_2: begin
                    m0_data_o        =  s2_data_i;
                    m0_ack_o         =  (m0_rd_r || m0_wr_r != 4'b0 || m0_flush_r || m0_invalidate_r || m0_writeback_r);
                    m0_resp_tag_o    =  m0_req_tag_r;
                end

                slave_3: begin
                    m0_data_o        =  s3_data_i;
                    m0_ack_o         =  (m0_rd_r || m0_wr_r != 4'b0 || m0_flush_r || m0_invalidate_r || m0_writeback_r);
                    m0_resp_tag_o    =  m0_req_tag_r;
                end

                slave_4: begin
                    m0_data_o        =  s4_data_i;
                    m0_ack_o         =  (m0_rd_r || m0_wr_r != 4'b0 || m0_flush_r || m0_invalidate_r || m0_writeback_r);
                    m0_resp_tag_o    =  m0_req_tag_r;
                end

                slave_5: begin
                    m0_data_o        =  s5_data_i;
                    m0_ack_o         =  (m0_rd_r || m0_wr_r != 4'b0 || m0_flush_r || m0_invalidate_r || m0_writeback_r);
                    m0_resp_tag_o    =  m0_req_tag_r;
                end
                default : /* default */;
            endcase
        end

        grant1: begin
            case (m1_addr_r[31:28])
                slave_0: begin
                    m1_data_o    =  s0_data_i;
                    m1_ack_o     =  1'b1;
                end

                slave_1: begin
                    m1_data_o    =  s1_data_i;
                    m1_ack_o     =  1'b1;
                end

                slave_2: begin
                    m1_data_o    =  {32'd0,s2_data_i};
                    m1_ack_o     =  1'b1;
                end

                slave_3: begin
                    m1_data_o    =  {32'd0,s3_data_i};
                    m1_ack_o     =  1'b1;
                end

                slave_4: begin
                    m1_data_o    =  {32'd0,s4_data_i};
                    m1_ack_o     =  1'b1;
                end

                slave_5: begin
                    m1_data_o    =  {32'd0,s5_data_i};
                    m1_ack_o     =  1'b1;
                end
                
                default : /* default */;
            endcase
        end

        grant2: begin
            case (m2_addr_r[31:28])
                slave_0: begin
                    if (m2_addr_r[2] == 1'b0) begin
                        m2_data_o        =  s0_data_i[31:0];
                    end

                    else begin
                        m2_data_o        =  s0_data_i[63:32];
                    end
                end

                slave_1: begin
                    if (m2_addr_r[2] == 1'b0) begin
                        m2_data_o        =  s1_data_i[31:0];
                    end

                    else begin
                        m2_data_o        =  s1_data_i[63:32];
                    end
                end

                slave_2: begin
                    m2_data_o    =  s2_data_i;
                end

                slave_3: begin
                    m2_data_o    =  s3_data_i;
                end

                slave_4: begin
                    m2_data_o    =  s4_data_i;
                end

                slave_5: begin
                    m2_data_o    =  s5_data_i;
                end
                
                default : /* default */;
            endcase
        end

        grant3: begin
            case (m3_addr_r[31:28])
                slave_0: begin
                    if (m3_addr_r[2] == 1'b0) begin
                        m3_data_o        =  s0_data_i[31:0];
                    end

                    else begin
                        m3_data_o        =  s0_data_i[63:32];
                    end
                end

                slave_1: begin
                    if (m3_addr_r[2] == 1'b0) begin
                        m3_data_o        =  s1_data_i[31:0];
                    end

                    else begin
                        m3_data_o        =  s1_data_i[63:32];
                    end
                end

                slave_2: begin
                    m3_data_o    =  s2_data_i;
                end

                slave_3: begin
                    m3_data_o    =  s3_data_i;
                end

                slave_4: begin
                    m3_data_o    =  s4_data_i;
                end

                slave_5: begin
                    m3_data_o    =  s5_data_i;
                end
                
                default : /* default */;
            endcase
        end
        default : /* default */;
    endcase
end

endmodule
