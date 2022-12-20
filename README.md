# Tinybiriscv是biriscv为核，设计总线和外设，并进行测试的一个SoC
目的：
1. 学习总线知识，搭建SoC平台
2. 无cache版本的biriscv SoC可方便后续跑分
3. 参考tiny搭建总线外设环境，外设地址不变，更加方便的实现跑分功能
4. 后续转CSCD用

# 2022/12/20已测试内容
riscv-arch-test除了I-MISALIGN_JMP-01，其他都通过，这个没看出来是啥指令，先当做全部过
了，现在上传github备份一波，其中搭建了快速测试48套指令的环境，当然内存地址有些没有对齐，
但是不影响快速测试。

# 目录说明

tests：所有用到的tests，包括riscv-arch-test，还有编译的c，跑分程序等

vcs：vcs前仿工程