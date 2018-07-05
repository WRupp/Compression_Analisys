

% Comparison between displacement data sources
% f = figure('visible','off');
f = figure('visible','off');
hold on;

plot(MTS_Data(:,1),MTS_Data(:,3));
plot(LVDT_Data(:,1),LVDT_Data(:,2));
plot(Video_Data.Time,Video_Data.Displacement);

title([specimen_string ' Axial Displacement']);
xlabel('Time [s]');
ylabel('\Delta H [mm]');
legend('MTS' ,' LVDT' ,' VIDEO' ,'Location','NorthEastOutside' )
saveas(f,[OutputFileFolder specimen_string '_Displacement.tif'])
close(f);



% Diametro ao longo do tempo
f = figure('visible','off');
hold on

for i = 1 : size(Diam_Int,2)
plot(Time_Int, Diam_Int(:,i) )
end

title([specimen_string ' Diameter']);
xlabel('Time [s]');
ylabel('\o [mm]');
legend('\o_1' ,' \o_2' ,' \o_3' ,' \o_4' ,' \o_5','Location','NorthEastOutside' )

saveas(f,[OutputFileFolder specimen_string '_Diameter.tif'])
close(f);


% Deformação ao longo do tempo

f = figure('visible','off');
hold on;

for j = 1 : size(Transversal_Strain_ln,2)
    plot(Time_Int,Transversal_Strain_ln(:,j));
end

title([specimen_string ' Logarithmic Strain']);
xlabel('Time [s]');
ylabel('\epsilon ');
legend('\o_1' ,' \o_2' ,' \o_3' ,' \o_4' ,' \o_5','Location','NorthEastOutside' )
saveas(f,[OutputFileFolder specimen_string '_TransStrain.tif'])
close(f);


% Tensao

    % Tensao - Deformacao
f = figure('visible','off');
hold on;

for j = 1 : size(Axial_Stress,2)
    plot(Axial_Strain_ln,Axial_Stress(:,j));
end

title([specimen_string ' Stress x Strain']);
xlabel('Logarithmic Strain ');
ylabel('\sigma [MPa]');
legend('\o_1' ,' \o_2' ,' \o_3' ,' \o_4' ,' \o_5','Location','NorthEastOutside' )
saveas(f,[OutputFileFolder specimen_string '_Stress_Strain.tif'])
close(f);

    % Tensao - Tempo
f = figure('visible','off');
hold on;

for j = 1 : size(Axial_Stress,2)
    plot(Time_Int,Axial_Stress(:,j));
end

title([specimen_string ' Stress x Time']);
xlabel('Time [s]');
ylabel('\sigma [MPa]');
legend('\o_1' ,' \o_2' ,' \o_3' ,' \o_4' ,' \o_5','Location','NorthEastOutside' )
saveas(gcf,[OutputFileFolder specimen_string '_Stress_Time.tif'])
close(f);














