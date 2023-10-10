function []=draw_atlantis(y0,z0,shuttle_angle,roll_angle,phi,SRB_fuellevel,current_fuel_level_main,height_fuel_LO,thrust_SRB,Thrust_main,t)
% "draw_atlantis"
%Inputs:
%"y0" initial position of y
%"z0" initial position of z
%"shuttle_angle" angle of the shuttle to vertical
%"roll_angle" angle through which shuttle has rolle
%"phi" the angle of the main engine thrusted
%"SRB_fuellevel" fuel levels in a SRB tank
%"current_fuel_levels_main" fuel levels in the external tank
%"height_fuel_LO" height of fuel in the liquid oxygen tank
%"thrust_SRB" thrust from an individual SRB
%"Thrust_main" thrust from an individual main engine
%
%Sample input:
%draw_atlantis(100,0,100,10,180,18,200000,500000,5,500000,1090664,0)
% for frame=1:40
%draw_atlantis(0,y(frame,1),y(frame,3),shuttle_angle(frame),shuttle_roll(frame),phi(frame),SRB_fuellevel(frame),current_fuel_levels_main(frame),height_truncation(frame),SRB_output(frame),Thrust_main(frame),t)
%M(frame)=getframe()
%clf
%end

%Version 1
%21/04/2013
%Team 3

if nargin~=11 
    error('Error: Not enough input arguments. Eleven input arguments are necessary')
            % Flags an error if there are more or less than 11 input arguments
end

x0=0;
draw_cargo(x0,y0,z0,shuttle_angle,roll_angle,phi,Thrust_main); % Draws orbiter and cargo

if t<125
draw_srb_left(x0,y0,z0,shuttle_angle,roll_angle,SRB_fuellevel,thrust_SRB);
draw_srb_right(x0,y0,z0,shuttle_angle,roll_angle,SRB_fuellevel,thrust_SRB);
end

if t<510
draw_EXT(x0,y0,z0,shuttle_angle,roll_angle,current_fuel_level_main,height_fuel_LO);
end

draw_wing(x0,y0,z0,shuttle_angle,roll_angle);

hold on    
axis([x0-100 x0+50 y0-50 y0+50 z0-20 z0+50]);
axis equal
light('Position',[-10 -10 14]);
end
% Basic background code that would be incuded if matlab memory allowed it
%img = imread('sky.jpg');
%[X,Z] = ndgrid([-50+x0 50+x0],[z0-20 z0+80]);
%yImage = [50+y0 50+y0; 50+y0 50+y0];
%surf(X,yImage,Z,'CData',img,'FaceColor','texturemap');

%img = imread('sky.jpg');
%[Y,Z] = ndgrid([y0-50 y0+50],[z0-20 z0+80]);
%xImage = [50+x0 50+x0; 50+x0 50+x0];
%surf(xImage,Y,Z,'CData',img,'FaceColor','texturemap');

%if z0<1000
    
%    img = imread('sand.jpg');
%    [X,Y] = ndgrid([-50+x0 50+x0],[y0-50 y0+50]);
 %   zImage = [z0-20 z0-20; z0-20 z0-20];
%    surf(X,Y,zImage,'CData',img,'FaceColor','texturemap');
    
%else
   
%    img = imread('sky2.jpg');
 %  [X,Y] = ndgrid([-50+x0 50+x0],[y0-50 y0+50]);
   % zImage = [z0-20 z0-20; z0-20 z0-20];
   % surf(X,Y,zImage,'CData',img,'FaceColor','texturemap');
    
%end