function []=draw_wing(x0,y0,z0,shuttle_angle,roll_angle)
% "draw_wings" draws the left and right wings and fin for the shuttle of
% Atlantis
%Inputs:
%"x0" initial position of x
%"y0" initial position of y
%"z0" initial position of z
%"shuttle_angle" Current shuttle angle
%"roll_angle" Angle of Atlantis during the roll manoeuvre

%Version 1
%21/04/2013
%Team 3

if nargin~=5 
    error('Error: Not enough input arguments. Five input arguments are necessary')
            % Flags an error if there are more or less than 5 input arguments
end

shuttle_angle=-shuttle_angle; roll_angle=-roll_angle;

Rx=[1 0 0;0 cosd(shuttle_angle) -sind(shuttle_angle);0 sind(shuttle_angle) cosd(shuttle_angle)];
Rz=[cosd(roll_angle) -sind(roll_angle) 0; sind(roll_angle) cosd(roll_angle) 0; 0 0 1];

wingspan=23.69;

%% LEFT WING
p1_L=[-wingspan/2 5.4 10];p2_L=[-wingspan/2 5.4 11];p3_L=[-((wingspan/2)-1) 5.4 14];p4_L=[-5.66 5.4 24];p5_L=[-3 5.4 38];p6_L=[-3 5.4 11]; 
p7_L=[-wingspan/2 5.4 10];p8_L=[-wingspan/2 5.6 11];p9_L=[-((wingspan/2)-1) 5.7 14];p10_L=[-5.66 5.7 24];p11_L=[-3 5.9 38];p12_L=[-3 5.7 11]; 

p1_L=p1_L*Rz; p2_L=p2_L*Rz; p3_L=p3_L*Rz; p4_L=p4_L*Rz; p5_L=p5_L*Rz; p6_L=p6_L*Rz;
p7_L=p7_L*Rz; p8_L=p8_L*Rz; p9_L=p9_L*Rz; p10_L=p10_L*Rz; p11_L=p11_L*Rz; p12_L=p12_L*Rz;

p1_L=p1_L*Rx; p2_L=p2_L*Rx; p3_L=p3_L*Rx; p4_L=p4_L*Rx; p5_L=p5_L*Rx; p6_L=p6_L*Rx;
p7_L=p7_L*Rx; p8_L=p8_L*Rx; p9_L=p9_L*Rx; p10_L=p10_L*Rx; p11_L=p11_L*Rx; p12_L=p12_L*Rx;

p1_L=p1_L+[x0 y0 z0];p2_L=p2_L+[x0 y0 z0];p3_L=p3_L+[x0 y0 z0];p4_L=p4_L+[x0 y0 z0];p5_L=p5_L+[x0 y0 z0];p6_L=p6_L+[x0 y0 z0];
p7_L=p7_L+[x0 y0 z0];p8_L=p8_L+[x0 y0 z0];p9_L=p9_L+[x0 y0 z0];p10_L=p10_L+[x0 y0 z0];p11_L=p11_L+[x0 y0 z0];p12_L=p12_L+[x0 y0 z0];

draw_panel_4(p1_L,p2_L,p8_L,p7_L,0,0,0); % Black

hold on

%sets panels balck
draw_panel_4(p2_L,p3_L,p9_L,p8_L,0,0,0); draw_panel_4(p3_L,p4_L,p10_L,p9_L,0,0,0); draw_panel_4(p4_L,p5_L,p11_L,p10_L,0,0,0);
draw_panel_4(p5_L,p6_L,p12_L,p11_L,0,0,0); draw_panel_4(p6_L,p1_L,p7_L,p12_L,1,1,1); % White

draw_panel_6(p1_L,p2_L,p3_L,p4_L,p5_L,p6_L,0.9,0.9,0.9); % White
draw_panel_6(p7_L,p8_L,p9_L,p10_L,p11_L,p12_L,0.9,0.9,0.9); % White

%% RIGHT WING
p1_R=[wingspan/2 5.4 10]; p2_R=[wingspan/2 5.4 11]; p3_R=[((wingspan/2)-1) 5.4 14]; p4_R=[5.66 5.4 24]; p5_R=[3 5.4 38]; p6_R=[3 5.4 11]; 
p7_R=[wingspan/2 5.4 10]; p8_R=[wingspan/2 5.6 11]; p9_R=[((wingspan/2)-1) 5.7 14]; p10_R=[5.66 5.7 24]; p11_R=[3 5.9 38]; p12_R=[3 5.7 11]; 

