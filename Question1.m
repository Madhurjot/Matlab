% This file draws a circle
R = 2; % Radius
Theta = (0 : 0.1 : 2*pi); % Angles
X = R*cos(Theta); % X-Coordinates
Y = R*sin(Theta); % Y-Coordinates
plot(X,Y) % Plot the Graph
hold on 
plot(0,0,'+') %Plot the Center
grid on % Grid on
title('Circle') % Add title