% This file greets the user and gives them the current time
Time = fix(clock); % Gets the current time from the system
H = Time(1 ,4); % Extracts the hour 
M = Time(1 ,5); % Extracts the minutes
D = ['Hello, the time is ',num2str(H),':',num2str(M)]; % Makes a string to display
disp(D); % Greets user