p1_R=p1_R*Rz; p2_R=p2_R*Rz; p3_R=p3_R*Rz; p4_R=p4_R*Rz; p5_R=p5_R*Rz; p6_R=p6_R*Rz;
p7_R=p7_R*Rz; p8_R=p8_R*Rz; p9_R=p9_R*Rz; p10_R=p10_R*Rz; p11_R=p11_R*Rz; p12_R=p12_R*Rz;

p1_R=p1_R*Rx; p2_R=p2_R*Rx; p3_R=p3_R*Rx; p4_R=p4_R*Rx; p5_R=p5_R*Rx; p6_R=p6_R*Rx;
p7_R=p7_R*Rx; p8_R=p8_R*Rx; p9_R=p9_R*Rx;p10_R= p10_R*Rx; p11_R=p11_R*Rx; p12_R=p12_R*Rx;

p1_R=p1_R+[x0 y0 z0];p2_R=p2_R+[x0 y0 z0];p3_R=p3_R+[x0 y0 z0];p4_R=p4_R+[x0 y0 z0];p5_R=p5_R+[x0 y0 z0];p6_R=p6_R+[x0 y0 z0];
p7_R=p7_R+[x0 y0 z0];p8_R=p8_R+[x0 y0 z0];p9_R=p9_R+[x0 y0 z0];p10_R=p10_R+[x0 y0 z0];p11_R=p11_R+[x0 y0 z0];p12_R=p12_R+[x0 y0 z0];

draw_panel_4(p1_R,p2_R,p8_R,p7_R,0,0,0); % Black

draw_panel_4(p1_R,p2_R,p8_R,p7_R,0,0,0); % Black
hold on

%set panels black
draw_panel_4(p2_R,p3_R,p9_R,p8_R,0,0,0); draw_panel_4(p3_R,p4_R,p10_R,p9_R,0,0,0); draw_panel_4(p4_R,p5_R,p11_R,p10_R,0,0,0);
draw_panel_4(p5_R,p6_R,p12_R,p11_R,0,0,0); draw_panel_4(p6_R,p1_R,p7_R,p12_R,0.9,0.9,0.9);

draw_panel_6(p1_R,p2_R,p3_R,p4_R,p5_R,p6_R,0.9,0.9,0.9); % White
draw_panel_6(p7_R,p8_R,p9_R,p10_R,p11_R,p12_R,0.9,0.9,0.9); % White

%% TOP FIN
p1_T=[-0.25 11.4 15];p2_T=[-0.25 11.4 11];p3_T=[0.25 11.4 11];p4_T=[0.25 11.4 15];
p5_T=[-0.25 16.4 11];p6_T=[-0.25 16.4 8.5];p7_T=[0.25 16.4 8.5];p8_T=[0.25 16.4 11];

p1_T=p1_T*Rz*Rx;p2_T=p2_T*Rz*Rx;p3_T=p3_T*Rz*Rx;p4_T=p4_T*Rz*Rx;
p5_T=p5_T*Rz*Rx;p6_T=p6_T*Rz*Rx;p7_T=p7_T*Rz*Rx;p8_T=p8_T*Rz*Rx;

p1_T=p1_T+[x0 y0 z0];p2_T=p2_T+[x0 y0 z0];p3_T=p3_T+[x0 y0 z0];p4_T=p4_T+[x0 y0 z0];
p5_T=p5_T+[x0 y0 z0];p6_T=p6_T+[x0 y0 z0];p7_T=p7_T+[x0 y0 z0];p8_T=p8_T+[x0 y0 z0];

% panels set grey
draw_panel_4(p1_T,p2_T,p6_T,p5_T,0.9,0.9,0.9); draw_panel_4(p2_T,p3_T,p7_T,p6_T,0.9,0.9,0.9); draw_panel_4(p3_T,p4_T,p8_T,p7_T,0.9,0.9,0.9);
draw_panel_4(p4_T,p1_T,p5_T,p8_T,0.9,0.9,0.9); draw_panel_4(p5_T,p6_T,p7_T,p8_T,0.9,0.9,0.9); 
end