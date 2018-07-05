
function [Disp_Int,Force_Int,Diam_Int] = Interpolate_Data(TimeOut ,Video_Data, LVDT_Data, MTS_Data)

 l = 2;
 m = 2;
 n = 2;
 
 
    for j = 1 : size(TimeOut,1)
        
        % Get Diameter from video
        
        while (Video_Data.Time(l) <= TimeOut(j))
            l = l + 1 ;
        end

        T2 = Video_Data.Time(l);
        T1 = Video_Data.Time(l-1);

        Tx = TimeOut(j,1) ;

        x = (Tx-T1) / (T2-T1);  

        for k = 1 : size(Video_Data.Diameter,2)    
            Y2 = Video_Data.Diameter(l,k);
            Y1 = Video_Data.Diameter(l-1,k);

            Diam_Int(j,k)  = (Y2-Y1) * x + Y1 ; 
            
        end
        
        % Get Force from MTS
        
        while (MTS_Data(m,1) <= TimeOut(j))
            m = m + 1 ;
        end

        T2 = MTS_Data(m,1);
        T1 = MTS_Data(m-1,1);

        Tx = TimeOut(j,1) ;

        x = (Tx-T1) / (T2-T1);  
        
        Y2 = MTS_Data(m,2);
        Y1 = MTS_Data(m-1,2);

        Force_Int(j,1)  = (Y2-Y1) * x + Y1 ;     
        
        
        % Get Displacement from LVDT
        
        
        while (LVDT_Data(n,1) <= TimeOut(j))
            n = n + 1 ;
        end

        T2 = LVDT_Data(n,1);
        T1 = LVDT_Data(n-1,1);

        Tx = TimeOut(j,1) ;

        x = (Tx-T1) / (T2-T1);  
        
        Y2 = LVDT_Data(n,2);
        Y1 = LVDT_Data(n-1,2);

        Disp_Int(j,1)  = (Y2-Y1) * x + Y1 ;             
        
        
    end

    
end
