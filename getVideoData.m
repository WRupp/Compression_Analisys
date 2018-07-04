



%% Video Processing

% Cria uma pasta para as imagens
ImageTargetFolder = 'Images';
if ~exist(ImageTargetFolder, 'dir')
  mkdir(ImageTargetFolder);
end

addpath('Images')

% Processamento de video para pegar o diametro do CP
% Wagner Rupp
% Julho 2018

clear; clc; close all;


NominalDiameter = 6 ; % [mm]

VideoFileName = 'teste_20180530_CP03_2018-05-30-153727-0000.avi';
% ImageFileName = 

ImageBaseName = 'Cam1_Image';
Frame_Rate = 7.5;
N_Frames = 2681 ;


N_Markers = 5;
% N_Frames = 2681 ;
PlotStatus = 1 ;


N_Frames = video2images(VideoFileName,ImageBaseName);

pause(1e-5)
%% Image Processing

[CS_Diameter,CP_Height] = Image2borders(ImageBaseName,N_Markers,N_Frames,PlotStatus);


%% Data Processing


    % Data Conversion : px to mm
    Time = ( N_Frames / Frame_Rate ) * (1:N_Frames)'/ N_Frames;

    % Em qual posição pegar
    px_size = NominalDiameter / CS_Diameter(1,1)  ; % [ mm / px ]

    Height = CP_Height * px_size;
    Diameter = CS_Diameter * px_size;
    

    % Time shift
    tol = 1e-4;
    i = 1;
    while ( (Height(i)-Height(1))^2 < tol )
     i = i + 1  ;
    end    
     i = i - 2 ;    % Takes one with zero displacement
     
     Time(end - i+1 : end ) = [] ;
     Height(1:i) = [];
     Diameter(1:i,:) = [];
       
    VideoData.Time = Time ;
    VideoData.Height = Height;
    VideoData.Diameter = Diameter;
    
     
    save('VideoData','VideoData');
 

    
    
