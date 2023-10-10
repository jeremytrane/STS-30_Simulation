function [y thrust_output Thrust_main SRB_output shuttle_angle shuttle_roll phi g M_Total Q d current_fuel_levels_main SRB_fuellevel height_truncation t]=Adams_BM(h,x0,vx0,y0,vy0,t0,tf,w1,w2,w3,w4)
% "Adams_BM" uses 4 step Adams Bashforth/ Moulton corrector with a 4th
% order Runge-Kutta predictor to determmine the positions and velocities of
% Atlantis. Various other parameters are outputted as shown below.
%Inputs:
%"h"
%"x0" initial x position
%"vx0" initial x velocity
%"y0" initial y position
%"vy0" initial y velocity
%"t0" initial time
%"tf" final time
%"w1" Adams constant
%"w2" Adams constant
%"w3" Adams constant
%"w4" Adams constant
%Outputs:
%"y" Matrix where first column is x position, second is x velocity, third is y position and last is y velocity
%"thrust_output" percent of thrust being outputted an an instant
%"Thrust_main" actual force being transmitted by each main engine
%"SRB_output" actual force being outputted by SRB
%"shuttle_angle" angle of shuttle to vertical
%"shuttle_roll" angle shuttle has rolled about its length
%"phi" angle of main engines at any given moment
%"g" gravity at given height
%"M_Total" mass of Atlantis
%"Q" the dynamic pressure on Atlantis
%"d" the density of air
%"current_fuel_levels_main" fuel levels in the main tank
%"SRB_fuellevel" fuel levels in the SRB tanks
%"height_truncation" height of liquid oxygen in ogive tank
%"t" time
%
%Sample input:
%[y thrust_output Thrust_main SRB_output shuttle_angle shuttle_roll phi g M_Total Q d current_fuel_levels_main SRB_fuellevel height_truncation t]=Adams_BM(1,0,0,0,0,0,20,1/6,2/6,2/6,1/6)

%Version 1
%21/04/2013
%Team 3

if nargin~=11 
    error('Error: Not enough input arguments. Eleven input arguments are necessary')
            % Flags an error if there are more or less than 11 input arguments
end

if mod(tf-t0,h)~=0
    error('Please use step size that counts directly between limits')
end

if tf<=t0
    error('tf must be greater than t0')
end

if tf<=t0+4*h
    error('Requires larger range or smaller step size "h" ')
end

y=zeros(((tf-t0)/h)+1,4 ); % Initialises y

y(1,1:4)=[x0 vx0 y0 vy0]; % Sets initial y value

[thrust_output SRB_output SRB_fuellevel]=throttle_map(h,tf); % Sets up throttle map
[shuttle_angle shuttle_roll]=AOA(h,tf); % Sets up angles of attack

t=t0:h:t0+4*h; % Sets up time vector
t=[t t0+5*h:h:tf];
t=t'; % Makes t a column vector
[nx ny]=size(t); % Finds size of t

phi=zeros(nx,1); % Initialises main engine angle
Thrust_main=zeros(nx,1); % Initialises Thrust_main matrix
M_Total=zeros(nx,1); % Initialises M_total matrix
g=zeros(nx,1); % Initialises g gravity matrix
d=zeros(nx,1); % Initialises d density matrix
Q=zeros(nx,1); % Initialises Q dynamic pressure matrix
current_fuel_levels_main=zeros(nx,1); % Initialise current fuel level matrix
height_truncation=zeros(nx,1); % Initialise height of liquid oxygen matrix
Fx=zeros(nx,1); % Initialises drag in x direction
Fy=zeros(nx,1); % Initialises drag in y direction

c=1; % Initialises count

[d(c) c_air]=density(y(c,3),288.15,101325,9.81,8.31447,0.0065,0.0289644); % Calculates initial density
g(c)=gravity(y(c,3),9.81,6371*10^3); % Calculates gravity at a certain height
[Thrust_main(c)] = Throttle(thrust_output(c),d(c)); % Thrust of 1 main engine
[Fx(c) Fy(c)]=drag(y(c,2),y(c,4),3.709,8.413,50.748,c_air,d(c));

current_fuel_levels_main(c)=735600; % Initial fuel level 
[fuelratedecrease current_fuel_levels_main(c+1)] = Fuelratedecrease(thrust_output(c),current_fuel_levels_main(c),h);

[phi(c) M_Total(c) COG_X COG_Y COG_Z height_truncation(c)] = thrust_angle(SRB_fuellevel(c),current_fuel_levels_main(c),t(c),Thrust_main(c),SRB_output(c),15);
Q(c)=0.5*d(c)*((y(c,2)^2)+(y(c,4)^2))^0.5; % Calculates dynamic pressure

