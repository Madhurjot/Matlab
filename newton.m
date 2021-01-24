% This function takes a function, its derivative, an inital guess, the
% tolerance, and maximum number for approximations as its input and uses
% newtons approximation to approximate a root. The function returns
% displays the root, the number of approximations it took to get to that
% root, and the elapsed time in the command window.
% Madhurjot Sohi 18289447
function [root, num_step, total_time] = newton(f, Df, x0, tolerance, max_step)

xn = x0; % The first guess is x0 (provided by the user)

for n = 1 : max_step % Ensure the number of approximations do not exceed the maximum
    tic; % Start timer
    if Df(xn) == 0 || abs(f(xn)) <= tolerance % Exits the loop if the derivative of the function is 0 or the tolerance limit has been met
        break
    end
    xN = xn - (f(xn)/Df(xn)); % Newton's method
    xn = xN; 
end
if Df(xn) == 0 % Message displayed if the derivative was 0
    root = NaN;
    num_step = NaN;
    total_time = NaN;
    disp("Program terminated because f'(x)=0. No root found");
elseif n == max_step % Message displayed if max number of approximations was exceeded
    root = NaN;
    num_step = NaN;
    total_time = NaN;
    disp(['Program terminated after ', num2str(max_step), ' iterations. No root found.']);
else % Message in the normal case
    root = xN;
    num_step = n;
    total_time = toc;
    disp(['Found root ', num2str(root,16), ' after ', num2str(num_step), ' iterations in ', num2str(total_time), ' seconds ']);
end

    