% Create mixed output 


function [Output_Data] = CreateCombinedOutput(TimeOut ,Video_Data, LVDT_Data, MTS_Data)

 i = 2;
 m = 2;
 
    for j = 1 : size(TimeOut,1)
        
        % Get Diameter from video
        
        while (Video_Data.Time(i) <= TimeOut(j))
            i = i + 1 ;
        end

        T2 = Video_Data.Time(i);
        T1 = Video_Data.Time(i-1);

        Tx = TimeOut(j,1) ;

        x = (Tx-T1) / (T2-T1);  

        for k = 1 : size(Video_Data.Diameter,2)    
            Y2 = Video_Data.Diameter(i,k);
            Y1 = Video_Data.Diameter(i-1,k);

            Diameter_Out(j,k)  = (Y2-Y1) * x + Y1 ;
            
            Transversal_Displacement(j,k)  = Diameter_Out(j,k) - Diameter_Out(1,k);
        end
        
        % Get Force from MTS
        
        while (MTS_Data(m,1) <= TimeOut(j))
            m = m + 1 ;
        end

        T2 = MTS_Data(m,1);
        T1 = MTS_Data(m-1,1);

        Tx = TimeOut(j,1) ;

        x = (Tx-T1) / (T2-T1);  
        
        Y2 = MTS_Data(i,2);
        Y1 = MTS_Data(i-1,2);

        Force_Out(j,1)  = (Y2-Y1) * x + Y1 ;         
        
    end

    Output_Data = [ TimeOut   Force_Out  Transversal_Displacement ] ;  
    
end
% 
% 
%     i = 2;
%     for j = 1 : size(ExpData,1)
%         
%         while (Video_Data.Time(i) <= TimeOut(j))
%             i = i + 1 ;
%         end
% 
%         T2 = Video_Data.Time(i);
%         T1 = Video_Data.Time(i-1);
% 
%         Tx = ExpData(j,1) ;
% 
%         x = (Tx-T1) / (T2-T1);    
% 
%         % Interpolating data
% 
%         % Time
%         Y2 = Video_Data.Time(i);
%         Y1 = Video_Data.Time(i-1);
% 
%         Time_Interp(j,1)  = (Y2-Y1) * x + Y1 ;  
%         
%         % Displacement
%         Y2 = Video_Data.Displacement(i);
%         Y1 = Video_Data.Displacement(i-1);
% 
%         Displacement_Interp (j,1)  = (Y2-Y1) * x + Y1 ;   
% 
%         % Diameter
%         for k = 1 : size(Video_Data.Diameter,2)    
%             Y2 = Video_Data.Diameter(i,k);
%             Y1 = Video_Data.Diameter(i-1,k);
% 
%             Diameter_Interp(j,k)  = (Y2-Y1) * x + Y1 ;   
%         end

%     end