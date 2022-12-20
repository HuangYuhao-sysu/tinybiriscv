long time()
{
    int cycles;
    asm volatile ("rdcycle %0" : "=r"(cycles));
    return cycles;
}

int main(){
    int a = 10;
    extern void xprintf ();
    extern void uart_init();

    uart_init();
    xprintf("Test Number:%D",a);
}
