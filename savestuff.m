

save([OutputFileFolder 'Video_Data'],'Video_Data'); 

save([OutputFileFolder 'LVDT_Data'],'LVDT_Data');

save([OutputFileFolder 'MTS_Data'],'MTS_Data') ; 

Interpolated_Data.Time = Time_Int;
Interpolated_Data.Displacement  = Disp_Int;
Interpolated_Data.Force = Force_Int ;
Interpolated_Data.Diameter = Diam_Int;
Interpolated_Data.Axial_Stress = Axial_Stress;
Interpolated_Data.Axial_Strain_ln = Axial_Strain_ln;
Interpolated_Data.Transversal_Strain_ln = Transversal_Strain_ln;

save([OutputFileFolder 'Interpolated_Data'],'Interpolated_Data'); 


dlmwrite([OutputFileFolder OutFile] ,Output_Data,'delimiter','\t','precision','%.8f','roffset',1);

