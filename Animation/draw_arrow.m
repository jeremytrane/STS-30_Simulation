function []=draw_arrow(x0,y0,z0,shuttle_angle,roll_angle,s)
% "draw_arrow" is a function used in draw_srb_right,draw_srb_left and
% draw_EXT to draw the arrows coming out of the external engines and SRB's
% that show colour to show their level of thrust
%Inputs:
%"x0" Initial position in x direction
%"y0" Initial position in Y diection
%"z0" Initial position in Z diection
%"shuttle_angle" angle of shuttle
%"roll_angle"angle of roll so far
%"s" thrust fraction
%
%Sample input:
%draw_arrow(0,0,0,10,5,0.5)

%Version 1
%21/04/2013
%Team 3

if nargin~=6 
    error('Error: Not enough input arguments. Six input arguments are necessary')
            % Flags an error if there are more or less than 6 input arguments
end

d_arrow=1.5;        %diameter of arrow
N=20;               %number of edges
L_cylinder=3;       %length of cylinder

[X_Cylinder,Y_Cylinder,Z_Cylinder]=cylinder(d_arrow/2,N); % Sets up cyclinder

Z_Cylinder=Z_Cylinder*L_cylinder; % Applies length

Rx=[1 0 0;0 cosd(shuttle_angle+180) -sind(shuttle_angle+180);0 sind(shuttle_angle+180) cosd(shuttle_angle+180)]; % Rotation matrix about x
Rz=[cosd(roll_angle) -sind(roll_angle) 0; sind(roll_angle) cosd(roll_angle) 0; 0 0 1]; % Rotation matrix about z

X_Cylinder=[X_Cylinder(1,:) X_Cylinder(2,:)]; Y_Cylinder=[Y_Cylinder(1,:) Y_Cylinder(2,:)]; Z_Cylinder=[Z_Cylinder(1,:) Z_Cylinder(2,:)];

R=[X_Cylinder;Y_Cylinder;Z_Cylinder];

for k=1:(N+1)*2
    R(:,k)=Rx*R(:,k); R(:,k)=Rz*R(:,k); % Rotates matrix
end
    
X_Cylinder=[R(1,1:N+1);R(1,N+2:2*(N+1))]; Y_Cylinder=[R(2,1:N+1);R(2,N+2:2*(N+1))]; Z_Cylinder=[R(3,1:N+1);R(3,N+2:2*(N+1))]; 

X_Cylinder=X_Cylinder+x0; Y_Cylinder=Y_Cylinder+y0; Z_Cylinder=Z_Cylinder+z0; % Translates matrix

hSurface=surf(X_Cylinder,Y_Cylinder,Z_Cylinder);
set(hSurface,'FaceColor',[s 0 1-s],'FaceAlpha',0.8,'linestyle','none');

% Cone
hold on

d_arrow=3; N=20; L_cylinder=4; % Cylinder parameters

[X_Cylinder_E,Y_Cylinder_E,Z_Cylinder_E]=cylinder(d_arrow/2,N);

Z_Cylinder_E=-Z_Cylinder_E*L_cylinder-3; % Applies length and position

X_Cylinder_E(2,:)=0; Y_Cylinder_E(2,:)=0; % Creates cone point

X_Cylinder_E=[X_Cylinder_E(1,:) X_Cylinder_E(2,:)]; Y_Cylinder_E=[Y_Cylinder_E(1,:) Y_Cylinder_E(2,:)]; Z_Cylinder_E=[Z_Cylinder_E(1,:) Z_Cylinder_E(2,:)];

Rx=[1 0 0;0 cosd(shuttle_angle) -sind(shuttle_angle);0 sind(shuttle_angle) cosd(shuttle_angle)]; % Rotation matrix about x
Rz=[cosd(roll_angle) -sind(roll_angle) 0; sind(roll_angle) cosd(roll_angle) 0; 0 0 1]; % Rotation matrix about z

R=[X_Cylinder_E;Y_Cylinder_E;Z_Cylinder_E];

for k=1:(N+1)*2 
    R(:,k)=Rx*R(:,k); R(:,k)=Rz*R(:,k); % Rotates points
end
    
X_Cylinder_E=[R(1,1:N+1);R(1,N+2:2*(N+1))]; Y_Cylinder_E=[R(2,1:N+1);R(2,N+2:2*(N+1))]; Z_Cylinder_E=[R(3,1:N+1);R(3,N+2:2*(N+1))];    

X_Cylinder_E=X_Cylinder_E+x0; Y_Cylinder_E=Y_Cylinder_E+y0; Z_Cylinder_E=Z_Cylinder_E+z0; % Translates points

%Sets thee object handle
hSurface=surf(X_Cylinder_E,Y_Cylinder_E,Z_Cylinder_E);
set(hSurface,'FaceColor',[s 0 1-s],'FaceAlpha',0.8,'linestyle','none'); 
end