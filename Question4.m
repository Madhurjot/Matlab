% This file asks users for 3 values and solves a system of equations based on those values
A = [5 -3 2;-3 8 4;2 4 -9]; % Matric of coefficients
B1 = input('Input B1\n'); % Input value 1
B2 = input('Input B2\n'); % Input value 2
B3 = input('Input B3\n'); % Input value 3
B = [B1;B2;B3]; % Create a column vector with the input values
Answer = inv(A)*B; % Solve
disp(num2str(Answer)); % Displays the solution

