function phase_portrait(A,width,height,h,N)
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
plot(0,0,'b.','MarkerSize',15)
xlim([-width,width]);
ylim([-height,height]);
%% Find and Plot Eigenvectors
[V,v] = eig(A);
if imag(v) == 0
    V1 = L * V(:,1);
    V2 = L * V(:,2);
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
function dudt = odefun(t,u)
    dudt(1) = A(1,1)*u(1)+A(1,2)*u(2);
    dudt(2) = A(2,1)*u(1)+A(2,2)*u(2);
    dudt = dudt(:);
end
%% Plot the Trajectories
if (imag(v(1,1)) ~= 0) && (abs(real(v(1,1))) < 1e-15)
    tf = (2*pi)/imag(v(1,1));
    for n=1:N
        [T,U] = ode45(@odefun, [0,tf], [width,height]*n/(N+1));
        plot(U(:,1),U(:,2),'b-')
    end
elseif (real(v(1,1)) > 0) && (real(v(2,2)) > 0)
    tf = Inf;
    for theta = 0:(2*pi/N):2*pi
        y0 = 0.5*L*[cos(theta),sin(theta)];
        [T,U] = ode45(@odefun,[0,tf],y0,options);
        plot(U(:,1),U(:,2),'b-')
        [T,U] = ode45(@odefun,[0,-tf],y0,options);
        plot(U(:,1),U(:,2),'b-')
    end
elseif (real(v(1,1)) < 0) && (real(v(2,2)) < 0)
    tf = Inf;
    for theta = 0:(2*pi/N):2*pi
        y0 = L*[cos(theta),sin(theta)];
        [T,U] = ode45(@odefun,[0,tf],y0,options);
        plot(U(:,1),U(:,2),'b-')
    end
else 
    tf = Inf;
    N = floor(N/4);
    for n=[1:N,-N:-1]
        [T,U] = ode45(@odefun,[0,tf],xnullcline*n/(N+2),options);
        plot(U(:,1),U(:,2),'b-')
        [T,U] = ode45(@odefun,[0,-tf],xnullcline*n/(N+2),options);
        plot(U(:,1),U(:,2),'b-')
        [T,U] = ode45(@odefun,[0,tf],ynullcline*n/(N+2),options);
        plot(U(:,1),U(:,2),'b-')
        [T,U] = ode45(@odefun,[0,-tf],ynullcline*n/(N+2),options);
        plot(U(:,1),U(:,2),'b-')
    end
end
end
