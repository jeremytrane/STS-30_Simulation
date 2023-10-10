function [Thurst_main] = Throttle(throttle,d)
%"Throttle" takes in the the percentage throttle for the
%rocket and the density and outputs the Thurst_main for one engine
%Inputs:
%"throttle" percentage throttle
%"d" density at height
%Outputs:
%"Thurst_main" the Thurst_main of one main engine at given percentage throttle
%
%Sample input:
% Throttle(70,1.204)

%Version 1
%21/04/2013
%Team 3

%Error checking
if nargin~=2
    error('Error: Not enough input arguments. Two input arguments are necessary')
            % Flags an error if there are more or less than 2 input arguments
end
minthrottle=65; % Initialise the minumum value of throttle
maxthrottle=111;% Initialise the maximum value of throttle
if throttle<minthrottle||throttle>maxthrottle
    error('Error Throttle must be between 67 percent and 111 percent');  
end

%Initialise values for equations
slope=-315920.44; % Slope of the relationship between percentage throttle,density and thrust(Thurst_main)
intercept=2090644; % Intercept of the relationship between percentage throttle,density and thrust(Thurst_main)

T=throttle/100;                 %Divide by 100 to get Thurst_main at 1 percent
T_max=slope*d+intercept;        %Relationship between density and Thurst_main
Thurst_main=T*T_max;                  %Calculates the Thurst_main
end

