function [Height,Diameter] = px2mm(NominalDiameter,CP_Height,CS_Diameter);

% Data Conversion : px to mm

    px_size = NominalDiameter / CS_Diameter(1,1)  ; % [ mm / px ]

    Height = CP_Height * px_size;
    Diameter = CS_Diameter * px_size;   
    
end