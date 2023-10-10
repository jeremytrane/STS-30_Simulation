function [MSRB COG_X COG_Y COG_Z]=SRB_mass(SRB_fuellevel)
% "SRB_mass" gives the mass of the solid rocket booster with its x y and z
% coordinates of centre of gravity.
%Inputs:
%"SRB_fuellevel" fuel level in solid rocket booster in kg
%Outputs:
%"MSRB" mass of SRB
%"COG_X" x coordinate centre of gravity 
%"COG_Y" y coordinate centre of gravity 
%"COG_Z" z coordinate centre of gravity 
%
%Sample input:
% [MSRB COG_X COG_Y COG_Z]=SRB_mass(502126.344)

%Version 1
%21/04/2013
%Team 3

%Initialise Values 
srbheight=46;                             %Height of srb in meters
max_fuel_SRB=502126.344;                  % max fuel for SRB
h=(SRB_fuellevel/max_fuel_SRB)*srbheight;   %puts fuel level as a fraction of max
fuel_mass_SRB_per_height=max_fuel_SRB/srbheight; % Fuel mass per height of fuel
srbempty=87543.256;                       % Initialise weight in kg of empty rocket booster
MSRB=srbempty+SRB_fuellevel;             %total mass of SRB (fuel and empty)


%Error Checking
if SRB_fuellevel<0||SRB_fuellevel>max_fuel_SRB     %max kg of fuel in SRB
    error('Error fuel level must be between zero and 502126.344'); 
end

if nargin~=1
    error('Error: Not enough input arguments. One input arguments are necessary')
            % Flags an error if there are more or less than 1 input arguments
end

COG_Z=(srbempty*(srbheight/2)+0.5*fuel_mass_SRB_per_height*h^2)/(srbempty+fuel_mass_SRB_per_height*h);
COG_Y=0;
COG_X=0;                            %assume symetrical (SRB's)

end