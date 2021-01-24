function y = drawwavefun(A, omega)
% This file draws a simple cosine wave.
% The syntax is drawwavefun(A, omega), where
% A is the amplitude (V) and
% omega is the frequency (rad/s)
t = [-pi: 0.1 : pi]; % time (s)
y = A*cos(omega*t); % voltage time history (V)
plot(t, y) % plot function
xlabel('Time (s)') % add x-label
ylabel('Voltage (V)') % add y-label
grid on % turn grid on
