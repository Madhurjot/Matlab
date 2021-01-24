function I = interestAdded(x,r,k,n)
%This file returns the accumulated interested on a value
X = x*(1+r/(100*k))^(k*n);
I = X-x;
