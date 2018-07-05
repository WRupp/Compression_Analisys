%% Main program

clear; close all ;clc;


specimen_string = 'CP_03';

OutFile = 'EXP_Data.probe';

NominalDiameter = 6 ; % [mm]
InitialHeight = 6 ;

Frame_Rate = 7.5;

N_Markers = 5;

PlotStatus = 0 ;



TempoInicial = 0 ;
TempoFinal = 300 ;
dT = 1;


%% ------------ Body ------------------------------

% Working folders

InputFileFolder    = ['Input_Data\' specimen_string '\' ] ;
OutputFileFolder   = [ 'Processed_Data\' specimen_string '\'];
ImageTargetFolder  = [OutputFileFolder 'Images\'];

addpath('codes')

% Create a folder for the images

if ~exist(ImageTargetFolder, 'dir')
  mkdir(ImageTargetFolder);
end


VideoFileName = [InputFileFolder specimen_string '_VIDEO'  '.avi' ] ;
MTSFileName = [InputFileFolder specimen_string '_MTS' '.dat' ] ;
LVDTFileName = [InputFileFolder specimen_string '_LVDT' '.asc'] ;

ImageBaseName = [ImageTargetFolder specimen_string '_'];


% Get measured data

MTS_raw = dlmread( MTSFileName,'\t', 5 , 0 ) ;

    % Changes order to [time Force Displacement] 
        MTS_Data = zeros(size(MTS_raw));
        MTS_Data(:,1) = MTS_raw(:,3);
        MTS_Data(:,2) = MTS_raw(:,2);
        MTS_Data(:,3) = MTS_raw(:,1)-MTS_raw(1,1);
        clear MTS_raw

    % Changes from ',' to '.' in the lvdt file so matlab can read
    comma2point_overwrite( LVDTFileName )
    
LVDT_Data = dlmread(LVDTFileName);
LVDT_Data(:,3:end) = [];    % Time and first channel only
LVDT_Data(:,2) = - LVDT_Data(:,2);



%% Video & Image Processing

% Video
N_Frames = video2images(VideoFileName,ImageBaseName);

% Image
[CS_Diameter,CP_Height] = Image2borders(ImageBaseName,N_Markers,N_Frames,PlotStatus);

Pixel_Data.Height = CP_Height ; 
Pixel_Data.Diameter = CS_Diameter; 

save([OutputFileFolder 'Pixel_Data'],'Pixel_Data'); 

% Convert units

     % Time
     Video_Time = ( N_Frames / Frame_Rate ) * (1:N_Frames)'/ N_Frames;

     % Space
    [Height,Diameter] = px2mm(NominalDiameter,CP_Height,CS_Diameter);
    
% Struct
    Video_Data.Time = Video_Time ;
    Video_Data.Height = Height ;
    Video_Data.Displacement = Height - Height(1);
    Video_Data.Diameter = Diameter;   

%% Sync Data Sources
% by the maximum displacement
  
[Video_Data,MTS_Data,LVDT_Data] = sync(Video_Data,MTS_Data,LVDT_Data);
    
%% Data Processing

Time_Out = (TempoInicial : dT : TempoFinal)' ;
Time_Int = Time_Out;


[Disp_Int,Force_Int,Diam_Int] = Interpolate_Data(Time_Int ,Video_Data, LVDT_Data, MTS_Data);

[Axial_Stress,Axial_Strain_ln,Transversal_Strain_ln] = StressStrains(Disp_Int,Force_Int,Diam_Int,InitialHeight);

[Output_Data] = CreateCombinedOutput(Time_Out ,Video_Data, LVDT_Data, MTS_Data);

%% Output           
    
plotstuff ;
    
savestuff ; 
    