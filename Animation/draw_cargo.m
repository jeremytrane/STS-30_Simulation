function []=draw_cargo(x0,y0,z0,shuttle_angle,roll_angle,phi,Thrust_main)
% "draw_cargo" draws the full cargo including the main cylinder, rectangle, nose, thrusters and the arrows showing level of thrust
%Inputs:
%"x0" initial position of x
%"y0" initial position of y
%"z0" initial position of z
%"shuttle_angle" Angle on shuttle to vertical
%"roll_angle" angle through which shuttle has rolled
%"phi" angle of engine thruster
%"Thrust_main" Thrust of one main engine
%
%Version 1
%21/04/2013
%Team 3

if nargin~=7 
    error('Error: Not enough input arguments. Seven input arguments are necessary')
            % Flags an error if there are more or less than 7 input arguments
end

d_shuttle=6; N=20; L_cylinder=27; % Cylinder parameters

[X_Cylinder,Y_Cylinder,Z_Cylinder]=cylinder(d_shuttle/2,N); % Sets up cyclinder

Z_Cylinder=Z_Cylinder*L_cylinder+11; %Increases its length and translate in Z

Y_Cylinder=Y_Cylinder+8.4; % Translates Y-components

Rx=[1 0 0;0 cosd(shuttle_angle) -sind(shuttle_angle);0 sind(shuttle_angle) cosd(shuttle_angle)]; % Sets up rotational matrix about X
Rz=[cosd(roll_angle) -sind(roll_angle) 0; sind(roll_angle) cosd(roll_angle) 0; 0 0 1]; % Sets up rotational matrix about Z

X_Cylinder=[X_Cylinder(1,:) X_Cylinder(2,:)];Y_Cylinder=[Y_Cylinder(1,:) Y_Cylinder(2,:)];Z_Cylinder=[Z_Cylinder(1,:) Z_Cylinder(2,:)];

R=[X_Cylinder;Y_Cylinder;Z_Cylinder]; 

for k=1:(N+1)*2
    R(:,k)=Rz*R(:,k); R(:,k)=Rx*R(:,k); % Rotates matrices
end
    
X_Cylinder=[R(1,1:N+1);R(1,N+2:2*(N+1))];Y_Cylinder=[R(2,1:N+1);R(2,N+2:2*(N+1))];Z_Cylinder=[R(3,1:N+1);R(3,N+2:2*(N+1))]; % Rearranges matrices

X_Cylinder=X_Cylinder+x0;Y_Cylinder=Y_Cylinder+y0;Z_Cylinder=Z_Cylinder+z0; % Translates matrices

hSurface=surf(X_Cylinder,Y_Cylinder,Z_Cylinder);
set(hSurface,'FaceColor',[0.9 0.9 0.9],'linestyle','none');

hold on

% Draw panels

p1=[-3 5.4 11];p2=[-3 5.4 38];p3=[3 5.4 38];p4=[3 5.4 11];p5=[-3 8.4 11];p6=[-3 8.4 38];p7=[3 8.4 38];p8=[3 8.4 11]; % Initialises points

shuttle_angle=-shuttle_angle; roll_angle=-roll_angle; % Resets rotation angles

Rx=[1 0 0;0 cosd(shuttle_angle) -sind(shuttle_angle);0 sind(shuttle_angle) cosd(shuttle_angle)];
Rz=[cosd(roll_angle) -sind(roll_angle) 0; sind(roll_angle) cosd(roll_angle) 0; 0 0 1];

p1=p1*Rz*Rx;p2=p2*Rz*Rx;p3=p3*Rz*Rx;p4=p4*Rz*Rx;p5=p5*Rz*Rx;p6=p6*Rz*Rx;p7=p7*Rz*Rx;p8=p8*Rz*Rx; % Applies rotation

p1=p1+[x0 y0 z0]; p2=p2+[x0 y0 z0]; p3=p3+[x0 y0 z0];p4=p4+[x0 y0 z0];p5=p5+[x0 y0 z0];p6=p6+[x0 y0 z0];p7=p7+[x0 y0 z0];p8=p8+[x0 y0 z0];% Translates point

