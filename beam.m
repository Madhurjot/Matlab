% This function calculates the deflection of a beam based on the
% Euler-Bernoulli equation. The function also plots a deflection verses
% length graph based on 4 values on force applied. Finally, the function
% returns the values of the deflection corresponding to the length.

function d = beam(E, I, q, x)
y = -(q.*(x.^2))/(48*E*I).*(3*(x(end)^2)-5*x(end).*x+2.*(x.^2));
hold on;
plot(x,y);
plot(x,2*y);
plot(x,3*y);
plot(x,4*y);
ylim([-8*max(abs(y)) 8*max(abs(y))]);
title(['Beam Deflection for E = ',num2str(E,3),' Pa and I = ',num2str(I,3),' m^4 '])
xlabel('Beam Length, m')
ylabel('Beam Deflection, m')
legend([ num2str(q) ' N/m '],[ num2str(2*q) ' N/m '],[ num2str(3*q) ' N/m '],[ num2str(4*q) ' N/m '])
grid on;
d = [x',y'];