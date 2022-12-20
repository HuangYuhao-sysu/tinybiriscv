#define printf uart_init();xprintf

extern void xprintf ();
extern void uart_init ();

int main(){
    int a=10;
    printf("hello world");
    printf("Test Number:%U", a);
}