facematrix=[1 2 6 5;2 3 7 6;3 4 8 7;4 1 5 8;1 2 3 4;5 6 7 8]; % Creates face matrix
vertices=[p1;p2;p3;p4;p5;p6;p7;p8]; % Creates vertice matrix
patch('Vertices',vertices,'Faces',facematrix, 'FaceColor',[0.9 0.9 0.9],'linestyle','none','Tag','UserData');

%% Nose
d_SRB=6; N=20; L_cylinder=4;  % Cylinder parameters

[X_Cylinder_E,Y_Cylinder_E,Z_Cylinder_E]=cylinder(d_SRB/2,N); % Sets up cyclinder

X_Cylinder_E(2,:)=X_Cylinder_E(2,:)*0.5; % Creates truncated cone
Y_Cylinder_E(2,:)=Y_Cylinder_E(2,:)*0.5; % Creates truncated cone

Z_Cylinder_E=Z_Cylinder_E*L_cylinder+38; % Applies length and translates to top of craft

Y_Cylinder_E=Y_Cylinder_E+8.4; % Translates Y-components

X_Cylinder_E=[X_Cylinder_E(1,:) X_Cylinder_E(2,:)];Y_Cylinder_E=[Y_Cylinder_E(1,:) Y_Cylinder_E(2,:)];Z_Cylinder_E=[Z_Cylinder_E(1,:) Z_Cylinder_E(2,:)];

shuttle_angle=-shuttle_angle; roll_angle=-roll_angle; % Resets rotation angles

Rx=[1 0 0;0 cosd(shuttle_angle) -sind(shuttle_angle);0 sind(shuttle_angle) cosd(shuttle_angle)]; % Resets rotation angles
Rz=[cosd(roll_angle) -sind(roll_angle) 0; sind(roll_angle) cosd(roll_angle) 0; 0 0 1]; % Resets rotation angles

R=[X_Cylinder_E;Y_Cylinder_E;Z_Cylinder_E];

for k=1:(N+1)*2 
    R(:,k)=Rz*R(:,k); R(:,k)=Rx*R(:,k); % Applies rotations
end
    
X_Cylinder_E=[R(1,1:N+1);R(1,N+2:2*(N+1))]; Y_Cylinder_E=[R(2,1:N+1);R(2,N+2:2*(N+1))]; Z_Cylinder_E=[R(3,1:N+1);R(3,N+2:2*(N+1))];    

X_Cylinder_E=X_Cylinder_E+x0; Y_Cylinder_E=Y_Cylinder_E+y0; Z_Cylinder_E=Z_Cylinder_E+z0; % Translates coordinates

hSurface=surf(X_Cylinder_E,Y_Cylinder_E,Z_Cylinder_E);
set(hSurface,'FaceColor',[0.1 0.1 0.1],'linestyle','none');

% Nose panel
p1=[-3 5.4 38]; p2=[-1.5 5.4 42]; p3=[1.5 5.4 42]; p4=[3 5.4 38]; p5=[-3 8.4 38]; p6=[-1.5 8.4 42]; p7=[1.5 8.4 42]; p8=[3 8.4 38];

shuttle_angle=-shuttle_angle; roll_angle=-roll_angle; % Resets roll angles

Rx=[1 0 0;0 cosd(shuttle_angle) -sind(shuttle_angle);0 sind(shuttle_angle) cosd(shuttle_angle)];
Rz=[cosd(roll_angle) -sind(roll_angle) 0; sind(roll_angle) cosd(roll_angle) 0; 0 0 1];

p1=p1*Rz*Rx; p2=p2*Rz*Rx; p3=p3*Rz*Rx; p4=p4*Rz*Rx; p5=p5*Rz*Rx; p6=p6*Rz*Rx; p7=p7*Rz*Rx; p8=p8*Rz*Rx; % Rotates points

p1=p1+[x0 y0 z0]; p2=p2+[x0 y0 z0]; p3=p3+[x0 y0 z0]; p4=p4+[x0 y0 z0]; p5=p5+[x0 y0 z0]; p6=p6+[x0 y0 z0]; p7=p7+[x0 y0 z0]; p8=p8+[x0 y0 z0];

facematrix=[1 2 6 5;2 3 7 6;3 4 8 7;4 1 5 8;1 2 3 4;5 6 7 8]; % Creates a face matrix
vertices=[p1;p2;p3;p4;p5;p6;p7;p8];
patch('Vertices',vertices,'Faces',facematrix, 'FaceColor',[0.9 0.9 0.9],'linestyle','none','Tag','UserData');

