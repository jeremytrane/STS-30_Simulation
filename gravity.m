function g=gravity(height,g_ground,r_earth)
% "gravity" calculates the gravity acceleration at a given height.
%Inputs:
% "height" altitude above sea level
% "g_ground" accleration due to gravity in S.I units at ground level
% "r_earth" radius of the earth.
%Outputs:
%"g" the gravity at that height
%
% Sample input:
% gravity(height,9.81,6400*10^3)

%Version 1
%21/04/2013
%Team 3

if nargin~=3
    error('Error: Not enough input arguments. Three input arguments are necessary')
                % Flags an error if there are more or less than 3 input arguments
end

g=g_ground*(r_earth/(r_earth+height))^2; %gets gravity at any height

end