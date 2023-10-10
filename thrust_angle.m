function [phi M_Total COG_X COG_Y COG_Z height_truncation] = thrust_angle (SRB_fuellevel,current_fuel_levels_main,t,Thrust_main,SRB_output,phi_old)
%"thrust_angle" Implements Newton-Raphson method to approximate the thrust
%angle, uses "phi_old" as the initial guess to calculate phi, the current
%thrust angle.
%Inputs:
% "SRB_fuellevel" the fuel level in the solid rocket booster
% "current_fuel_levels_main" Current fuel level in the main engines
% "t" The current time in seconds
% "Thrust_main" The thrust in the main engine
% "SRB_output" The thrust in the srb
% "F_drag_orbiter" drag on the orbiter
% "F_drag_tanks" drag on the external and SRB tanks
% Outputs
% "phi" the crank angle
% "M_Total" the total mass of Atlantis
% "COG_X" the centre of gravity in the X direction
% "COG_Y" the centre of gravity in the Y direction
% "COG_Z" the centre of gravity in the Z direction
%
% Sample input:
% phi = thrust_angle (502126.34,735600,0,1703668.8,2650000,15)

%Version 1
%21/04/2013
%Team 3

[M_Total COG_X COG_Y COG_Z height_truncation]=COG_Atlantis(SRB_fuellevel,current_fuel_levels_main,t); % Finds inertial parametres of atlantis

if nargin~=6     
       error('Please use 6 input arguments');    
else
    tol=1e-4;       % Sets the tolerence of our root
    a=1;            % Sets a to 1 initially to enter while loop correctly
    j=0;            % Sets up a number for the count in the while loop
    phi=phi_old;    % Set working 'phi' value to inputed value 'phi_old'

    while a>tol&&j<10000

        phi=phi-((2*SRB_output*COG_Y+3*Thrust_main*(COG_Z-5.79)*sind(phi)-3*Thrust_main*(8.3-COG_Y)*cosd(phi))/(3*Thrust_main*(COG_Z-5.79)*cosd(phi)+3*Thrust_main*(8.3-COG_Y)*sind(phi)));   %% Functions left arbritary so this can be used to other functions.
        a=abs(2*SRB_output*COG_Y+3*Thrust_main*(COG_Z-5.79)*sind(phi)-3*Thrust_main*(8.3-COG_Y)*cosd(phi));    %% Stays in loop while difference between last 2 guesses is greater that tolerence 'tol'.
        j=j+1;      % Exits in loop if over 100000 guesses are used.      
    end   
end

if j==10000         % If 10000 guesses attempts were made, it is likely to not be converging to 0 
    error('Function did not converge to 0. Please choose new initial value or function');     
end
end