% Nose cylinder
d_Nose=3; N=20; L_cylinder=3; % Cylinder parameters

[X_Cylinder_E,Y_Cylinder_E,Z_Cylinder_E]=cylinder(d_Nose/2,N); % Creates cylined

Y_temp=Y_Cylinder_E; Y_Cylinder_E=Z_Cylinder_E; Z_Cylinder_E=Y_temp; % Swaps axes

Y_Cylinder_E=Y_Cylinder_E*L_cylinder; % Applies length

Z_Cylinder_E=Z_Cylinder_E+42; % Places cylinder on top of shuttle

Y_Cylinder_E=Y_Cylinder_E+5.4;

X_Cylinder_E=[X_Cylinder_E(1,:) X_Cylinder_E(2,:)]; Y_Cylinder_E=[Y_Cylinder_E(1,:) Y_Cylinder_E(2,:)]; Z_Cylinder_E=[Z_Cylinder_E(1,:) Z_Cylinder_E(2,:)];

shuttle_angle=-shuttle_angle; roll_angle=-roll_angle; % Resets roll angle

Rx=[1 0 0;0 cosd(shuttle_angle) -sind(shuttle_angle);0 sind(shuttle_angle) cosd(shuttle_angle)];
Rz=[cosd(roll_angle) -sind(roll_angle) 0; sind(roll_angle) cosd(roll_angle) 0; 0 0 1];

R=[X_Cylinder_E;Y_Cylinder_E;Z_Cylinder_E];

for k=1:(N+1)*2
    R(:,k)=Rz*R(:,k); R(:,k)=Rx*R(:,k);  % Rotates matrices
end
    
X_Cylinder_E=[R(1,1:N+1);R(1,N+2:2*(N+1))]; Y_Cylinder_E=[R(2,1:N+1);R(2,N+2:2*(N+1))]; Z_Cylinder_E=[R(3,1:N+1);R(3,N+2:2*(N+1))];    

X_Cylinder_E=X_Cylinder_E+x0; Y_Cylinder_E=Y_Cylinder_E+y0; Z_Cylinder_E=Z_Cylinder_E+z0;

hSurface=surf(X_Cylinder_E,Y_Cylinder_E,Z_Cylinder_E);
set(hSurface,'FaceColor',[0.9 0.9 0.9],'linestyle','none');

% sphere
[X_sphere,Y_sphere,Z_sphere]=sphere(20); % Draws sphere

centre=[0 8.4 42]; % Centres at nose of craft

shuttle_angle=-shuttle_angle; roll_angle=-roll_angle; % Resets anles

Rx=[1 0 0;0 cosd(shuttle_angle) -sind(shuttle_angle);0 sind(shuttle_angle) cosd(shuttle_angle)];
Rz=[cosd(roll_angle) -sind(roll_angle) 0; sind(roll_angle) cosd(roll_angle) 0; 0 0 1];

centre=centre*Rz*Rx; % Rotates centre with craft

X_sphere=X_sphere*1.5+centre(1)+x0; Y_sphere=Y_sphere*1.5+centre(2)+y0; Z_sphere=Z_sphere*1.5+centre(3)+z0;

hSurface=surf(X_sphere,Y_sphere,Z_sphere);
set(hSurface,'FaceColor',[0.9 0.9 0.9],'linestyle','none');

%% Thruster 1
d_thrust=2; N=20; L_cylinder=2; % Cylinder parameters

[X_Cylinder_E,Y_Cylinder_E,Z_Cylinder_E]=cylinder(d_thrust/2,N); % Sets up cylinder

X_Cylinder_E(1,:)=X_Cylinder_E(1,:)*1.5; Y_Cylinder_E(1,:)=Y_Cylinder_E(1,:)*1.5; % Creates truncated cone

X_Cylinder_E=[X_Cylinder_E(1,:) X_Cylinder_E(2,:)]; Y_Cylinder_E=[Y_Cylinder_E(1,:) Y_Cylinder_E(2,:)]; Z_Cylinder_E=[Z_Cylinder_E(1,:) Z_Cylinder_E(2,:)];

