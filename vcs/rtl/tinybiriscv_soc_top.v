// =============================================================================
// Project Name        : tinybiriscv
// Email               : huangyh76@mail2.sysu.edu.cn
// Company             : Sun Yat-Sen University
// Create Time         : 2022/12/17
// File Name           : tinybiriscv_soc_top.v
// Module Name         : tinybiriscv_soc_top
// Designer            : Huangyh
// Editor              : vs code
//
// *****************************************************************************
// Abstract            : biriscv core + tiny peripheral circuits
//
// *****************************************************************************
//
// Modification History:
// Date                By              Version             Change Description
// -----------------------------------------------------------------------------
// 2022/12/17       Huangyh             1.0                         none
//
// =============================================================================

`include "defines.v"

`timescale 1ns / 1ps

module tinybiriscv_soc_top (
    input                   clk,      // Clock
    input                   rst_n,    // Asynchronous reset active low

    output  reg             over,         // 测试是否完成信号
    output  reg             succ,         // 测试是否成功信号

    output  wire            halted_ind,  // jtag是否已经halt住CPU信号

    input   wire            uart_debug_pin, // 串口下载使能引脚

    output  wire            uart_tx_pin, // UART发送引脚
    input   wire            uart_rx_pin,  // UART接收引脚
    inout   wire    [1:0]   gpio,    // GPIO引脚

    input   wire            jtag_TCK,     // JTAG TCK引脚
    input   wire            jtag_TMS,     // JTAG TMS引脚
    input   wire            jtag_TDI,     // JTAG TDI引脚
    output  wire            jtag_TDO,    // JTAG TDO引脚

    input   wire            spi_miso,     // SPI MISO引脚
    output  wire            spi_mosi,    // SPI MOSI引脚
    output  wire            spi_ss,      // SPI SS引脚
    output  wire            spi_clk      // SPI CLK引脚
);

// =========================================================================== \
// ============================= Internal signals ============================
// =========================================================================== /
// riscv_core Inputs
wire            intr_i;

// riscv_core Outputs
wire            mem_d_cacheable_o;
wire            mem_i_flush_o;
wire            mem_i_invalidate_o;

// rib Inputs
wire  [31:0]    m0_addr_i;
wire  [31:0]    m0_data_i;
wire            m0_rd_i;
wire  [3:0]     m0_wr_i;
wire  [10:0]    m0_req_tag_i;
wire            m0_invalidate_i;
wire            m0_writeback_i;
wire            m0_flush_i;
wire  [31:0]    m1_addr_i;
wire            m1_req_i;
wire  [31:0]    m2_addr_i;
wire  [31:0]    m2_data_i;
wire            m2_req_i;
wire            m2_we_i;
wire  [31:0]    m3_addr_i;
wire  [31:0]    m3_data_i;
wire            m3_req_i;
wire            m3_we_i;
wire  [63:0]    s0_data_i;
wire  [63:0]    s1_data_i;
wire  [31:0]    s2_data_i;
wire  [31:0]    s3_data_i;
wire  [31:0]    s4_data_i;
wire  [31:0]    s5_data_i;

// rib Outputs
wire  [31:0]    m0_data_o;
wire            m0_ack_o;
wire  [10:0]    m0_resp_tag_o;
wire  [63:0]    m1_data_o;
wire            m1_ack_o;
wire  [31:0]    m2_data_o;
wire  [31:0]    m3_data_o;
wire  [31:0]    s0_addr_o;
wire            s0_ceb_o;
wire            s0_web_o;
wire  [63:0]    s0_bweb_o;
wire  [63:0]    s0_data_o;
wire  [31:0]    s1_addr_o;
wire            s1_ceb_o;
wire            s1_web_o;
wire  [63:0]    s1_bweb_o;
wire  [63:0]    s1_data_o;
wire  [31:0]    s2_addr_o;
wire  [31:0]    s2_data_o;
wire            s2_we_o;
wire  [31:0]    s3_addr_o;
wire  [31:0]    s3_data_o;
wire            s3_we_o;
wire  [31:0]    s4_addr_o;
wire  [31:0]    s4_data_o;
wire            s4_we_o;
wire  [31:0]    s5_addr_o;
wire  [31:0]    s5_data_o;
wire            s5_we_o;
wire            hold_flag_o;

// =========================================================================== \
// --------------------------------- Main Code ---------------------------------
// =========================================================================== /

