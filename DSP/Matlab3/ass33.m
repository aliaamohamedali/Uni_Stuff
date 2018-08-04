n=linspace(-2,3,5*100);
y1=zeros(1,100);
n2=linspace(-1,0,100);
y2=1-cos(0.5*pi*n2);
n3=linspace(0,1,100);
y3=n3-1;
y=[y1 y2 y3 y1-1 y1];
stem(n,y);