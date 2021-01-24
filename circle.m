function M = circle(num_frames)
t = linspace(0,2*pi,num_frames);
x = cos(t); y = sin(t);
for i = 1:length(t)
plot(x,y,'b--');
xlim([-2,2]); ylim([-2,2]);
hold on; axis off equal;
plot(cos(t(i)),sin(t(i)), 'ro', 'MarkerFaceColor', 'r');
hold off;
M(i) = getframe(gcf);
end
end
