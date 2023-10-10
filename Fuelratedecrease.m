function [Fuelratedecrease current_fuel_levels_main] = Fuelratedecrease(thrust_output,current_fuel_levels_main,h)
%"Fuelratedecrease"calculates the rate of fuel decrease for a
%given throttle percentage for the main engine in volume/sec.
%Inputs:
%"thrust_output" percentage throttle
%"current_fuel_levels_main"
%"t-step" time step used
%Outputs:
%"Fuelratedecrease" rate of fuel decrease
%"current_fuel_levels_main" levels in external tank
%
%Sample input:
% [Fuelratedecrease current_fuel_levels_main] = Fuelratedecrease(90,735600,0.01)
%
%Version 1
%21/04/2013
%Team 3

density_mix=1000;          % density of fuel mix
efficiency_100=0.0132489;       % Litres of propellant per secind at 1% trhottle

if nargin~=3
    error('Error: Not enough input arguments. Three input arguments are necessary')
                % Flags an error if there are more or less than 3 input arguments
end

if thrust_output<65
    error('Error:Throttle must be between 67 and 111 percent.')  
end

if thrust_output>111  
    error('Error:Throttle must be between 67 and 111 percent.')
end

Fuelratedecrease=efficiency_100*thrust_output*density_mix;
current_fuel_levels_main=current_fuel_levels_main-h*Fuelratedecrease;

if current_fuel_levels_main<0
    
    current_fuel_levels_main=0; % Empty Tank
    
end

end