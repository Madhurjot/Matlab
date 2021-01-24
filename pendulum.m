% This function takes in the length of a bar, time span, intial angle,
% intial angular velocity, and number of frames to plot per second and
% returns an array M of movie frames captured by getframe which can be
% played back using the fuction movie and shows an animation of the real
% position vs the approximated position of the pendulum. 
% Madhurjot Sohi 18289447

function M = pendulum(L, tspan, y0, fps)

t = tspan(1):((tspan(2)-tspan(1))/(fps*(tspan(2)-tspan(1)))):tspan(2); % Populate the time vector 
[T,act_soln] = ode45(@odefun,t,y0); % Populate actual solution solved by ode45
nat_freq = sqrt(9.81/L); % Define natural frequency for later use
aprx_soln = zeros(1,length(t)); % Creating a vector for the aproximated solution using the small angle assumption

for i = 1:length(t) % Populate the approximate solution vector with the equation in the lab manual
   aprx_soln(i) = y0(2)/nat_freq*sin(nat_freq*t(i))+y0(1)*cos(nat_freq*t(i));
end

function theta_dot = odefun(t,x) % Create a first order equation for ode45 to solve
    theta_dot_1 = x(2);
    theta_dot_2 = (-9.81/L)*sin(x(1));
    theta_dot = [theta_dot_1;theta_dot_2];
end


for i = 1:length(t) % Graph each frame and capture it   
    hold on;
    ylim([-L*2,L*2]); xlim([-L*2,L*2]);
    grid on;
    title(['Pendulum (Blue) vs Approximation (Red), t = ',num2str(t(i)),'s']);
    plot(0,0,'bo','MarkerSize',6,'MarkerFaceColor','b');
    plot(L*sin(act_soln(i)),-L*cos(act_soln(i)),'bo','MarkerSize',10,'MarkerFaceColor','b');
    plot([0,L*sin(act_soln(i))],[0,-L*cos(act_soln(i))],'b');
    plot(L*sin(aprx_soln(i)),-L*cos(aprx_soln(i)),'bo','MarkerSize',10,'MarkerFaceColor','r');
    plot([0,L*sin(aprx_soln(i))],[0,-L*cos(aprx_soln(i))],'r');
    hold off;
    M(i) = getframe(gcf);
    cla(gca);

end
end
    