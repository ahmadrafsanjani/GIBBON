%% polythick
% Below is a demonstration of the features of the |polythick| function

%%
clear; close all; clc;

%% Syntax
% |[Xu Yu Xl Yl]=polythick(x,y,t);|

%% Description 
% The polythick function can be used to thicken a polygon by a desired
% thickness. The output is a curve 0.5 x the thickness above and below the
% curve. The directions above and below refer to the curve normal

%% Examples 

clear; close all; clc; 

%%
% Creating an example polygon
x=linspace(0,2*pi,25);
y=sin(x);

cFigure; hold on;
plot(x,y,'b-');
axisGeom; view(2);

%%
polyThickness=0.2; 
[Xu Yu Xl Yl]=polythick(x,y,polyThickness);

plot(Xu,Yu,'g-');
plot(Xl,Yl,'r-');

%%
% 
% <<gibbVerySmall.gif>>
% 
% _*GIBBON*_ 
% <www.gibboncode.org>
% 
% _Kevin Mattheus Moerman_, <gibbon.toolbox@gmail.com>
