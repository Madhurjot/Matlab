% The function takes in the mass of two planets, their position, inital
% conditions, and the time span and plot the path of a planet.
% Madhurjot Sohi 18289447
function [X,Y] = three_body_euler_movie(m1,S1,m2,S2,P,tspan)
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

%% Plot the Path of the Planet
for i = 1:length(T)
    hold on;
    axis equal;
    grid on;
    ylim([-1.5*abs((S1(1)-S2(1))),1.5*abs((S1(1)-S2(1)))]); xlim([-1.5*abs((S1(1)-S2(1))),1.5*abs((S1(1)-S2(1)))]);
    plot(U(i,1),U(i,3),'bo','MarkerSize',2,'MarkerFaceColor','b');
    plot(S1(1),S1(2),'*','MarkerSize',10*m1,'MarkerFaceColor','r');
    plot(S2(1),S2(2),'*','MarkerSize',10*m2,'MarkerFaceColor','r');
    M(i) = getframe(gcf);
end
end