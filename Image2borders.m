% Find marker distances from .tif images
% Tries to find the test specimen under compression 
% Places markers along the specimen radii
% The instantaneous height is divided equaly and the markers are placed
%   Variables:
%   ImageFileName = The base name of the image excluding its number
%   N_Markers     = Number of Markers
%   N_Images      = Total Number of Images
%   PlotStatus    = Flag to plot images or not (set to 1 to plot)
%   CS_Area       = Cross Sectinal Area - Dim: [N_Images,N_Markers]
%   CP_Height     = Test Specimen Height (after Reflection Removal)
% Author: Wagner Rupp
% June 2018

function [CS_Diameter,CP_Height] = Image2borders(ImageFileName,N_Markers,N_Images,PlotStatus)
%% Image Parameters

% ImageFileName = 'Cam1_Image';
Extension = '.tif';

Initial_Image = 1;
Image_Step = 1;
Final_Image= N_Images;

Border_Sensitivity  = 0.3;

% Tenta remover os pixels do reflexo

Reflection_Px = 20;
Length_Addition = 120;


%% ----------- Code Main -----------------------

% Initialization
count = 0;
Total_Steps = size( Initial_Image : Image_Step : Final_Image,2) ;

Marker_Position = zeros(1,N_Markers);
BorderLeft = zeros(1,N_Markers);
BorderRight = zeros(1,N_Markers);

CP_Height = zeros(Total_Steps,1);
Distance = zeros( Total_Steps ,N_Markers);
CS_Area =  zeros( Total_Steps ,N_Markers);
% Stress =  zeros( Total_Steps ,N_Markers);

h = waitbar(0,'Processing Markers from Images ');   
% Main loop

for Image_Number = Initial_Image : Image_Step : Final_Image
    
waitbar(Image_Number / Final_Image)  
    
%% Open Image
FileName = [ImageFileName num2str(Image_Number) Extension ];
MyImage= imread(FileName);
S = size(MyImage);

count = count + 1 ;

%% CP Length
if  Image_Number == Initial_Image

    ColumnMean = zeros(1,S(2));
    for i = 1 : S(2)
    ColumnMean(i) = mean(MyImage(:,i));
    end

    Darker_Columns = find(ColumnMean < 80 ) ; 

    CP_LeftBorder = Darker_Columns(1);
    CP_RightBorder = Darker_Columns(end); 

    CP_Length_Block = CP_LeftBorder : CP_RightBorder;

%     CP_Length = CP_RightBorder - CP_LeftBorder ;

    % Expand the lenght block to acomodate barreling

    Total_Length_Block = (CP_Length_Block(1) - Length_Addition ) : (CP_Length_Block(end) + Length_Addition );

end 
%% CP Height

RowMean = mean(MyImage(:,Total_Length_Block),2);

Brighter_Lines = find(RowMean>50);

% Reflection exclusion

CP_Base = Brighter_Lines(1)  + Reflection_Px;
CP_Top = Brighter_Lines(end) - Reflection_Px;

CP_Height_Block = CP_Base : CP_Top;

CP_Height(count) = CP_Top - CP_Base ;


%% Image Processing


    
    % get the useful part in the image
    MyImage_Center = MyImage(CP_Height_Block,Total_Length_Block,:);
	% Turns it into Grayscale
    MyImage_Gray = rgb2gray(MyImage_Center);  % Todo: use edge without this  
    % Turns into logical - Identifies the borders
    MyImage_BW = edge(MyImage_Gray,'canny',Border_Sensitivity);

%% Markers position

    
    Marker_Spacing = floor( CP_Height( count ) / (N_Markers+1) ) ;
    
    for i = 1 : N_Markers
     Marker_Position(i) = i * Marker_Spacing;
    end

    
%     % Marker Global Position
%     Marker_Position_Global(:) = Marker_Position(:) + CP_Base;

    % % Acha as bordas nas linhas dos marcadores
    for i = 1 : N_Markers
    Borders = find( MyImage_BW ( Marker_Position(i),:) == 1);
    BorderLeft(i) = Borders(1);
    BorderRight(i) = Borders(end);
    end

%% Distances
   
    for j = 1 : N_Markers
    Distance(count,j) = ( BorderRight((j)) - BorderLeft((j)) );
    end
    
%% Plot
    if PlotStatus == 1 

        subplot(1,2,1);
        
        imshow(MyImage);
        hold on
%         plot(Total_Length_Block(1) ,CP_Height_Block, 'r*' )
%         plot(Total_Length_Block(1),CP_Height_Block,'ro' ,'MarkerSize',0.75 )
%         plot(Total_Length_Block(end),CP_Height_Block,'ro' ,'MarkerSize',0.75 )
%         plot(Total_Length_Block,CP_Height_Block(1),'bo','MarkerSize',0.75)
%         plot(Total_Length_Block,CP_Height_Block(end),'bo','MarkerSize',0.75)

        line( [Total_Length_Block(1) Total_Length_Block(end) ] , [ CP_Height_Block(1) CP_Height_Block(1)] );
        line( [Total_Length_Block(1) Total_Length_Block(end) ] , [ CP_Height_Block(end) CP_Height_Block(end)] );

        hold off;
        
        subplot(1,2,2);
        imshow(MyImage_BW);
        
        hold on
        plot( BorderLeft , Marker_Position, ' r * ' )
        plot( BorderRight , Marker_Position, ' r * ' )
        
        hold off
        
        
        
       pause(1e-5)
    end
    


    
end     
   

%% Radial Data Process - VRE method
%  Based on Poulain - 2013


% % Calcula as areas transversais - Assumindo circulares
% for i = 1 : count
%     for j = 1 : N_Markers
%         CS_Area(i,j) = pi * Distance(i,j) .^ 2 / 4;
%     end 
% end

    CS_Diameter = Distance ;





close(h)

end


% cd('../')

% 
% figure;
% plot(CP_Height);

% % Calcula as tensoes
% for i = 1 : count
%     for j = 1 : N_Markers
% %         Stress(i,j) = F(i) ./ CS_Area(i,j)  ;  
%     end 
% end




%  InitialDistances = Distance(1,:) ;  

% % Calcula as deformações - VSE
% for i = 1 : count
%     for j = 1 : N_Markers
%         % CS - CrossSectional
%         CS_Strain(i,j) = 2 * log( InitialDistances(j) / Distance(i,j) );
%     end
% end


% clear; clc; close all;

% figure;
% axis equal
% colormap(gray);


% N_Markers = 5;


% path = pwd;

