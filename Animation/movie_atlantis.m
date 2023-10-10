function [M]=movie_atlantis(y0,z0,shuttle_angle,shuttle_roll,phi,SRB_fuellevel,current_fuel_levels_main,height_truncation,SRB_output,Thrust_main,M_Total,Q,t)
% "movie_atlantis" creates a movie of Atlantis including subplots of fuel
% levels, craft tracking, thrust, shuttle mass, dynamic pressure and
% various shuttle angles with respect to time from take off.
%Inputs:
%"y0" initial position of y
%"z0" initial position of z
%"shuttle_angle" Angle of shuttle to verticle
%"shuttle_roll" Angle shuttle has rolled
%"phi" angle of thrusters
%"SRB_fuellevel" fuel level of SRB tanks
%"current_fuel_levels_main" fuel level of main tanks
%"height_truncation" height of liquid oxygen
%"SRB_output" srb thrust
%"Thrust_main" main engine thrust
%"t" time
%Outputs:
%"M" for movie
%
%Sample input:
%M=movie_atlantis(y(:,1),y(:,3),shuttle_angle,shuttle_roll,phi,SRB_fuellevel,current_fuel_levels_main,height_truncation,SRB_output,Thrust_main,M_Total,Q,t)

%Version 1
%21/04/2013
%Team 3

if nargin~=13
    error('Error: Not enough input arguments. Thirteen input arguments are necessary')
            % Flags an error if there are more or less than 13 input arguments
end

[nx ny]=size(t); % Checks the size of the time vector

handlefig=figure('Position',[0 0 1200 1200]); % Presets the camera location

for frame=1:nx-1
% Sets up frame Atlantis animation    
subplot(3,3,[3 6 9])
draw_atlantis(y0(frame),z0(frame),shuttle_angle(frame),shuttle_roll(frame),phi(frame),SRB_fuellevel(frame),current_fuel_levels_main(frame),height_truncation(frame),SRB_output(frame),Thrust_main(frame),t(frame))
title('Atlantis Camera View');

% Sets up frame with fuel levels graph
subplot(3,3,5)
plot(t(1:frame),current_fuel_levels_main(1:frame),'b')
hold on
plot(t(1:frame),SRB_fuellevel(1:frame),'r')
title('Fuel Levels');
xlabel('Time Since TO (seconds)')
ylabel('Fuel Remaining(kg)')
legend('External Tank Level','Individual SRB Level','Location','NorthWest')

% Sets up frame with craft tracking
subplot(3,3,[1 4])
plot(y0(1:frame)/1000,z0(1:frame)/1000)
title('Craft Tracker');
xlabel('Horizontal Travel(km)')
ylabel('Vertical Travel(km)')

% Sets up frame to moniter thrust
subplot(3,3,7)
plot(t(1:frame),Thrust_main(1:frame)/1000,'b')
hold on
plot(t(1:frame),SRB_output(1:frame)/1000,'r')
title('Engine Thrusts');
xlabel('Time Since TO (seconds)')
ylabel('Thrust(kN)')
legend('Individual Main Engine Thrust','Individual SRB Thrust','Location','NorthWest')

% Sets up frame to monitor shuttle mass
subplot(3,3,2)
plot(t(1:frame),M_Total(1:frame),'b')
title('Shuttle Mass');
xlabel('Time Since TO (seconds)')
ylabel('Mass (metric tons)')

% Sets up frame to monitor dynamic pressure and then the various shuttle angles
if Q(frame)~=0
subplot(3,3,8)
plot(t(1:frame),Q(1:frame),'b')
title('Dynamic Pressure');
xlabel('Time Since TO (seconds)')
ylabel('Dynamic Pressure(Pascals')

else    
subplot(3,3,8)
plot(t(1:frame),shuttle_angle(1:frame),'b')
hold on
plot(t(1:frame),shuttle_roll(1:frame),'r')
plot(t(1:frame),phi(1:frame),'k')
title('Angles');
xlabel('Time Since TO (seconds)')
ylabel('Degrees')
legend('Shuttle Angle To Vertical','Shuttle Roll','Main Engine Thruster Angles','Location','NorthWest')
end

M(frame)=getframe(handlefig); % Saves frame
clf % Reset figure
end
end