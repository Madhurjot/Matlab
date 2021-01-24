TestScript
%%
f = @(t) sin(t)-cos(2*t);
Df = @(t) cos(t)+2*sin(2*t);
x0 = 0.5; tol = 1e-8; maxStep = 20;
newton(f,Df,x0,tol,maxStep)

