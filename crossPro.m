function C = crossPro(A,B)
%This file returns the cross product of 2 three dimensional row-vectors
C1 = A(1,2)*B(1,3)-B(1,2).*A(1,3);
C2 = (A(1,1)*B(1,3)-B(1,1).*A(1,3))*-1;
C3 = A(1,1)*B(1,2)-B(1,1).*A(1,2);
C = [C1 C2 C3];
