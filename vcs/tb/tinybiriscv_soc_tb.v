`timescale 1 ns / 1 ps

`include "defines.v"

// testbench module
module tinybiriscv_soc_tb;

// tinyriscv_soc_top Inputs
reg   clk;
reg   rst_n;
reg   uart_debug_pin;      
reg   uart_rx_pin;
reg   jtag_TCK;
reg   jtag_TMS;
reg   jtag_TDI;
reg   spi_miso;

// tinyriscv_soc_top Outputs
wire  halted_ind;
wire  uart_tx_pin;
wire  jtag_TDO;
wire  spi_mosi;
wire  spi_ss;
wire  spi_clk;

// tinyriscv_soc_top Bidirs
wire  [1:0] gpio;

tinybiriscv_soc_top  u_tinybiriscv_soc_top (
    .clk                     ( clk              ),
    .rst_n                   ( rst_n            ),
    .uart_debug_pin          ( uart_debug_pin   ),
    .uart_rx_pin             ( uart_rx_pin      ),
    .jtag_TCK                ( jtag_TCK         ),
    .jtag_TMS                ( jtag_TMS         ),
    .jtag_TDI                ( jtag_TDI         ),
    .spi_miso                ( spi_miso         ),

    .halted_ind              ( halted_ind       ),
    .uart_tx_pin             ( uart_tx_pin      ),
    .jtag_TDO                ( jtag_TDO         ),
    .spi_mosi                ( spi_mosi         ),
    .spi_ss                  ( spi_ss           ),
    .spi_clk                 ( spi_clk          ),

    .gpio                    ( gpio             )
);

localparam CYCLE = 5;
//时钟周期，单位为ns，可在此修改时钟周期。
//生成本地时钟50M
initial begin
    clk = 0;
    forever
    #(CYCLE/2)
    clk=~clk;
end
//产生复位信号
initial begin
    rst_n = 1;
    #2;
    rst_n = 0;
    #(CYCLE*3);
    rst_n = 1;
end

initial begin
    uart_debug_pin = 0;
    uart_rx_pin = 0;
    jtag_TCK    = 0;
    jtag_TMS    = 0;
    jtag_TDI    = 0;
    spi_miso    = 0;
end

// sim timeout
initial begin
    #100000;
    $display("Time Out.");
    $finish;
end

reg [7:0] mem [131071:0];
integer i;
integer f;

`define test1 I-ADDI-01.elf.bin;

// read mem data
initial begin
    //$readmemh ("inst.data", tinyriscv_soc_top_0.u_rom._rom);
    //$readmemh ("/home/huangyh/Desktop/tinybiriscv/tests/mem/rom_bubble.mem", u_tinybiriscv_soc_top.u_rom.rom);
    //f = $fopen("/home/huangyh/Desktop/tinyriscv/tests/example/hello/hello.bin", "r");
    //f = $fopen("/home/huangyh/Desktop/tinyriscv/tests/example/dhrystone/dhrystone.bin", "r");
    //f = $fopen("/home/huangyh/Desktop/tinyriscv/tests/example/coremark/coremark.bin", "r");
    //f = $fopen("/home/huangyh/Desktop/tinyriscv/tests/example/bubble_sort/bubble_sort.bin", "r");
    //f = $fopen("/home/huangyh/Desktop/tinyriscv/tests/example/test/test.bin", "r");
    
    // riscv arch tests
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-ADD-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-ADDI-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-AND-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-ANDI-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-AUIPC-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-BEQ-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-BGE-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-BGEU-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-BLT-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-BLTU-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-BNE-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-DELAY_SLOTS-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-EBREAK-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-ECALL-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-ENDIANESS-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-IO-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-JAL-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-JALR-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-LB-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-LBU-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-LH-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-LHU-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-LUI-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-LW-01.elf.bin","r");
    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-MISALIGN_JMP-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-MISALIGN_LDST-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-NOP-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-OR-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-ORI-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-RF_size-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-RF_width-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-RF_x0-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-SB-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-SH-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-SLL-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-SLLI-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-SLT-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-SLTI-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-SLTIU-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-SLTU-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-SRA-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-SRAI-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-SRL-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-SRLI-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-SUB-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-SW-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-XOR-01.elf.bin","r");
//    f = $fopen("/home/huangyh/Desktop/tinybiriscv/tests/riscv-arch-test/rv32i/I-XORI-01.elf.bin","r");
    i = $fread(mem, f);
    for (i=0; i<65535; i=i+1)
      u_tinybiriscv_soc_top.u_rom.write(i, mem[i]);
end

// generate wave file, used by gtkwave
initial begin
    $dumpfile("tinybiriscv_soc_tb.vcd");
    $dumpvars(0, tinybiriscv_soc_tb);
end

integer out_file;

initial begin
    #5000;
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-ADD-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-ADDI-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-AND-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-ANDI-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-AUIPC-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-BEQ-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-BGE-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-BGEU-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-BLT-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-BLTU-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-BNE-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-DELAY_SLOTS-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-EBREAK-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-ECALL-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-ENDIANESS-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-IO-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-JAL-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-JALR-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-LB-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-LBU-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-LH-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-LHU-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-LUI-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-LW-01.elf.bin.output","w");
    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-MISALIGN_JMP-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-MISALIGN_LDST-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-NOP-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-OR-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-ORI-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-RF_size-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-RF_width-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-RF_x0-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-SB-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-SH-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-SLL-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-SLLI-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-SLT-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-SLTI-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-SLTIU-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-SLTU-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-SRA-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-SRAI-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-SRL-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-SRLI-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-SUB-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-SW-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-XOR-01.elf.bin.output","w");
//    out_file = $fopen("/home/huangyh/Desktop/tinybiriscv/vcs/work/result/I-XORI-01.elf.bin.output","w");
    
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1024][31:0]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1024][63:32]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1025][31:0]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1025][63:32]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1026][31:0]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1026][63:32]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1027][31:0]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1027][63:32]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1028][31:0]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1028][63:32]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1029][31:0]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1029][63:32]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1030][31:0]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1030][63:32]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1031][31:0]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1031][63:32]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1032][31:0]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1032][63:32]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1033][31:0]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1033][63:32]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1034][31:0]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1034][63:32]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1035][31:0]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1035][63:32]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1036][31:0]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1036][63:32]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1037][31:0]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1037][63:32]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1038][31:0]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1038][63:32]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1039][31:0]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1039][63:32]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1040][31:0]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1040][63:32]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1041][31:0]);
    $fdisplay(out_file,"%h",u_tinybiriscv_soc_top.u_rom.rom[1041][63:32]);
    $fclose(out_file);
end

endmodule

