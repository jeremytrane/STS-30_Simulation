function [M_Total COG_X COG_Y COG_Z height_truncation]=COG_Atlantis(SRB_fuellevel,current_fuel_levels_main,t)
% "COG_Atlantis" gives the overall mass and the overall coordinates of the
% centre of gravity
%Inputs:
%"SRB_fuellevel" fuel level in SRB
%"current_fuel_levels_main" fuel level in external tank
%"t" time since take off
%Outputs:
%"M_Total" total mass of Atlantis
%"COG_X" x coordinate centre of overall gravity 
%"COG_Y" y coordinate centre of overall gravity 
%"COG_Z" z coordinate centre of overall gravity 
%
%Sample input:
% [M_Total COG_X COG_Y COG_Z]=COG_Atlantis(502126.34,735600,124)

%Version 1
%21/04/2013
%Team 3

if nargin~=3 
    error('Error: Not enough input arguments. 3 input arguments are necessary')
            % Flags an error if there are more or less than 3 input arguments
end

% Initialises values
M_SRB=0; % Initials SRB height
COG_X_SRB=0; COG_Y_SRB=0; COG_Z_SRB=0;

M_EXT=0; % Initialise external tank height
COG_X_EXT=0; COG_Y_EXT=0; COG_Z_EXT=0;

if t<125 % If SRB tanks not jetisoned

[M_SRB COG_X_SRB COG_Y_SRB COG_Z_SRB]=SRB_mass(SRB_fuellevel);
% Calculate mass properties of SRB
end

height_truncation=0; % Initialises truncation height

if t<520 % If External tanks not jetisoned

[M_EXT COG_X_EXT COG_Y_EXT COG_Z_EXT height_truncation]=EXT_mass(current_fuel_levels_main);
% Calculate mass properties of External tank
end

M_ORB=98662.157; COG_X_Orbiter=0; COG_Y_Orbiter=8.5344; COG_Z_Orbiter=24.41;

M_Total=M_ORB+2*M_SRB+M_EXT; % Total mass of orbiter

COG_X=(COG_X_SRB*2*M_SRB+M_EXT*COG_X_EXT+M_ORB*COG_X_Orbiter)/M_Total;
COG_Y=(COG_Y_SRB*2*M_SRB+M_EXT*COG_Y_EXT+M_ORB*COG_Y_Orbiter)/M_Total;
COG_Z=(COG_Z_SRB*2*M_SRB+M_EXT*COG_Z_EXT+M_ORB*COG_Z_Orbiter)/M_Total;
end