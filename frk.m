function [v]=frk(vx,vy,Fx,Fy,thrust_SRB,Thrust_main,M_Total,shuttle_angle,phi,g)
% "frk" gives the z coordinate of centre of gravity for the external, a truncated ogive.
%Inputs:
%"vx" velocity in x direction
%"vy" velocity in y direction
%"Fx" force in x direction
%"Fy" force in y direction
%"thrust_SRB"
%"Thrust_main"
%"M_Total"
%"shuttle_angle"
%"phi"
%"g" gravity
%Outputs:
%"v" 
%
%Version 1
%21/04/2013
%Team 3

if nargin~=10 
    error('Error: Not enough input arguments. Ten input arguments are necessary')
            % Flags an error if there are more or less than 10 input arguments
end

% Equation of motion for the rocket
v=zeros(1,4);
v(1,1)=vx;
v(1,2)=(thrust_SRB*sind(shuttle_angle)*2-Thrust_main*3*sind(phi-shuttle_angle)-Fx)/(M_Total);
v(1,3)=vy;
v(1,4)=(thrust_SRB*cosd(shuttle_angle)*2+Thrust_main*3*cosd(phi-shuttle_angle)-Fy-M_Total*g)/(M_Total);
end