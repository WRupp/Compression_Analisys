%% Just Process data


specimen_string = 'CP_01';
OutFile = 'EXP_Data.probe';

InitialHeight = 6;

TempoInicial = 0 ;
TempoFinal = 300 ;
dT = 1;

% Get 'em data files

OutputFileFolder   = [ 'Processed_Data\' specimen_string '\'];

load([OutputFileFolder 'Video_Data']);
load([OutputFileFolder 'LVDT_Data']);
load([OutputFileFolder 'MTS_Data']);


Time_Out = (TempoInicial : dT : TempoFinal)' ;
Time_Int = Time_Out;


[Disp_Int,Force_Int,Diam_Int] = Interpolate_Data(Time_Int ,Video_Data, LVDT_Data, MTS_Data);

[Axial_Stress,Axial_Strain_ln,Transversal_Strain_ln] = StressStrains(Disp_Int,Force_Int,Diam_Int,InitialHeight);

[Output_Data] = CreateCombinedOutput(Time_Out ,Video_Data, LVDT_Data, MTS_Data);

%% Output           
    
plotstuff ;
    
savestuff ; 