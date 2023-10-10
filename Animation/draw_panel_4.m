function []=draw_panel_4(p1,p2,p3,p4,R,G,B)
% "draw_panel_3" draws a panel between 4 points: p1, p2, p3, p4.
% Inputs:
%"p1" point 1
%"p2" point 2
%"p3" point 3
%"p4" point 4
%"R" Red, used to colout rocket
%"G" Green, used to colout rocket
%"B"  Blue, used to colout rocket.
%
%Sample Input:
% draw_panel(p1,p2,p3,p4,1,1,0)

%Version 1
%21/04/2013
%Team 3

if nargin~=7 
    error('Error: Not enough input arguments. Seven input arguments are necessary')
            % Flags an error if there are more or less than 7 input arguments
end

vertices=[p1;p2;p3;p4];

facematrix=[1 2 3 4]; % Face matrix for patch

patch('Vertices',vertices,'Faces',facematrix, 'FaceColor',[1 1 1],'linestyle','none','Tag','UserData');
% Draws the surface

view(3); %3D
end