Z_Cylinder_E=Z_Cylinder_E*L_cylinder; % Applies length

R_thruster=[1 0 0;0 cosd(phi) -sind(phi);0 sind(phi) cosd(phi)]; % Rotates to match thrust angle

R=[X_Cylinder_E;Y_Cylinder_E;Z_Cylinder_E];

for k=1:42
    R(:,k)=R_thruster*R(:,k); % Rotates thruster
end

R(1,:)=R(1,:)+0; R(2,:)=R(2,:)+10.4; R(3,:)=R(3,:)+9; % Translates thruster relative to ship

shuttle_angle=-shuttle_angle; roll_angle=-roll_angle; % Resets angles

Rx=[1 0 0;0 cosd(shuttle_angle) -sind(shuttle_angle);0 sind(shuttle_angle) cosd(shuttle_angle)];
Rz=[cosd(roll_angle) -sind(roll_angle) 0; sind(roll_angle) cosd(roll_angle) 0; 0 0 1];

for k=1:42 
    R(:,k)=Rz*R(:,k); R(:,k)=Rx*R(:,k); % Rotates with craft
end
    
X_Cylinder_E=[R(1,1:N+1);R(1,N+2:2*(N+1))]; Y_Cylinder_E=[R(2,1:N+1);R(2,N+2:2*(N+1))]; Z_Cylinder_E=[R(3,1:N+1);R(3,N+2:2*(N+1))];    

X_Cylinder_E=X_Cylinder_E+x0; Y_Cylinder_E=Y_Cylinder_E+y0; Z_Cylinder_E=Z_Cylinder_E+z0; % Translates thruster

hSurface=surf(X_Cylinder_E,Y_Cylinder_E,Z_Cylinder_E);
set(hSurface,'FaceColor',[0 0 0],'linestyle','none');

%% Thruster 2
d_thrust=2; N=20; L_cylinder=2; % Cylinder parameters

[X_Cylinder_E2,Y_Cylinder_E2,Z_Cylinder_E2]=cylinder(d_thrust/2,N); % Sets up cylinder

X_Cylinder_E2(1,:)=X_Cylinder_E2(1,:)*1.5; Y_Cylinder_E2(1,:)=Y_Cylinder_E2(1,:)*1.5; % Creates truncated cone

X_Cylinder_E2=[X_Cylinder_E2(1,:) X_Cylinder_E2(2,:)]; Y_Cylinder_E2=[Y_Cylinder_E2(1,:) Y_Cylinder_E2(2,:)]; Z_Cylinder_E2=[Z_Cylinder_E2(1,:) Z_Cylinder_E2(2,:)];

Z_Cylinder_E2=Z_Cylinder_E2*L_cylinder; % Applies length

R_thruster=[1 0 0;0 cosd(phi) -sind(phi);0 sind(phi) cosd(phi)]; % Rotates to match thrust angle

R=[X_Cylinder_E2;Y_Cylinder_E2;Z_Cylinder_E2];

for k=1:42
    R(:,k)=R_thruster*R(:,k); % Rotates thruster  
end

R(1,:)=R(1,:)-2; R(2,:)=R(2,:)+7.4; R(3,:)=R(3,:)+9; % Translates thruster  relative to ship

Rx=[1 0 0;0 cosd(shuttle_angle) -sind(shuttle_angle);0 sind(shuttle_angle) cosd(shuttle_angle)];
Rz=[cosd(roll_angle) -sind(roll_angle) 0; sind(roll_angle) cosd(roll_angle) 0; 0 0 1];

for k=1:42 
    R(:,k)=Rz*R(:,k); R(:,k)=Rx*R(:,k); % Rotates with craft 
end
    
X_Cylinder_E2=[R(1,1:N+1);R(1,N+2:2*(N+1))]; Y_Cylinder_E2=[R(2,1:N+1);R(2,N+2:2*(N+1))]; Z_Cylinder_E2=[R(3,1:N+1);R(3,N+2:2*(N+1))];    

X_Cylinder_E2=X_Cylinder_E2+x0; Y_Cylinder_E2=Y_Cylinder_E2+y0; Z_Cylinder_E2=Z_Cylinder_E2+z0; % Translates thruster

