long time()
{
    int cycles;
    asm volatile ("rdcycle %0" : "=r"(cycles));
    return cycles;
}

int main(){
	long	Begin_Time,
		End_Time;

	extern int xprintf ();	

	Begin_Time = time ( (long *) 0);
	xprintf("begin time is:%d\n",Begin_Time);

	for(int i=0;i<=5000;i++){
		for(int j=0;j<=1000;j++);
	}

	End_Time = time ( (long *) 0);
	xprintf("end time is:%d\n",End_Time);

	while(1);

}
