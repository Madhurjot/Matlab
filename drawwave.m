A = 2;
omega = 2;
t = [-pi : 0.1 : pi];
y = A*cos(omega*t);
plot(t,y)
xlabel('Time (s)')
ylabel('Voltage (V)')
grid on