for x=t0:h:t0+4*h % Initial Runge-Katta with smaller step
    
    vx=y(c,2);
    vy=y(c,4);
  
    k1=h*frk(vx,vy,Fx(c),Fy(c),SRB_output(c),Thrust_main(c),M_Total(c),shuttle_angle(c),phi(c),g(c)); % Defines k1 
    vx=vx+0.5*k1(2);
    vy=vy+0.5*k1(4);
    
    k2=h*frk(vx,vy,Fx(c),Fy(c),SRB_output(c),Thrust_main(c),M_Total(c),shuttle_angle(c),phi(c),g(c)); % Defines k2
    vx=vx+0.5*k2(2);
    vy=vy+0.5*k2(4);
    
    k3=h*frk(vx,vy,Fx(c),Fy(c),SRB_output(c),Thrust_main(c),M_Total(c),shuttle_angle(c),phi(c),g(c)); % Defines k3
    vx=vx+k3(2);
    vy=vy+k3(4);
    
    k4=h*frk(vx,vy,Fx(c),Fy(c),SRB_output(c),Thrust_main(c),M_Total(c),shuttle_angle(c),phi(c),g(c)); % Defines k4

    y(c+1,1:4)=y(c,1:4)+(w1*k1+w2*k2+w3*k3+w4*k4); %  Applies step
    
    c=c+1; % Continues counts
    
    [d(c) c_air]=density(y(c,3),288.15,101325,9.81,8.31447,0.0065,0.0289644); % Calculates density
    g(c)=gravity(y(c,3),9.81,6371*10^3); % Calculates gravity
    [Thrust_main(c)] = Throttle(thrust_output(c),d(c)); % Thrust of 1 main engine
    [Fx(c) Fy(c)]=drag(y(c,2),y(c,4),3.709,8.413,50.748,c_air,d(c)); % Calculates drag

    [fuelratedecrease current_fuel_levels_main(c+1)] = Fuelratedecrease(thrust_output(c),current_fuel_levels_main(c),h); % Calculates fuel usage and levels
    [phi(c) M_Total(c) COG_X COG_Y COG_Z height_truncation(c)] = thrust_angle(SRB_fuellevel(c),current_fuel_levels_main(c),t(c),Thrust_main(c),SRB_output(c),15); % Calculates thruster angle
    Q(c)=0.5*d(c)*((y(c,2)^2)+(y(c,4)^2))^0.5; % Calculates dynamic pressure

end

for x=t0+5*h:h:tf-h % Adam-Bashford/Moulton iterations
   
    vx=y(c,2);
    vy=y(c,4);
    
    vx1=y(c-1,2);
    vy1=y(c-1,4);
    
    vx2=y(c-2,2);
    vy2=y(c-2,4);
    
    vx3=y(c-3,2);
    vy3=y(c-3,4);

    frk_1=frk(vx,vy,Fx(c,1),Fy(c),SRB_output(c),Thrust_main(c),M_Total(c),shuttle_angle(c),phi(c),g(c));
    frk_2=frk(vx1,vy1,Fx(c-1),Fy(c-1),SRB_output(c-1),Thrust_main(c-1),M_Total(c-1),shuttle_angle(c-1),phi(c-1),g(c-1));
    frk_3=frk(vx2,vy2,Fx(c-2),Fy(c-2),SRB_output(c-2),Thrust_main(c-2),M_Total(c-2),shuttle_angle(c-2),phi(c-2),g(c-2));
    frk_4=frk(vx3,vy3,Fx(c-3),Fy(c-3),SRB_output(c-3),Thrust_main(c-3),M_Total(c-3),shuttle_angle(c-3),phi(c-3),g(c-3));
    
    y(c+1,1:4)=y(c,1:4)+h*((55/24)*frk_1-(59/24)*frk_2+(37/24)*frk_3-(9/24)*frk_4); % Predictor
    
    frk_p=frk(y(c+1,2),y(c+1,4),Fx(c),Fy(c),SRB_output(c),Thrust_main(c),M_Total(c),shuttle_angle(c),phi(c),g(c));

    y(c+1,1:4)=y(c,1:4)+h*((9/24)*frk_p+(19/24)*frk_1-(5/24)*frk_2+(1/24)*frk_3); % Corrector
    
    c=c+1; % Continues counts
    
    [d(c) c_air]=density(y(c,3),288.15,101325,9.81,8.31447,0.0065,0.0289644);  % Calculates density
    g(c)=gravity(y(c,3),9.81,6371*10^3); % Calculates gravity
    [Thrust_main(c)] = Throttle(thrust_output(c),d(c)); % Thrust of 1 main engine
    [Fx(c) Fy(c)]=drag(y(c,2),y(c,4),3.709,8.413,50.748,c_air,d(c)); % Calculates drag
 
    [fuelratedecrease current_fuel_levels_main(c+1)] = Fuelratedecrease(thrust_output(c),current_fuel_levels_main(c),h); % Calculates fuel usage and levels

    [phi(c) M_Total(c) COG_X COG_Y COG_Z height_truncation(c)] = thrust_angle(SRB_fuellevel(c),current_fuel_levels_main(c),t(c),Thrust_main(c),SRB_output(c),phi(c-1)); % Calculates thruster angle
    Q(c)=0.5*d(c)*((y(c,2)^2)+(y(c,4)^2))^0.5; % Calculates dynamic pressure

end
end