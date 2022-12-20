int main()
{
    int i,j,i1,j1,b[3][3];
    i1 = 3;
    j1 = 3;
    int a[3][3] = {{1,2,3},{4,5,6},{7,8,9}};
    for(i=0;i<i1;i++)
        for(j=0;j<j1;j++)
            b[j][i]=a[i][j];
    return 0;
}