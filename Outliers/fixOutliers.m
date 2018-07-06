function [A] = fixOutliers(A)
% Corrects diameters based on the mean. If an outlier then the value is
% updated by linear interpolation of its neighbours.
% A must be a row vector

    Location = findOutliers(A);
    
    
    for j = 1 : size(Location)
        
        A(Location(j)) = mean([ A(Location(j)-1) A(Location(j)+1) ]);
        
    end

end