//==============================================================================
// 模块例化
//==============================================================================
riscv_core u_riscv_core (
    .clk_i              ( clk                ),
    .rst_n              ( rst_n              ),
    .mem_d_data_rd_i    ( m0_data_o          ),
    .mem_d_accept_i     ( 1'b1               ),
    .mem_d_ack_i        ( m0_ack_o           ),
    .mem_d_error_i      ( 1'd0               ),
    .mem_d_resp_tag_i   ( m0_resp_tag_o      ),
    .mem_i_accept_i     ( 1'b1               ),
    .mem_i_valid_i      ( m1_ack_o           ),
    .mem_i_error_i      ( 1'b0               ),
    .mem_i_inst_i       ( m1_data_o          ),
    .intr_i             ( intr_i             ),
    .reset_vector_i     ( 32'd0              ),
    .cpu_id_i           ( 32'd0              ),
    .hold_flag_i        ( hold_flag_o        ),

    .mem_d_addr_o       ( m0_addr_i          ),
    .mem_d_data_wr_o    ( m0_data_i          ),
    .mem_d_rd_o         ( m0_rd_i            ),
    .mem_d_wr_o         ( m0_wr_i            ),
    .mem_d_cacheable_o  ( mem_d_cacheable_o  ),
    .mem_d_req_tag_o    ( m0_req_tag_i       ),
    .mem_d_invalidate_o ( m0_invalidate_i    ),
    .mem_d_writeback_o  ( m0_writeback_i     ),
    .mem_d_flush_o      ( m0_flush_i         ),
    .mem_i_rd_o         ( m1_req_i           ),
    .mem_i_flush_o      ( mem_i_flush_o      ),
    .mem_i_invalidate_o ( mem_i_invalidate_o ),
    .mem_i_pc_o         ( m1_addr_i          )
);

rib  u_rib (
    .clk             ( clk             ),
    .rst_n           ( rst_n           ),
    .m0_addr_i       ( m0_addr_i       ),
    .m0_data_i       ( m0_data_i       ),
    .m0_rd_i         ( m0_rd_i         ),
    .m0_wr_i         ( m0_wr_i         ),
    .m0_req_tag_i    ( m0_req_tag_i    ),
    .m0_invalidate_i ( m0_invalidate_i ),
    .m0_writeback_i  ( m0_writeback_i  ),
    .m0_flush_i      ( m0_flush_i      ),
    .m1_addr_i       ( m1_addr_i       ),
    .m1_req_i        ( m1_req_i        ),
    .m2_addr_i       ( m2_addr_i       ),
    .m2_data_i       ( m2_data_i       ),
    .m2_req_i        ( m2_req_i        ),
    .m2_we_i         ( m2_we_i         ),
    .m3_addr_i       ( m3_addr_i       ),
    .m3_data_i       ( m3_data_i       ),
    .m3_req_i        ( m3_req_i        ),
    .m3_we_i         ( m3_we_i         ),
    .s0_data_i       ( s0_data_i       ),
    .s1_data_i       ( s1_data_i       ),
    .s2_data_i       ( s2_data_i       ),
    .s3_data_i       ( s3_data_i       ),
    .s4_data_i       ( s4_data_i       ),
    .s5_data_i       ( s5_data_i       ),

    .m0_data_o       ( m0_data_o       ),
    .m0_ack_o        ( m0_ack_o        ),
    .m0_resp_tag_o   ( m0_resp_tag_o   ),
    .m1_data_o       ( m1_data_o       ),
    .m1_ack_o        ( m1_ack_o        ),
    .m2_data_o       ( m2_data_o       ),
    .m3_data_o       ( m3_data_o       ),
    .s0_addr_o       ( s0_addr_o       ),
    .s0_ceb_o        ( s0_ceb_o        ),
    .s0_web_o        ( s0_web_o        ),
    .s0_bweb_o       ( s0_bweb_o       ),
    .s0_data_o       ( s0_data_o       ),
    .s1_addr_o       ( s1_addr_o       ),
    .s1_ceb_o        ( s1_ceb_o        ),
    .s1_web_o        ( s1_web_o        ),
    .s1_bweb_o       ( s1_bweb_o       ),
    .s1_data_o       ( s1_data_o       ),
    .s2_addr_o       ( s2_addr_o       ),
    .s2_data_o       ( s2_data_o       ),
    .s2_we_o         ( s2_we_o         ),
    .s3_addr_o       ( s3_addr_o       ),
    .s3_data_o       ( s3_data_o       ),
    .s3_we_o         ( s3_we_o         ),
    .s4_addr_o       ( s4_addr_o       ),
    .s4_data_o       ( s4_data_o       ),
    .s4_we_o         ( s4_we_o         ),
    .s5_addr_o       ( s5_addr_o       ),
    .s5_data_o       ( s5_data_o       ),
    .s5_we_o         ( s5_we_o         ),
    .hold_flag_o     ( hold_flag_o     )
);

`ifdef MEM_ASIC
TS1N65LPHSA1024X64M4F u_rom (
    .A     ( s0_addr_o[9:0] ),
    .D     ( s0_data_o ),
    .BWEB  ( s0_bweb_o ),
    .WEB   ( s0_web_o  ),
    .CEB   ( s0_ceb_o  ),
    .CLK   ( clk       ),
    .RTSEL ( 2'd0      ),
    .WTSEL ( 3'd0      ),

    .Q     ( s0_data_i )
);
`elsif MEM_VIVADO
`elsif MEM_RTL
rom u_rom (
    .clk    ( clk       ),
    .ceb    ( s0_ceb_o  ),
    .web    ( s0_web_o  ),
    .bweb   ( s0_bweb_o ),
    .addr_i ( s0_addr_o ),
    .data_i ( s0_data_o ),

    .data_o ( s0_data_i )
);
`endif

`ifdef MEM_ASIC
TS1N65LPHSA1024X64M4F u_ram (
    .A     ( s1_addr_o[9:0] ),
    .D     ( s1_data_o ),
    .BWEB  ( s1_bweb_o ),
    .WEB   ( s1_web_o  ),
    .CEB   ( s1_ceb_o  ),
    .CLK   ( clk       ),
    .RTSEL ( 2'd0      ),
    .WTSEL ( 3'd0      ),

    .Q     ( s1_data_i )
);
`elsif MEM_VIVADO
`elsif MEM_RTL
ram u_ram (
    .clk    ( clk       ),
    .ceb    ( s1_ceb_o  ),
    .web    ( s1_web_o  ),
    .bweb   ( s1_bweb_o ),
    .addr_i ( s1_addr_o ),
    .data_i ( s1_data_o ),

    .data_o ( s1_data_i )
);
`endif

timer  u_timer (
    .clk       ( clk       ),
    .rst_n     ( rst_n     ),
    .data_i    ( s2_data_o ),
    .addr_i    ( s2_addr_o ),
    .we_i      ( s2_we_o   ),

    .data_o    ( s2_data_i ),
    .int_sig_o ( intr_i    )
);

uart  u_uart (
    .clk    ( clk         ),
    .rst_n  ( rst_n       ),
    .we_i   ( s3_we_o     ),
    .addr_i ( s3_addr_o   ),
    .data_i ( s3_data_o   ),
    .rx_pin ( uart_rx_pin ),

    .data_o ( s3_data_i   ),
    .tx_pin ( uart_tx_pin )
);

// gpio
wire[1:0]   io_in;
wire[31:0]  gpio_ctrl;
wire[31:0]  gpio_data;

// io0
assign gpio[0] = (gpio_ctrl[1:0] == 2'b01)? gpio_data[0]: 1'bz;
assign io_in[0] = gpio[0];
// io1
assign gpio[1] = (gpio_ctrl[3:2] == 2'b01)? gpio_data[1]: 1'bz;
assign io_in[1] = gpio[1];

gpio  u_gpio (
    .clk          ( clk       ),
    .rst_n        ( rst_n     ),
    .we_i         ( s4_we_o   ),
    .addr_i       ( s4_addr_o ),
    .data_i       ( s4_data_o ),
    .io_pin_i     ( io_in     ),

    .data_o       ( s4_data_i ),
    .reg_ctrl     ( gpio_ctrl ),
    .reg_data     ( gpio_data )
);

spi  u_spi (
    .clk      ( clk       ),
    .rst_n    ( rst_n     ),
    .data_i   ( s5_data_o ),
    .addr_i   ( s5_addr_o ),
    .we_i     ( s5_we_o   ),
    .spi_miso ( spi_miso  ),

    .data_o   ( s5_data_i ),
    .spi_mosi ( spi_mosi  ),
    .spi_ss   ( spi_ss    ),
    .spi_clk  ( spi_clk   )
);

jtag_top #(
    .DMI_ADDR_BITS ( 6  ),
    .DMI_DATA_BITS ( 32 ),
    .DMI_OP_BITS   ( 2  ))
 u_jtag_top (
    .clk          ( clk              ),
    .jtag_rst_n   ( rst_n            ),
    .jtag_pin_TCK ( jtag_pin_TCK     ),
    .jtag_pin_TMS ( jtag_pin_TMS     ),
    .jtag_pin_TDI ( jtag_pin_TDI     ),
    .reg_rdata_i  ( jtag_reg_rdata_i ),
    .mem_rdata_i  ( m2_data_o        ),

    .jtag_pin_TDO ( jtag_pin_TDO     ),
    .reg_we_o     ( jtag_reg_we_o    ),
    .reg_addr_o   ( jtag_reg_addr_o  ),
    .reg_wdata_o  ( jtag_reg_wdata_o ),
    .mem_we_o     ( m2_we_i          ),
    .mem_addr_o   ( m2_addr_i        ),
    .mem_wdata_o  ( m2_data_i        ),
    .op_req_o     ( m2_req_i         ),
    .halt_req_o   ( jtag_halt_req_o  ),
    .reset_req_o  ( jtag_reset_req_o )
);

uart_debug  u_uart_debug (
    .clk         ( clk            ),
    .rst_n       ( rst_n          ),
    .debug_en_i  ( uart_debug_pin ),
    .mem_rdata_i ( m3_data_o      ),

    .req_o       ( m3_req_i       ),
    .mem_we_o    ( m3_we_i        ),
    .mem_addr_o  ( m3_addr_i      ),
    .mem_wdata_o ( m3_data_i      )
);

endmodule
