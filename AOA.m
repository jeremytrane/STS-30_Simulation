function [shuttle_angle shuttle_roll t]=AOA(h,tf)
% "AOA" calculates the pitch and yaw of the shuttle
% Inputs:
%"h" the timestep used for simulation
% Outputs:
%"shuttle_angle" angle between velocity and horizon
%"shuttle_roll" amount shuttle has rolled since take-off
%"t" matrix containing info on when these occur
%
%Sample input:
% [shuttle_angle shuttle_roll t]=AOA(0.01);
% plot(t,shuttle_angle)
% plot(t,shuttle_roll)

%Version 1
%21/04/2013
%Team 3

if nargin~=2
    error('Error: Not enough input arguments. 2 input arguments are necessary')
                % Flags an error if there are more or less than 1 input arguments
end

t0=0;

t=t0:h:t0+4*h; % Sets up x vector
t=[t t0+5*h:h:tf];
t=t'; % Makes x a column vector

[nx ny]=size(t); % Finds size of t

shuttle_angle=zeros(nx,1); % Initialises shuttle angle matrix 
shuttle_roll=zeros(nx,1); % Initialises shuttle roll matrix

for n=1:nx
    if t(n,1)<9 % If time less than 9 seconds
        shuttle_angle(n,1)=0; % Shuttle is vertical
        shuttle_roll(n,1)=0; % Shuttle is not rolled
        
    elseif t(n,1)>=9&&t(n,1)<17 % If time between 9 and 17 seconds
        shuttle_angle(n,1)=1.5*t(n,1)-13.5; % Gradually tilt
        shuttle_roll(n,1)=22.5*t(n,1)-202.5; % Gradually roll
        
    else 
        shuttle_angle(n,1)=12; % Shuttle tilted at 10 degrees to vertical
        shuttle_roll(n,1)=180; % Shuttle rolled 180 degrees 
    end 
end
end