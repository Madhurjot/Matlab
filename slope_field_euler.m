% This function takes a function, the limits of x, the limits of y, the
% grid step, intial value of y, and time step as its input and graphs a
% slope field of the funtion, graphs the Euler approximation of the
% function, and returns the T and Y values for that Euler approximation.
% Madhurjot Sohi 18289447
function [T,Y] = slope_field_euler(f, tspan, yspan, grid_step, y0, time_step)
t = tspan(1):grid_step:tspan(2);
y = yspan(1):grid_step:yspan(2);
l = grid_step/2;
hold on;
ylim([yspan(1) yspan(2)]);
xlim([tspan(1) tspan(2)]);
grid on;
ylabel('y');
xlabel('t');
title(["Slope Field for y'= ", func2str(f)," with initial condition y0= ", num2str(y0,3)]);
for increment_t = 1:length(t)
    for increment_y = 1:length(y)
        slope = f(t(increment_t), y(increment_y));
        delta_x = l*cos(atan(slope));
        delta_y = l*sin(atan(slope));
        plot([t(increment_t) - delta_x,t(increment_t)+delta_x],[y(increment_y)-delta_y,y(increment_y)+delta_y],'b');
    end
end
tEuler = tspan(1):time_step:tspan(2);
Y = zeros(1,length(tEuler));
Y(1) = y0;

for n=1:length(tEuler)-1 
    if Y(n) > yspan(1) && Y(n) < yspan(2) 
        Y(n+1)= Y(n) + f(tEuler(n),Y(n))*time_step;
    end
end
if Y(length(tEuler)) == 0 
    Y(:,length(tEuler)) = [];
    tEuler(:,length(tEuler)) = [];
end    
eulerPlot = plot(tEuler, Y, '-r.');
set(eulerPlot,'MarkerSize',25);
T = tEuler;



        

