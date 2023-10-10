function [A] = simpson_1(x1,x2,N,a,b)
% "simpson_1" gives the area of an ellipsoid truncated at x2.
%Inputs:
%"x1" initial value
%"x2" final value
%"N" number of steps
%"a" radius of ellipsoid
%"b" height of ellipsoid
%Outputs:
%"A" the area of a quarter ellipse
%
%Sample input:
% simpson_1(0,8.3,1000,3.17,5)

%Version 1
%21/04/2013
%Team 3

if nargin~=5 
    error('Error: Not enough input arguments. Five input arguments are necessary')
            % Flags an error if there are more or less than 5 input arguments
end

h=abs(x1-x2)/N; % Calculates size of step

if rem(N,2)==0 % If step size fits in evenly
    
    % Simpsons Rule routine

x_even=x1+h:2*h:x2-h; 
x_odd=x1+(2*h):2*h:x2-(2*h);
    
y_odd=f(x_even,a,b);
y_even=f(x_odd,a,b);

A=h*(f(x1,a,b)+f(x2,a,b)+(4*sum(y_even))+(2*sum(y_odd)))/3;

else
    error('Please use round numbers');
end 
end

function y=f(x,a,b)

y=a*(1-(x/b).^2).^0.5;
end