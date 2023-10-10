function z_COG =simpson_2(x1,x2,N,a,b,A)
% "simpson_2" gives the centre of gravity of the truncated area found in
% "simpson_1".
%Inputs:
%"x1" initial value
%"x2" final value
%"N" number of steps
%"a" radius of ellipsoid
%"b" height of ellipsoid
%"A" output of "simpson_1"
%Outputs:
%"z_COG" the z centre of gravity of ellipsoid
%
%Sample input:
% z_COG =simpson_2(0,8,1000,8,16,32)

%Version 1
%21/04/2013
%Team 3

if nargin~=6 
    error('Error: Not enough input arguments. Six input arguments are necessary')
            % Flags an error if there are more or less than 6 input arguments
end

h=abs(x1-x2)/N;

if rem(N,2)==0

x_even=x1+h:2*h:x2-h; 
x_odd=x1+(2*h):2*h:x2-(2*h);
    
y_odd=f2(x_even,a,b);
y_even=f2(x_odd,a,b);

z=h*(f2(x1,a,b)+f2(x2,a,b)+(4*sum(y_even))+(2*sum(y_odd)))/3;
z_COG=z/A;

else
    error('Please use round numbers');
    
end 
end

function y=f2(x,a,b)

y=a*x.*(1-((x.^2)/(b^2))).^0.5;

end