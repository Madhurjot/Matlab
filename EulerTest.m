f = @(t,y) t-t*y;
t0 = 1; y0 = 0; h = 0.1;
tf = 1.4;

t = t0:h:tf;
y = zeros(1,length(t));
y(1) = y0;

for n=1:length(t)-1
    y(n+1)= y(n) + f(t(n),y(n))*(t(n+1)-t(n));
end
