
% Process the videodata struct 
% Wagner Rupp
% July 2018


    Outfile = 'EXP_Data.probe';
    
%% Post Processing   

    % Interpolate Video Data to syncronize time with ExpData
    load('VideoData');
    load('data4_post.mat');   % Combined data from lvdt and mts
    
    
    
    MeasuredData = data4;
    [InterpolatedData] = interpolateData(VideoData,MeasuredData);
    

    Axial_Displacement = InterpolatedData.Height(1) - InterpolatedData.Height;    
    
    Section_Area = pi * (InterpolatedData.Diameter).^2 / 4 ;
    
    % Stress , strain and transversal displacement
    for j = 1 : N_Markers
        
    Transversal_Displacement(:,j)  = InterpolatedData.Diameter(:,j) - InterpolatedData.Diameter(1,j);   
        
    Strain_ln(:,j) = 2 * log( InterpolatedData.Diameter(1,j) ./ InterpolatedData.Diameter(:,j) ) ;
    
    Stress(:,j) = MeasuredData(:,3)  ./ Section_Area(:,j) ; 
    end
    
 %% Output   
   
    plotstuff ;    
    
    OutPutData = [ InterpolatedData.Time MeasuredData(:,3) Transversal_Displacement];
        
    dlmwrite(OutFile,OutPutData,'delimiter','\t','precision','%.8f','roffset',1);