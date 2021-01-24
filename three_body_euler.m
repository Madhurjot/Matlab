% The function takes in the mass of two planets, their position, inital
% conditions, and the time span and plot the path of a planet.
% Madhurjot Sohi 18289447
function [X,Y] = three_body_euler(m1,S1,m2,S2,P,tspan)
%% Define Regularly Used Constants
G = 4*(pi^2);

%% Create Odefun
function dudt = odefun(~,u)
    dudt = zeros(4,1);
    dudt(1) = u(2);
    dudt(2) = (G*m1*(S1(1)-u(1))/((S1(1)-u(1))^2+(S1(2)-u(3))^2)^(3/2))+(G*m2*(S2(1)-u(1))/((S2(1)-u(1))^2+(S2(2)-u(3))^2)^(3/2));
    dudt(3) = u(4);
    dudt(4) = (G*m1*(S1(2)-u(3))/((S1(1)-u(1))^2+(S1(2)-u(3))^2)^(3/2))+(G*m2*(S2(2)-u(3))/((S2(1)-u(1))^2+(S2(2)-u(3))^2)^(3/2)); 
end

%% Solve the Equation
options = odeset('RelTol',1e-9,'AbsTol',1e-10);
[T,U] = ode45(@odefun,tspan,P,options);

%% Define the X and Y values
X = U(:,1);
Y = U(:,3);
%% Plot the Path of the Planet
hold on;
axis equal;
grid on;
plot(X,Y);
plot(S1(1),S1(2),'*','MarkerSize',10*m1,'MarkerFaceColor','r');
plot(S2(1),S2(2),'*','MarkerSize',10*m2,'MarkerFaceColor','r');
end

