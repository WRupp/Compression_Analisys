function [mad] = MAD(A)
% Calculates the scaled Mean Absolute Deviation from a vector

c=-1/(sqrt(2)*erfcinv(3/2));

mad = c * median( abs( A-median(A) ) );

end