% Syncs data based on the peak axial displacement



function [VideoData,MTS_Data,LVDT_Data] = sync(VideoData,MTS_Data,LVDT_Data)

% Find the peak displacement
LVDT_Peak = LVDT_Data(:,2) == min(LVDT_Data(:,2)) ;
MTS_Peak = MTS_Data(:,3) == min(MTS_Data(:,3)) ;
Video_Peak = find(VideoData.Displacement(:) == min(VideoData.Displacement(:)) , 1 ) ;

% The time that the peak happens
Video_Peak_Time = VideoData.Time(Video_Peak);
MTS_Peak_Time = MTS_Data(MTS_Peak,1);
LVDT_Peak_Time = LVDT_Data(LVDT_Peak,1);

% Time correction relative to the MTS data
Asynchrony_LVDT_MTS = LVDT_Peak_Time - MTS_Peak_Time;
Asynchrony_Video_MTS = Video_Peak_Time - MTS_Peak_Time;

LVDT_Data(:,1) = LVDT_Data(:,1) - Asynchrony_LVDT_MTS;
VideoData.Time(:) = VideoData.Time(:) - Asynchrony_Video_MTS;

% Crop to the beggining
count = 1;
while( LVDT_Data(count,1)<0 )
    count = count + 1;
end

LVDT_Data(1:count,:) = [] ;

count = 1;
while(VideoData.Time(count) < 0)
    count = count + 1;
end

VideoData.Time(1:count) = [] ;
VideoData.Height(1:count) = [] ;
VideoData.Displacement(1:count) = [] ;
VideoData.Diameter(1:count,:) = [] ;


end
