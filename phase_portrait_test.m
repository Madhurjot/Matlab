function phase_portrait_test(A,width,height,h,N)
%% Plot the Slope Field
[X,Y] = meshgrid(-width:h:width,-height:h:height);
U = A(1,1).*X + A(1,2).*Y;
V = A(2,1).*X + A(2,2).*Y;
u = U ./ sqrt(U.^2 + V.^2);
v = V ./ sqrt(U.^2 + V.^2);
quiver(X,Y,u,v,0.5);
hold on;
%% Plot the Nullclines
L = sqrt(width^2 + height^2);
xnullcline = L * [-A(1,2), A(1,1)] / norm([-A(1,2), A(1,1)]);
ynullcline = L * [-A(2,2), A(2,1)] / norm([-A(2,2), A(2,1)]);
plot([-xnullcline(1),xnullcline(1)],[-xnullcline(2),xnullcline(2)],'r--');
plot([-ynullcline(1),ynullcline(1)],[-ynullcline(2),ynullcline(2)],'r--');
xlim([-width,width]);
ylim([-height,height]);
%% Find and Plot Eigenvectors
[V,v] = eig(A);
if imag(v) == 0
    V1 = L * [-V(1,2), V(1,1)] / norm([-V(1,2), V(1,1)]);
    V2 = L * [-V(2,2), V(2,1)] / norm([-V(2,2), V(2,1)]);
    plot([-V1(1),V1(1)],[-V1(2),V1(2)],'b-');
    plot([-V2(1),V2(1)],[-V2(2),V2(2)],'b-');
end
%% Set Parameters for Ode45
function [value,isterminal,direction] = stop(t,y)
    value = [1,1];
    if norm(y) > norm([width,height])
        value(1) = 0;
    end
    if norm(y) < 1e-5
        value(2) = 0;
    end
    isterminal = [1,1];
    direction = [0,0];
end
options = odeset('Events', @stop);
%% Define Odefun
function dudt = odefun(~,u)
    dudt(1) = A(1,1)*u(1)+A(1,2)*u(2);
    dudt(2) = A(2,1)*u(1)+A(2,2)*u(2);
    dudt = dudt(:);
end
%% Plot the Trajectories
if real(v(1,1))<0 && real(v(2,2))<0
    deg = linspace(0,2*pi,N);
    y01 = L * cos(deg);
    y02 = L * sin(deg);
    y0 = [y01 y02];
    for i = 1:length(y0)
        [~,U] = ode45(@odefun, [0,Inf], [y0(i,1),y0(i,2)], options);
        plot(U(:,1),U(:,2))
    end
end
if real(v(1,1))>0 && real(v(2,2))>0
    deg = linspace(0,2*pi,N);
    y01 = L * cos(deg);
    y02 = L * sin(deg);
    y0 = [y01 y02];
    for i = 1:length(y0)
        [~,U] = ode45(@odefun, [0,Inf], [y0(i,1),y0(i,2)], options);
        plot(U(:,1),U(:,2))
    end
end
if (real(v(1,1))>0 && real(v(2,2))<0) || (real(v(1,1))<0 && real(v(2,2))>0)
    y01 = [linspace(-xnullcline(1),xnullcline(1),N)',linspace(-xnullcline(2),xnullcline(2),N)'];
    y02 = [linspace(-ynullcline(1),ynullcline(1),N)',linspace(-ynullcline(2),ynullcline(2),N)'];
    for i = 1:length(y01)
       [~,U] = ode45(@odefun, [0,Inf], [y01(i,1),y01(i,2)], options);
        plot(U(:,1),U(:,2),'b-')
        [~,U] = ode45(@odefun, [0,-Inf], [y01(i,1),y01(i,2)], options);
        plot(U(:,1),U(:,2),'b-')
        [~,U] = ode45(@odefun, [0,Inf], [y02(i,1),y02(i,2)], options);
        plot(U(:,1),U(:,2),'b-')
        [~,U] = ode45(@odefun, [0,-Inf], [y02(i,1),y02(i,2)], options);
        plot(U(:,1),U(:,2),'b-')
    end
end
if real(v(1,1)) == 0 && real(v(2,2)) == 0
    y0 = [linspace(0,width,N)',linspace(0,height,N)'];
    for i = 1:size(y0)
        [~,U] = ode45(@odefun, [0,2*pi/imag(v(1,1))], [y0(i,1),y0(i,2)], options);
        plot(U(:,1),U(:,2),'b-')
    end
end
end