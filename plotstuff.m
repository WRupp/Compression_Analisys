

% Diametro ao longo do tempo
figure;
hold on

for i = 1 : size(InterpolatedData.Diameter,2)
plot(InterpolatedData.Time, InterpolatedData.Diameter(:,i) )
end

title('Test Speciment Diameter');
xlabel('Time [s]');
ylabel('\o [mm]');
legend('\o_1' ,' \o_2' ,' \o_3' ,' \o_4' ,' \o_5','Location','NorthEastOutside' )

saveas(gcf,'Diametro.tif')
close(gcf);


% Deformação ao longo do tempo

figure;
hold on;

for j = 1 : size(Stress,2)
    plot(InterpolatedData.Time,Strain_ln(:,j));
end

title('Test Speciment Logarithmic Strain');
xlabel('Time [s]');
ylabel('\epsilon ');
legend('\o_1' ,' \o_2' ,' \o_3' ,' \o_4' ,' \o_5','Location','NorthEastOutside' )
saveas(gcf,'Altura.tif')
close(gcf);


% Tensao

figure;
hold on;

for j = 1 : size(Stress,2)
    plot(InterpolatedData.Time,Stress(:,j));
end

title('Test Speciment Stress');
xlabel('Time [s]');
ylabel('\sigma [MPa]');
legend('\o_1' ,' \o_2' ,' \o_3' ,' \o_4' ,' \o_5','Location','NorthEastOutside' )
saveas(gcf,'Stress.tif')
close(gcf);
