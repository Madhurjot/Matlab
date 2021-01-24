function T = CelToFah(TL,TH)
%This file returns a table containing celcius values and their
%corresponding fahrenheit values
C = [TL: 1 :TH];
F = (9/5)*C+32;
T = [C',F'];
