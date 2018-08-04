n=0:25;
x1=(n.^2) .*(stepseq(0,0,25)-stepseq(6,0,25))+(20*(.5).^n).*(stepseq(4,0,25)-stepseq(10,0,25));
stem(n,x1)