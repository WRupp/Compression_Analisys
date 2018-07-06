function [A] = BlockOutliers(A,N_Blocks)
% Finds outliers for each block of A. A must be a row vector

S = size(A);

Block = ceil(S(1) / N_Blocks) ;

for i = 1 : N_Blocks-1
   
    interval = (i-1) * Block + 1 : i * Block ;
    
    A(interval) = fixOutliers(A(interval));
    
end



end