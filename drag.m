function [Fx Fy]=drag(vx,vy,d_SRB,d_EXT,A_cargo,c_air,d)
% "drag" calculates the drag on Atlantis.
%Inputs:
% "vx" veloctiy in x direction
% "vy" velocity in y direction
% "d_SRB" diameter of solid rocket booster
% "d_EXT", diameter of external rocket fuel tanker
% "A_cargo" area of cargo ship
% "c_air", speed of sound of air
% "d", density of air
%Outputs:
%"Fx" drag component in x direction
%"Fy" drag component in y direction
%"F_drag_orbiter" drag on the orbiter
%"F_drag_tanks" drag on the external and SRB tanks
%
% Sample input:
% [Fx Fy]=drag(vx,vy,3.709,8.413,47.748,344,1.204)

%Version 1
%21/04/2013
%Team 3

if nargin~=7
    error('Error: Not enough input arguments. 7 input arguments are necessary')
                % Flags an error if there are more or less than 7 input arguments
end

v=((vx^2)+(vy^2))^0.5;      %getting the velocity vector
mach_number=v/c_air;        %getting mach number from give speed of sound

%External tank and SRB
if mach_number<0.8          %Condition in question
    Cd_external=0.25;       %Cd_external is coefficient of drag
    
elseif mach_number>=0.8&&mach_number<1
    Cd_external=5.25*mach_number-3.95; %linear relationship between mach0.8 and mach1
    
elseif mach_number>=1&&mach_number<2
     Cd_external=-0.9*mach_number+2.2; %linear relationship between mach1 and mach2
        
else  
    Cd_external=0.4;        % coefficient of drag above mach2 
end

A_tanks=(2*pi*(d_SRB/2)^2)+(pi*(d_EXT/2)^2);%gets area of tanks looking down

%Orbiter
if mach_number<0.8          %Condition in question
    Cd_orbiter=0.75;
    
elseif mach_number>=0.8&&mach_number<1
    Cd_orbiter=8.75*mach_number-6.25;%linear relationship between mach0.8 and mach1
    
elseif mach_number>=1&&mach_number<2   
    Cd_orbiter=-1.1*mach_number+3.6;%linear relationship between mach1 and mach2  
    
else
    Cd_orbiter=1.4;         % coefficient of drag above mach2
end

F_drag=0.5*d*(v^2)*(A_tanks*Cd_external+A_cargo*Cd_orbiter);%gets the full drag force


if vx~=0                    %error check if velocity in x direction is 0
    theta=atan(vy/vx);

else 
    theta=pi/2; 
end

Fx=-cos(theta)*F_drag;      %gets x and y components of drag
Fy=-sin(theta)*F_drag;
end