hSurface=surf(X_Cylinder_E2,Y_Cylinder_E2,Z_Cylinder_E2);
set(hSurface,'FaceColor',[0 0 0],'linestyle','none');

%% Thruster 3
d_thrust=2; N=20; L_cylinder=2; % Cylinder parameters

[X_Cylinder_E3,Y_Cylinder_E3,Z_Cylinder_E3]=cylinder(d_thrust/2,N); % Sets up cylinder

X_Cylinder_E3(1,:)=X_Cylinder_E3(1,:)*1.5; Y_Cylinder_E3(1,:)=Y_Cylinder_E3(1,:)*1.5; % Creates truncated cone

X_Cylinder_E3=[X_Cylinder_E3(1,:) X_Cylinder_E3(2,:)]; Y_Cylinder_E3=[Y_Cylinder_E3(1,:) Y_Cylinder_E3(2,:)]; Z_Cylinder_E3=[Z_Cylinder_E3(1,:) Z_Cylinder_E3(2,:)];

Z_Cylinder_E3=Z_Cylinder_E3*L_cylinder; % Applies length

R_thruster=[1 0 0;0 cosd(phi) -sind(phi);0 sind(phi) cosd(phi)]; % Rotates to match thrust angle

R=[X_Cylinder_E3;Y_Cylinder_E3;Z_Cylinder_E3];

for k=1:42
    R(:,k)=R_thruster*R(:,k); % Rotates thruster
end

R(1,:)=R(1,:)+2; R(2,:)=R(2,:)+7.4; R(3,:)=R(3,:)+9; % Translates thruster  relative to ship

Rx=[1 0 0;0 cosd(shuttle_angle) -sind(shuttle_angle);0 sind(shuttle_angle) cosd(shuttle_angle)];
Rz=[cosd(roll_angle) -sind(roll_angle) 0; sind(roll_angle) cosd(roll_angle) 0; 0 0 1];

for k=1:42 
    R(:,k)=Rz*R(:,k); R(:,k)=Rx*R(:,k); % Rotates with craft
end
    
X_Cylinder_E3=[R(1,1:N+1);R(1,N+2:2*(N+1))]; Y_Cylinder_E3=[R(2,1:N+1);R(2,N+2:2*(N+1))]; Z_Cylinder_E3=[R(3,1:N+1);R(3,N+2:2*(N+1))];    

X_Cylinder_E3=X_Cylinder_E3+x0; Y_Cylinder_E3=Y_Cylinder_E3+y0; Z_Cylinder_E3=Z_Cylinder_E3+z0; % Translates thruster

hSurface=surf(X_Cylinder_E3,Y_Cylinder_E3,Z_Cylinder_E3);
set(hSurface,'FaceColor',[0 0 0],'linestyle','none');

%% Arrows
s=Thrust_main/2174270; % Used for colouring the arrows relative to max output
%% T1
% Find centre of thruster
x0_1=(X_Cylinder_E(1,1)+X_Cylinder_E(1,11))/2;
y0_1=(Y_Cylinder_E(1,1)+Y_Cylinder_E(1,11))/2;
z0_1=(Z_Cylinder_E(1,1)+Z_Cylinder_E(1,11))/2;

draw_arrow(x0_1,y0_1,z0_1,shuttle_angle-phi,roll_angle+180,s); % Draw arrow there at same angle

%% T2
% Find centre of thruster
x0_2=(X_Cylinder_E2(1,1)+X_Cylinder_E2(1,11))/2;
y0_2=(Y_Cylinder_E2(1,1)+Y_Cylinder_E2(1,11))/2;
z0_2=(Z_Cylinder_E2(1,1)+Z_Cylinder_E2(1,11))/2;
draw_arrow(x0_2,y0_2,z0_2,shuttle_angle-phi,roll_angle+180,s); % Draw arrow there at same angle

%% T3
% Find centre of thruster
x0_3=(X_Cylinder_E3(1,1)+X_Cylinder_E3(1,11))/2;
y0_3=(Y_Cylinder_E3(1,1)+Y_Cylinder_E3(1,11))/2;
z0_3=(Z_Cylinder_E3(1,1)+Z_Cylinder_E3(1,11))/2;
draw_arrow(x0_3,y0_3,z0_3,shuttle_angle-phi,roll_angle+180,s); % Draw arrow there at same angle
end