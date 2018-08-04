%%%%%%%%%%%%%%%%%%%%% Exercise One %%%%%%%%%%%%%%%%%%%%%

%%%% For Function : (Z+1) / (Z^2-0.9Z+0.81)

%%%% a.	Generate transfer function.
%%%% b.	Find the frequency response of system.
%%%% c.	Find step response of system.
%%%% d.	Check stability of system use two different Methods.
%%%% e.	Find impulse response use two different Methods

num = [0 1 1];
den = [1 -0.9 0.81];


%%% 1.a
a = tf(num, den, -1, 'Variable', 'z^-1');

%%% 1.b
freqz(num,den);

%%% 1.c
c = step(a);
plot(c);

%%% 1.d
zplane(num, den);
[poles, zeros] = pzmp(a);
disp(poles);
disp(zeros);

%%% 1.e
impulse(a);
[r, p, k] = residuez(num, den);
disp(r);
disp(p);
disp(k);

%%%%%%%%%%%%%%%%%%%%% Exercise Two %%%%%%%%%%%%%%%%%%%%%

%%%% A causal LTI system is described by the following difference
%%%% equation:     y(n) = 0.81y(n - 2) + x(n) - x(n - 2)

%%%% a.	Determine  the system function H(z).
%%%% b.	The unit impulse response h(n) .
%%%% c.	The unit step response s(n).
%%%% d.	Plot zeros and poles of this system.
%%%% e.	The frequency response function H(ejw), and plot its magnitude and phase response.

num = [1 0 -1];
den = [1 0 -0.81]

%%% 2.a
a = tf(num, den, -1, 'Variable', 'z^-1');
display(a);

%%% 2.b
impulse(a);

%%% 2.c
step(a);

%%% 2.d
zplane(num, den);

%%% 2.e
freqz(num, den);