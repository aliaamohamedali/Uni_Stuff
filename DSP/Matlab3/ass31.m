n=-4:2;
x=[1,-2,4,6,-5,8,10];
[x11,n11]=sigshift(3*x,n,-2);
[x12,n12]=sigshift(x,n,4);
[x13,n13]=sigadd(x11,n11,x12,n12);
[x1,n1]=sigadd(x13,n13,2*x,n);

[x21,n21]=sigshift(x,n,-4);
[x22,n22]=sigshift(x,n,1);
[x233,n233]=sigshift(x,n,-2);
[x23,n23]=sigfold(x233,n233);
[x211,n211]=sigmult(x21,n21,x22,n22);
[x221,n221]=sigmult(x23,n23,x,n);
[x2,n2]=sigadd(x211,n211,x221,n221);
hold on
subplot(2,1,1)
stem(n1,x1)
subplot(2,1,2)
stem(n2,x2)
hold off
