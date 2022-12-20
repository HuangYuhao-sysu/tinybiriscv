//#include<stdio.h>

int main(){
	int fibonacci[10];
	int i = 0;
	int j = 0;
	fibonacci[0] = 1;
	fibonacci[1] = 1;
	
	for(i = 2; i <= 9; i++){
		fibonacci[i] = fibonacci[i-1] + fibonacci[i-2];
	}
	
	//for(j = 0; j <= 9; j++){
	//	printf("fibonacci %d = %d\n",j,fibonacci[j]);
	//}
}
