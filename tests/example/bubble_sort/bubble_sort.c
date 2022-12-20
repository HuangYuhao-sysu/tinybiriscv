

#define printf xprintf

extern void xprintf();
extern void uart_init();

void main() {
    int i;
    int j;
    int tmp_data;
    int N=7;
    int values[] = {
        -1, 20, 7, -8, 6, 123, 0
    };
    uart_init();
    printf("Before sorting: \n");
    for (i=0; i<N; i++) printf("%d ", values[i]);

    for (i=0; i<N-1; i++){
        for (j=0; j<N-1-i; j++){
            if (values[j] > values[j+1]){
                tmp_data = values[j];
                values[j] = values[j+1];
                values[j+1] = tmp_data;
            }
        }
    }

    printf("\nAfter sorting: \n");
    for (i=0; i<N; i++) printf("%d ", values[i]);
}

