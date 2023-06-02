clc
clear
close all

load('generated_5000configurations20171030-102358.mat')

N = 4;
FOOTPRINT = 30;
ZMIN = 8;
ZMAX = ZMIN + 15;

allowed_area = 29*[cos(linspace((-90-77.33)/180*pi,(-90+53.79)/180*pi,50));
    sin(linspace((-90-77.33)/180*pi,(-90+53.79)/180*pi,50))];
allowed_area = [[-15.8 -15.8;0 -2.33], allowed_area, [23.4 10 10;-12.42 -6 0]];
allowed_area = [allowed_area, [1 0; 0 -1]*allowed_area(:,end:-1:1)];

show_configurations(vc, N, allowed_area, ZMIN, ZMAX)