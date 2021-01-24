function nonlinear_phase_portrait(f1, f2, x1_range, x2_range, step)
%% Plot the Slope Field
x1 = x1_range(1):step:x1_range(2);
x2 = x2_range(1):step:x2_range(2);
[X1,X2] = meshgrid(x1,x2);
u = f1(X1,X2);
v = f2(X1,X2);
U = u ./ sqrt(u.^2 + v.^2);
V = v ./ sqrt(u.^2 + v.^2);
quiver(X1,X2,U,V,0.5,'b');
hold on;
%% Plot the Nullclines
fimplicit(f1,'r--');
fimplicit(f2,'r-');
%% Find Steady State Points
F = @(x) [f1(x(1),x(2)); f2(x(1),x(2))];
ss_response = input('Find a steady state? (y/n) ','s');
while ss_response == 'y'
    x0 = input('Enter an intial guess [x1,x2]: ');
    options = optimoptions(@fsolve,'Display','none');
    [ss,~,exitflag] = fsolve(F,x0,options);
    if exitflag > 0
        plot(ss(1),ss(2),'r.','MarkerSize',20);
        disp(['Found equilibrium point at x1=',num2str(ss(1)),' and x2=',num2str(ss(2))])
    else
        disp('Could not find an equilibrium point.')
    end
    ss_response = input('Find an equilibrium point? (y/n)','s');
end
%% Plot the Trajectories
odefun = @(t,x) [f1(x(1),x(2));f2(x(1),x(2))];
function [value,isterminal,direction] = stop(t,y)
    value = [1,1,1];
    x_mid = mean(x1_range);
    y_mid = mean(x2_range);
    position = y - [x_mid; y_mid];
    if norm(position) > norm([diff(x1_range),diff(x2_range)])/2
        value(1) = 0;
    end
    if norm(odefun(t,y)) < 1e-4
        value(2) = 0;
    end
    if t > 100
        value(3) = 0;
    end
    isterminal = [1,1,1];
    direction = [0,0,0];
end
options = odeset('Events', @stop, 'RelTol',1e-8,'AbsTol',1e-10);
traj_response = input('Plot a trajectory? (y/n)','s');
while traj_response == 'y'
    x0 = input('Enter intial conndition [x1(0),x2(0)]: ');
    [T,U] = ode45(odefun,[0,Inf],x0,options);
    plot(U(:,1),U(:,2),'b');
    [T,U] = ode45(odefun,[0,-Inf],x0,options);
    plot(U(:,1),U(:,2),'b');
    traj_response = input('Plot a trajectory? (y/n)','s');
end
%% Work on Aesthetics
xlim([x1_range(1),x1_range(2)]);
ylim([x2_range(1),x2_range(2)]);
title('Thank You So Much Mahdi!');
grid on;
end


