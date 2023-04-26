clear all;
clc;
close all;
tmodel = createpde('thermal', 'steadystate');
importGeometry(tmodel, 'Tapered Fin.stl');
pdegplot(tmodel, 'FaceLabels', 'on', 'FaceAlpha', 0.5);
msh = generateMesh(tmodel, 'Hmax', 1);
%Material Properties
%kappa = 20000; % in W/m/K
thermalProperties(tmodel, 'ThermalConductivity', 20000);
thermalBC(tmodel, 'face', 1, 'Temperature', 300);
thermalBC(tmodel, 'face', 6, 'ConvectionCoefficient', 500, 'AmbientTemperature', 25);
thermalBC(tmodel, 'face', 3, 'ConvectionCoefficient', 30, 'AmbientTemperature', 25);
thermalBC(tmodel, 'face', [4 5], 'ConvectionCoefficient', 40, 'AmbientTemperature', 25);
Rt=solve(tmodel);
pdeplot3D(tmodel, 'ColorMapData', Rt.Temperature)