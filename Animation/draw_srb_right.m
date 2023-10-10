function []=draw_srb_right(x0,y0,z0,shuttle_angle,roll_angle,SRB_fuellevel,thrust_SRB)
% "draw_srb_right" draws the right SRB of Atlantis including the cylinder for
% the tank and fuel and the top cone
%Inputs:
%"x0" initial position of x
%"y0" initial position of y
%"z0" initial position of z
%"shuttle_angle" Current shuttle angle
%"roll_angle" Angle of Atlantis during the roll manoeuvre
%"SRB_fuellevel" Fuel level in the srb tannks
%"thrust_SRB" Thrust from the srb engine
%
%Version 1
%21/04/2013
%Team 3

if nargin~=7 
    error('Error: Not enough input arguments. Seven input arguments are necessary')
            % Flags an error if there are more or less than 7 input arguments
end

d_srb=3.7; N=20; L_cylinder=43;

[X_Cylinder,Y_Cylinder,Z_Cylinder]=cylinder(d_srb/2,N);

Z_Cylinder=Z_Cylinder*L_cylinder;

X_Cylinder=X_Cylinder+6.5; % Translates X-components

Rx=[1 0 0;0 cosd(shuttle_angle) -sind(shuttle_angle);0 sind(shuttle_angle) cosd(shuttle_angle)];
Rz=[cosd(roll_angle) -sind(roll_angle) 0; sind(roll_angle) cosd(roll_angle) 0; 0 0 1];

X_Cylinder=[X_Cylinder(1,:) X_Cylinder(2,:)]; Y_Cylinder=[Y_Cylinder(1,:) Y_Cylinder(2,:)]; Z_Cylinder=[Z_Cylinder(1,:) Z_Cylinder(2,:)];

R=[X_Cylinder;Y_Cylinder;Z_Cylinder];

for k=1:(N+1)*2 
    R(:,k)=Rz*R(:,k); R(:,k)=Rx*R(:,k); 
end
    
X_Cylinder=[R(1,1:N+1);R(1,N+2:2*(N+1))]; Y_Cylinder=[R(2,1:N+1);R(2,N+2:2*(N+1))]; Z_Cylinder=[R(3,1:N+1);R(3,N+2:2*(N+1))]; 

X_Cylinder=X_Cylinder+x0; Y_Cylinder=Y_Cylinder+y0; Z_Cylinder=Z_Cylinder+z0;

hSurface=surf(X_Cylinder,Y_Cylinder,Z_Cylinder);
set(hSurface,'FaceColor',[0.9 0.9 0.9],'FaceAlpha',0.8,'linestyle','none');

hold on
%% Fuel bit
SRB_maxfuel=502126.34;

d_fuel=3; N=20; L_cylinder=L_cylinder*SRB_fuellevel/SRB_maxfuel;

[X_Cylinder,Y_Cylinder,Z_Cylinder]=cylinder(d_fuel/2,N);

Z_Cylinder=Z_Cylinder*L_cylinder;

X_Cylinder=X_Cylinder+6.5; % Translates X-components

Rx=[1 0 0;0 cosd(shuttle_angle) -sind(shuttle_angle);0 sind(shuttle_angle) cosd(shuttle_angle)];
Rz=[cosd(roll_angle) -sind(roll_angle) 0; sind(roll_angle) cosd(roll_angle) 0; 0 0 1];

X_Cylinder=[X_Cylinder(1,:) X_Cylinder(2,:)]; Y_Cylinder=[Y_Cylinder(1,:) Y_Cylinder(2,:)]; Z_Cylinder=[Z_Cylinder(1,:) Z_Cylinder(2,:)];

R=[X_Cylinder;Y_Cylinder;Z_Cylinder];

for k=1:(N+1)*2
    R(:,k)=Rz*R(:,k); R(:,k)=Rx*R(:,k);  
end
    
X_Cylinder=[R(1,1:N+1);R(1,N+2:2*(N+1))]; Y_Cylinder=[R(2,1:N+1);R(2,N+2:2*(N+1))]; Z_Cylinder=[R(3,1:N+1);R(3,N+2:2*(N+1))]; 

X_Cylinder=X_Cylinder+x0; Y_Cylinder=Y_Cylinder+y0; Z_Cylinder=Z_Cylinder+z0;

hSurface=surf(X_Cylinder,Y_Cylinder,Z_Cylinder);
set(hSurface,'FaceColor',[0 0 1],'linestyle','none');

