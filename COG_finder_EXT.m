function [Z_COG height_truncation]=COG_finder_EXT(Fuel_Ratio,rellipsoid,hellipsoid)
% "COG_finder_EXT" gives the z coordinate of centre of gravity for the external, a truncated ogive.
%Inputs:
%"Fuel_Ratio" ratio of current fuel to full tank
%"rellipsoid" radius of ellipsoid
%"hellipsoid" height of ellipsoid
%Outputs:
%"Z_COG" z coordinate centre of gravity 
%
%Sample input:
% COG_finder_EXT(1,4.205,16.642)

%Version 1
%21/04/2013
%Team 3

if nargin~=3 
    error('Error: Not enough input arguments. Three input arguments are necessary')
            % Flags an error if there are more or less than 3 input arguments
end

if Fuel_Ratio>=0.01
A_full=pi*rellipsoid*hellipsoid/4; % Calculates area of a quarte of ellipse
height_truncation=0; % Initialises the truncation height
Closest_Area=100; % Initialise the are

Nsim=10000;         %Number of steps of simpsons rule

for h=0:0.1:hellipsoid % Incestigate till max height
    A=simpson_1(0,h,Nsim,rellipsoid,hellipsoid); % Uses simpsons rule for finding the COG of the Liquid hydrogen

    tester=abs(A_full*Fuel_Ratio-A); % Moniters desired area with that are of that height

    if Closest_Area>tester %gets closest value (h is in 0.1 increments)
            Closest_Area=tester; % Store the most accurate area
            height_truncation=h; % Stores its height
            A_actual=A;          % Stores the area
    end
end
    % Finds COG
    Z_COG=simpson_2(0,height_truncation,Nsim,rellipsoid,hellipsoid,A_actual)+29.5656; %simpsons rule

else  
    Z_COG=0; 
end
end
