function []=draw_EXT(x0,y0,z0,shuttle_angle,roll_angle,current_fuel_level_main,height_fuel_LO)
% "draw_EXT" draws the external tank of Atlantis including the cylinder and
% ellipsoid for both the tank and the fuel (both liquid hydrogen and liquid
% oxygen)
%Inputs:
%"x0" initial position of x
%"y0" initial position of y
%"z0" initial position of z
%"shuttle_angle" Current shuttle angle
%"roll_angle" Angle of atlantis for roll manoeuvre
%"current_fuel_level_main" The current fuel level in the external tank
%"height_fuel_LO" The height of fuel in the liquid oxygen tank
%
%Sample input:
%draw_EXT(0,0,0,10,0,700000,5)

%Version 1
%21/04/2013
%Team 3

if nargin~=7 
    error('Error: Not enough input arguments. Seven input arguments are necessary')
            % Flags an error if there are more or less than 7 input
            % arguments
end

d_EXT=8.41; N=20; L_cylinder=29.5656;

[X_Cylinder,Y_Cylinder,Z_Cylinder]=cylinder(d_EXT/2,N);

Z_Cylinder=Z_Cylinder*L_cylinder;

Z_Cylinder=Z_Cylinder+11.08; % Translates Z-components

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
set(hSurface,'FaceColor',[0.8548 0.64706 0.12549],'FaceAlpha',0.5,'linestyle','none');

hold on

%% Fuel bit
EXT_maxfuel_LH=735600.13;

d_fuel=8; N=20; L_cylinder=L_cylinder*current_fuel_level_main/EXT_maxfuel_LH;

[X_Cylinder,Y_Cylinder,Z_Cylinder]=cylinder(d_fuel/2,N);

Z_Cylinder=Z_Cylinder*L_cylinder;

Z_Cylinder=Z_Cylinder+11.08; % Translates Z-components

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

%% Ellipsoid
[X_E,Y_E,Z_E]=ellipsoid(0,0,40.65,4.205,4.205,16.64,20);

X_E=[X_E(11,:) X_E(12,:) X_E(13,:) X_E(14,:) X_E(15,:) X_E(16,:) X_E(17,:) X_E(18,:) X_E(19,:) X_E(20,:) X_E(21,:)];
Y_E=[Y_E(11,:) Y_E(12,:) Y_E(13,:) Y_E(14,:) Y_E(15,:) Y_E(16,:) Y_E(17,:) Y_E(18,:) Y_E(19,:) Y_E(20,:) Y_E(21,:)];
Z_E=[Z_E(11,:) Z_E(12,:) Z_E(13,:) Z_E(14,:) Z_E(15,:) Z_E(16,:) Z_E(17,:) Z_E(18,:) Z_E(19,:) Z_E(20,:) Z_E(21,:)];

RE=[X_E;Y_E;Z_E];

for k=1:231
    RE(:,k)=Rz*RE(:,k); RE(:,k)=Rx*RE(:,k);  
end

X_E=[RE(1,1:21); RE(1,22:42); RE(1,43:63); RE(1,64:84); RE(1,85:105); RE(1,106:126); RE(1,127:147); RE(1,148:168); RE(1,169:189); RE(1,190:210); RE(1,211:231)];
Y_E=[RE(2,1:21);RE(2,22:42);RE(2,43:63);RE(2,64:84);RE(2,85:105);RE(2,106:126);RE(2,127:147);RE(2,148:168);RE(2,169:189);RE(2,190:210);RE(2,211:231)];
Z_E=[RE(3,1:21);RE(3,22:42);RE(3,43:63);RE(3,64:84);RE(3,85:105);RE(3,106:126);RE(3,127:147);RE(3,148:168);RE(3,169:189);RE(3,190:210);RE(3,211:231)];

X_E=X_E+x0; Y_E=Y_E+y0; Z_E=Z_E+z0;

hSurface=surf(X_E,Y_E,Z_E);
set(hSurface,'FaceColor',[0.8548 0.64706 0.12549],'FaceAlpha',0.5,'linestyle','none');

%% Ellipsoid fuel LOH
if height_fuel_LO>3
[X_EO,Y_EO,Z_EO]=ellipsoid(0,0,40.65,4.205,4.205,16.64,20);

X_EO=[X_EO(11,:) X_EO(12,:) X_EO(13,:) X_EO(14,:) X_EO(15,:) X_EO(16,:) X_EO(17,:) X_EO(18,:) X_EO(19,:) X_EO(20,:) X_EO(21,:)];
Y_EO=[Y_EO(11,:) Y_EO(12,:) Y_EO(13,:) Y_EO(14,:) Y_EO(15,:) Y_EO(16,:) Y_EO(17,:) Y_EO(18,:) Y_EO(19,:) Y_EO(20,:) Y_EO(21,:)];
Z_EO=[Z_EO(11,:) Z_EO(12,:) Z_EO(13,:) Z_EO(14,:) Z_EO(15,:) Z_EO(16,:) Z_EO(17,:) Z_EO(18,:) Z_EO(19,:) Z_EO(20,:) Z_EO(21,:)];

d=0;

for l=1:231
    if Z_EO(l)<height_fuel_LO+40.65 
        d=d+1; 
    end   
end

X_EO=X_EO(1,1:d); Y_EO=Y_EO(1,1:d); Z_EO=Z_EO(1,1:d);

R=[X_EO;Y_EO;Z_EO];

for k=1:1:d
    R(:,k)=Rz*R(:,k); R(:,k)=Rx*R(:,k); 
end

row_number=d/21;

X_EO=zeros(row_number,21); Y_EO=zeros(row_number,21); Z_EO=zeros(row_number,21);

X_EO(1,:)=R(1,1:21); Y_EO(1,:)=R(2,1:21); Z_EO(1,:)=R(3,1:21);

for m=2:row_number
X_EO(m,:)=[R(1,21*(m-1)+1:m*21)];Y_EO(m,:)=[R(2,21*(m-1)+1:m*21)];Z_EO(m,:)=[R(3,21*(m-1)+1:m*21)];
end
X_EO=X_EO+x0; Y_EO=Y_EO+y0;Z_EO=Z_EO+z0;

hSurface=surf(X_EO,Y_EO,Z_EO);
set(hSurface,'FaceColor',[0 0 1],'linestyle','none');
end
end