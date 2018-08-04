%%%%%%%% Exercise 1 %%%%%%%%
%% write down Matlab instructins t generate a signal in form
%% 1/ DC segment from -2 till 0 seconds
%% 2/ Quarter Cycle of a sinusoidal wave from 0 till 1
%% 3/ DC segment from 1 till 3
%% Frequency = 100 Hz 
 
sig1 = 4*ones(1, 200);
t = linspace(0,1,100);
sig2 = sin(2*pi*t/4);
sig3 = 3*ones(1,200);
n = linspace(-2,3,500);
signal = [sig1 sig2 sig3];
plot(signal);


%%%%%%%% Exercise 2 %%%%%%%%
%% Two Discrete Time signals are T= 2s
%% x[nT] = cos(2n/3)
%% y[nT] = cos(8pi*n/38)

%% i) plot x[n] , y[n] for T<40 seconds, cntinuous time sinusoid

n = [-40:2:40];
x_discrete = cos(2*n/3);
y_discrete = cos(8*pi*n/38);
t = [-40:2:40];
x_cont = cos(2*t/3);
y_cont = cos(8*pi*t/38);

plot(t, x_cont);
hold_on;
plot(t, y_cont);

%% ii) Are sequences periodic or not ? Use Stem,

stem(x_discrete);
hold on;
stem(y_discrete);

%% Answer: x[n] is not periodic while y[n] is periodic with a period of: 2*pi/(8*pi/38) = 38/4
