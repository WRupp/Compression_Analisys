%%% A function that finds the closest matching time between the video data and the expdata (mts or lvdt)
%%% if no exact time is found the data is interpolated to match the
%%% expdata.
%%% ExpData is a 3 column matrix containing time in the first column,
%%% axial displacement in the second and axial force in the third.


function [InterpolatedData] = interpolateData(VideoData,ExpData)
%     load('data4_post.mat')
%     load('VideoData')
    i = 2;
    for j = 1 : size(ExpData,1)
        
        while (VideoData.Time(i) <= ExpData(j,1))
            i = i + 1 ;
        end

        T2 = VideoData.Time(i);
        T1 = VideoData.Time(i-1);

        Tx = ExpData(j,1) ;

        x = (Tx-T1) / (T2-T1);    

        % Interpolating data

        %Time
        Y2 = VideoData.Time(i);
        Y1 = VideoData.Time(i-1);

        Time_Interp(j,1)  = (Y2-Y1) * x + Y1 ;  
        
        % Height
        Y2 = VideoData.Height(i);
        Y1 = VideoData.Height(i-1);

        Height_Interp(j,1)  = (Y2-Y1) * x + Y1 ;   

        %Diameter
        for k = 1 : size(VideoData.Diameter,2)    
            Y2 = VideoData.Diameter(i,k);
            Y1 = VideoData.Diameter(i-1,k);

            Diameter_Interp(j,k)  = (Y2-Y1) * x + Y1 ;   
        end

    end

    InterpolatedData.Time = Time_Interp ;
    InterpolatedData.Diameter = Diameter_Interp ; 
    InterpolatedData.Height = Height_Interp ; 


    save('InterpolatedData','InterpolatedData');
    
    end 

% end function


% Y2 = VideoData.Displacement(i);
% Y1 = VideoData.Displacement(i-1);
% 
% Displacement_Interp(j,1)  = (Y2-Y1) * x + Y1 ;  

% for k = 1 : size(VideoData.Area,2)    
%     Y2 = VideoData.Area(i,k);
%     Y1 = VideoData.Area(i-1,k);
% 
%     Area_Interp(j,k)  = (Y2-Y1) * x + Y1 ; 
% end



