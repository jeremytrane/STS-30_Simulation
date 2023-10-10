function [thrust_output SRB_output SRB_fuellevel t]=throttle_map(h,tf)
% "throttle_map" calculates the throttle map for STS-30 main engine.
% Inputs:
%"h" the timestep used for simulation
% Outputs:
%"thrust_output" Force provided by main engine
%"SRB_output" Force provide by SRB
%"SRB_fuel level" SRB fuel level
%"t" Time these occur
%
%Sample input:
% [t s fuel_srb time]=throttle_map(0.01,520);
% plot(time,t)
% plot(time,s)

%Version 1
%21/04/2013
%Team 3

if nargin~=2
    error('Error: Not enough input arguments. 2 input arguments are necessary')
                % Flags an error if there are more or less than 1 input arguments
end

t0=0; % Initialise t0

t=t0:h:t0+4*h; % Sets up time vector
t=[t t0+5*h:h:tf];
t=t'; % Makes time a column vector

[nx ny]=size(t); % Outputs size of t

thrust_output=zeros(nx,1); % Initialise thrust output
SRB_output=zeros(nx,1); % Initialises SRB output
SRB_fuellevel=zeros(nx,1); % Initialises SRB fuel level 
SRB_fuel_TO=502126.34; % Initialise Srb fuel in kg at take off
for n=1:nx
    
    if t(n,1)<30 % If time less than 30
        thrust_output(n,1)=90; % Thrust output at 90 percent
        
    elseif t(n,1)>=30&&t(n,1)<62 % Time between 30 and 60 seconds
         thrust_output(n,1)=65; % Thrust output at 65 percent
         
    elseif t(n,1)>=62<511 % Time between 62 and 511 seconds
         thrust_output(n,1)=104; % Thrust output at 104 percent
         
    else
        thrust_output(n,1)=0; % Main Engines off
        
    end
    
    if t(n,1)<119.05 % If time less that 119.05 seconds
        
        SRB_output(n,1)=11787787.24; % Constant throttle on SRB
        SRB_fuellevel(n,1)=SRB_fuel_TO-4217.77*t(n,1); % Linear for fuel consumption  
        
    end 
end
end

        