%% CONE TOP
d_SRB=3.7; N=20; L_cylinder=3;

[X_Cylinder_E,Y_Cylinder_E,Z_Cylinder_E]=cylinder(d_SRB/2,N);

X_Cylinder_E=X_Cylinder_E+6.5; Z_Cylinder_E=Z_Cylinder_E*L_cylinder+43;

X_Cylinder_E(2,:)=6.5; Y_Cylinder_E(2,:)=0;

X_Cylinder_E=[X_Cylinder_E(1,:) X_Cylinder_E(2,:)]; Y_Cylinder_E=[Y_Cylinder_E(1,:) Y_Cylinder_E(2,:)]; Z_Cylinder_E=[Z_Cylinder_E(1,:) Z_Cylinder_E(2,:)];

Rx=[1 0 0;0 cosd(shuttle_angle) -sind(shuttle_angle);0 sind(shuttle_angle) cosd(shuttle_angle)];
Rz=[cosd(roll_angle) -sind(roll_angle) 0; sind(roll_angle) cosd(roll_angle) 0; 0 0 1];

R=[X_Cylinder_E;Y_Cylinder_E;Z_Cylinder_E];

for k=1:(N+1)*2
    R(:,k)=Rz*R(:,k); R(:,k)=Rx*R(:,k);  
end
    
X_Cylinder_E=[R(1,1:N+1);R(1,N+2:2*(N+1))]; Y_Cylinder_E=[R(2,1:N+1);R(2,N+2:2*(N+1))]; Z_Cylinder_E=[R(3,1:N+1);R(3,N+2:2*(N+1))];    

X_Cylinder_E=X_Cylinder_E+x0; Y_Cylinder_E=Y_Cylinder_E+y0; Z_Cylinder_E=Z_Cylinder_E+z0;

hSurface=surf(X_Cylinder_E,Y_Cylinder_E,Z_Cylinder_E);
set(hSurface,'FaceColor',[0.9 0.9 0.9],'FaceAlpha',0.8,'linestyle','none');

% CONE BOTTOM
d_SRB=3.7; N=20; L_cylinder=3;

[X_Cylinder_E,Y_Cylinder_E,Z_Cylinder_E]=cylinder(d_SRB/2,N);

Y_Cylinder_E(1,:)=Y_Cylinder_E(1,:)*1.5;

X_Cylinder_E=X_Cylinder_E+6.5; Z_Cylinder_E=Z_Cylinder_E*L_cylinder-3;

X_Cylinder_E=[X_Cylinder_E(1,:) X_Cylinder_E(2,:)]; Y_Cylinder_E=[Y_Cylinder_E(1,:) Y_Cylinder_E(2,:)]; Z_Cylinder_E=[Z_Cylinder_E(1,:) Z_Cylinder_E(2,:)];

Rx=[1 0 0;0 cosd(shuttle_angle) -sind(shuttle_angle);0 sind(shuttle_angle) cosd(shuttle_angle)];
Rz=[cosd(roll_angle) -sind(roll_angle) 0; sind(roll_angle) cosd(roll_angle) 0; 0 0 1];

R=[X_Cylinder_E;Y_Cylinder_E;Z_Cylinder_E];

for k=1:(N+1)*2
    R(:,k)=Rz*R(:,k); R(:,k)=Rx*R(:,k);  
end
    
X_Cylinder_E=[R(1,1:N+1);R(1,N+2:2*(N+1))]; Y_Cylinder_E=[R(2,1:N+1);R(2,N+2:2*(N+1))]; Z_Cylinder_E=[R(3,1:N+1);R(3,N+2:2*(N+1))];    

X_Cylinder_E=X_Cylinder_E+x0; Y_Cylinder_E=Y_Cylinder_E+y0; Z_Cylinder_E=Z_Cylinder_E+z0;

hSurface=surf(X_Cylinder_E,Y_Cylinder_E,Z_Cylinder_E);
set(hSurface,'FaceColor',[0.9 0.9 0.9],'linestyle','none');

s=thrust_SRB/11787787.3;

x0_srb=(X_Cylinder_E(1,1)+X_Cylinder_E(1,11))/2; y0_srb=(Y_Cylinder_E(1,1)+Y_Cylinder_E(1,11))/2; z0_srb=(Z_Cylinder_E(1,1)+Z_Cylinder_E(1,11))/2;

draw_arrow(x0_srb,y0_srb,z0_srb,-shuttle_angle,roll_angle,s)
end