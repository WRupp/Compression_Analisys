function [OutlierIndex] = findOutliers(A)
% Find the outliers from a row vector A

% Definition:
% An element is an outlier if it is 3 times the median absolute deviation
% (MAD) away from the median.

distance = 3 * MAD(A);
medianA = median(A);


OutlierIndex = [];

for i = 1 : size(A,1)
    if ( abs( A(i) - medianA) > distance )
        OutlierIndex = [OutlierIndex ;  i];
    end
end


end