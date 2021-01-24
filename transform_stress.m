function [sig_x_prime,sig_y_prime,tao_xy_prime,sig_max,sig_min,tao_max] = transform_stress(sig_x,sig_y,tao_xy,theta)
centre = (sig_x+sig_y)/2;
radius = sqrt(((sig_x-sig_y)/2)^2+(tao_xy)^2);
sig_x_prime = centre + ((sig_x-sig_y)/2*cosd(2*theta))+tao_xy*sind(2*theta);
sig_y_prime = centre - ((sig_x-sig_y)/2*cosd(2*theta))-tao_xy*sind(2*theta);
tao_xy_prime = -1*((sig_x-sig_y)/2*sind(2*theta))+tao_xy*cosd(2*theta);
sig_max = centre + sqrt(((sig_x-sig_y)/2)^2+(tao_xy)^2);
sig_min = centre - sqrt(((sig_x-sig_y)/2)^2+(tao_xy)^2);
tao_max = sqrt(((sig_x-sig_y)/2)^2+(tao_xy)^2);
tao_min = -1*tao_max;

hold on;
grid off;
deg = 0:pi/50:2*pi;
x = radius * cos(deg) + centre;
y = radius * sin(deg);
plot(x,y);
plot([sig_x,sig_y],[-tao_xy,tao_xy],'r.','MarkerSize',15);
plot([sig_x,sig_y],[-tao_xy,tao_xy],'r');
plot([sig_x_prime,sig_y_prime],[-tao_xy_prime,tao_xy_prime],'b.','MarkerSize',15);
plot([sig_x_prime,sig_y_prime],[-tao_xy_prime,tao_xy_prime],'b');
plot([sig_max,sig_min],[0,0],'k.','MarkerSize',15);
plot([centre,centre],[tao_max,tao_min],'k.','MarkerSize',15);
text(sig_x,-tao_xy,strcat("(Sigma X, Tau XY)","(",num2str(sig_x),",",num2str(-tao_xy),")"));
text(sig_y,tao_xy,strcat("(Sigma Y, Tau YX)","(",num2str(sig_y),",",num2str(tao_xy),")"));
text(sig_x_prime,-tao_xy_prime,strcat("(Sigma X', Tau X'Y')","(",num2str(sig_x_prime),",",num2str(-tao_xy_prime),")"));
text(sig_y_prime,tao_xy_prime,strcat("(Sigma Y', Tau Y'X')","(",num2str(sig_y_prime),",",num2str(tao_xy_prime),")"));
text(sig_max,0,strcat("(Sigma MAX)","(",num2str(sig_max),")"));
text(sig_min,0,strcat("(Sigma MIN)","(",num2str(sig_min),")"));
text(centre,tao_max,strcat("(Tau MAX)","(",num2str(tao_max),")"));
text(centre,tao_min,strcat("(Tau MIN)","(",num2str(tao_min),")"));
title(strcat("Mohr's Circle, Sigma X = ",num2str(sig_x),",Sigma Y = ",num2str(sig_y),",Tau XY = ",num2str(tao_xy),",and Theta = ",num2str(theta)));
axis equal;
hold off;

end