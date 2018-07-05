function [Axial_Stress,Axial_Strain_ln,Transversal_Strain_ln] = StressStrains(Displacement,Force,Diameter,InitialHeight)





    Section_Area = pi * (Diameter).^2 / 4 ;

    Axial_Strain_ln = log( InitialHeight ./  ( InitialHeight+Displacement ) ) ;
    
    for j = 1 : size(Diameter,2)
        
    Transversal_Displacement(:,j)  = Diameter(:,j) - Diameter(1,j);   
        
    Transversal_Strain_ln(:,j) = 2 * log( Diameter(1,j) ./ Diameter(:,j) ) ;
    
    Axial_Stress(:,j) = Force  ./ Section_Area(:,j) ;     %

    end


end 