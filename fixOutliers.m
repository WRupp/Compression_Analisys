function [] = fixOutliers(Diameter)
% Corrects diameters based on the mean. If an outlier then the value is
% updated by interpolation of its neighbours.

for i = 1 : size(Diameter,2)

    mean = mean(Diameter(:,i));

    Location = find (Diameter(:,i) < mean/10 );

    for j = 1 : size(Location,1)
        
        Diameter(Location(j),i) = mean([Diameter(Location(j-1),i) Diameter(Location(j+1),i)]);
        
    end


end 