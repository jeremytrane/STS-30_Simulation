function []=draw_panel_6(p1,p2,p3,p4,p5,p6,R,G,B)
% "draw_panel_5" draws a panel between 6 points: p1, p2, p3, p4, p5, p6.
% Inputs:
%"p1" point 1
%"p2" point 2
%"p3" point 3
%"p4" point 4
%"p5" point 5
%"p6" point 6
%"R" Red, used to colout rocket
%"G" Green, used to colout rocket
%"B"  Blue, used to colout rocket.
%
%Sample Input:
% draw_panel(p1,p2,p3,p4,p5,p6,1,1,0)

%Version 1
%21/04/2013
%Team 3

if nargin~=9 
    error('Error: Not enough input arguments. Nine input arguments are necessary')
            % Flags an error if there are more or less than 9 input arguments
end

vertices=[p1;p2;p3;p4;p5;p6];

facematrix=[1 2 3 4 5 6]; % Face matrix for patch

patch('Vertices',vertices, 'Faces',facematrix, 'FaceColor',[R G B],'linestyle','none','Tag','UserData');
% Draws the surface

view(3); %3D
end