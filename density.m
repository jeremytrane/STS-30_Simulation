function [d c_air]=density(height,ground_temp,p_sea_level,g,R,L,M)
% 'density' calculates the density of air and speed of sound of at a given height.
%Inputs:
% "height" altitude above sea level
% "ground_temp" ground temperature in kelven
% "p_sea_level" sea level pressure, pascals
% "g" accleration due to gravity in S.I units
% "R" the universal gas constant
% "L" temperature lapse rate
% "M" molar mass of air
%Outputs:
%"d" density at that height
%"c_air" speed of sound at that height
%
% Sample input:
% density(height,293.15,101325,9.81,8.31447,0.0065,0.0289644)
% 
%Sample input for graph:
% d=zeros(110000,1);
% for x=1:110000
% d(x,1)=density(x,293.15,101325,9.81,8.31447,0.0065,0.0289644);
% end
% x=1:110000;
% x=x';
% plot(x,d)

%Version 1
%21/04/2013
%Team 3

gamma=1.402;                                 % Ratio of Cp to Cv

if nargin~=7
    error('Error: Not enough input arguments. Seven input arguments are necessary')
                % Flags an error if there are more or less than 7 input arguments
end

if height<0||ground_temp<0||p_sea_level<0
    error('Height, ground temperature and atomospheric pressure must be greater than 0');

elseif height>40000
    d=0;
    c_air=0;
    
else
pressure_at_height=p_sea_level*(1-(L*height/ground_temp))^(g*M/(R*L)); %gets pressure at any height
T=ground_temp-L*height;                     % Temp. at altitude
d=(pressure_at_height*M)/(R*T);             % density at altitude
c_air=(gamma*pressure_at_height/d)^0.5;     %gets speed of sound at that height

end
end