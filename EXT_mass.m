function [MEXT COG_X COG_Y COG_Z height_truncation]=EXT_mass(current_fuel_levels_main)
% "EXT_mass" gives the mass of the external tank with its x y and z
% coordinates of centre of gravity.
%Inputs:
%"current_fuel_levels_main" fuel level in solid rocket booster in kg
%Outputs:
%"MEXT" mass of external tank
%"COG_X" x coordinate centre of gravity 
%"COG_Y" y coordinate centre of gravity 
%"COG_Z" z coordinate centre of gravity 
%
%Sample input:
% [MEXT COG_X COG_Y COG_Z]=EXT_mass(735600)

%Version 1
%21/04/2013
%Team 3

%Initialise variables for COG_LOX
rellipsoid=4.20624;   %radius of ellipsoid
hellipsoid=16.64;     %height of ellipsoid

%Initialise other variables
W_Ext_empty=35425.5352; %Initialise the weight of the external tank in kg when empty
W_LOXto=629339.395;     %Initialise the weight of liquid oxygen in kg at take off
W_LOHto=106260.73;      %Initialise the weight of liquid hydrogen in kg at take off
hLH_tank=29.5656;       %Height of liquid hydrogen tank
h_EXT=46;               %Height of external tank

fuel_extTO=735600.1254; %Initialise fule in external tank at take off for use in conditional statements

if current_fuel_levels_main<0||current_fuel_levels_main>fuel_extTO %max fuel in ext
    error('Fuel levels out of range');
end

if nargin~=1 
    error('Error: Not enough input arguments. One input arguments are necessary')
            % Flags an error if there are more or less than 1 input arguments
end


MEXT=W_Ext_empty+current_fuel_levels_main;                  %total mass of ext (empty and fuel)

Fuel_Ratio=(current_fuel_levels_main/fuel_extTO);           %ratio of current fuel to max fuel
    
[COG_LOX height_truncation]=COG_finder_EXT(Fuel_Ratio,rellipsoid,hellipsoid);   % COG of LOX Tank

M_LO=Fuel_Ratio*W_LOXto;                                    %gets mass of liquid oxygen
M_LH=Fuel_Ratio*W_LOHto;                                    %gets mass of liquid hydrogen

COG_Z=11+((W_Ext_empty*h_EXT/2)+(M_LH*Fuel_Ratio*hLH_tank)+(M_LO*COG_LOX))/MEXT;
COG_Y=0;
COG_X=0;                                            %assume symetrical (SRB's)
end