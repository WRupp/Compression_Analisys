% Processamento de video para pegar o diametro do CP
% Wagner Rupp
% Julho 2018



%% Video Processing
% 
% % Cria uma pasta para as imagens
% ImageTargetFolder = 'Images';
% if ~exist(ImageTargetFolder, 'dir')
%   mkdir(ImageTargetFolder);
% end
% 
% addpath('Images')
% 
% 
% NominalDiameter = 6 ; % [mm]
% 
% VideoFileName = 'teste_20180530_CP03_2018-05-30-153727-0000.avi';
% % ImageFileName = 
% 
% ImageBaseName = 'Cam1_Image';
% Frame_Rate = 7.5;
% N_Frames = 2681 ;
% 
% 
% N_Markers = 5;
% % N_Frames = 2681 ;
% PlotStatus = 1 ;
% 

N_Frames = video2images(VideoFileName,ImageBaseName);

% addpath('Images')
% pause(1e-3)

%% Image Processing

[CS_Diameter,CP_Height] = Image2borders(ImageBaseName,N_Markers,N_Frames,PlotStatus);



    
