%% patch2obj
% Below is a demonstration of the features of the |patch2obj| function

%%
clear; close all; clc;

%% Syntax
% |patch2obj(objFileName,F,V);|
% |patch2obj(objFileName,F,V,C);|
% |patch2obj(objFileName,F,V,C,cMap);|
% |patch2obj(objFileName,F,V,C,cMap,cLim);|
% |patch2obj(objFileName,F,V,C,cMap,cLim,mtlStruct);|

%% Description
% This function exports the patch data defined by the faces (F), vertices
% (V) and the color data (C) to the OBJ (Wavefront .obj) format. The
% function generates a .obj file, a .mtl file, and a .jpg image file. The
% .obj file contains the geometry information and texture/color coordinates
% to use. The .mtl file contains the material information and refers to the
% image to use to look up the colors based on the texture coordinates in
% the .obj file. 
% The color data C should ideally define either the vertex or face colors
% in the form of an nx1 array. If face colors are provided these are
% re-sampled (averaged) to vertex colors which is the required format for
% OBJ files. Colors are obtained from the input color map as well as the
% color limits. The input structure mtlStruct defines the MTL file
% components. With the default entries: 
%
% mtlStruct.Ka=[1 1 1]; %Ambient color
% mtlStruct.Kd=[1 1 1]; %Diffuse color
% mtlStruct.Ks=[0 0 0]; %Specular color, black=off
% mtlStruct.Ns=0; %Specular component [0-1000]
% mtlStruct.Ni=1.45; %Optical density/index of refraction
% mtlStruct.d=1; %"dissolved"/transparancy [0-1]
% mtlStruct.Tr=0; %1 - d, used instead of d by some software
% mtlStruct.illum=1; %Illumination model
%
% Illumination models:
% 0. Color on and Ambient off
% 1. Color on and Ambient on
% 2. Highlight on
% 3. Reflection on and Ray trace on
% 4. Transparency: Glass on, Reflection: Ray trace on
% 5. Reflection: Fresnel on and Ray trace on
% 6. Transparency: Refraction on, Reflection: Fresnel off and Ray trace on
% 7. Transparency: Refraction on, Reflection: Fresnel on and Ray trace on
% 8. Reflection on and Ray trace off
% 9. Transparency: Glass on, Reflection: Ray trace off
% 10. Casts shadows onto invisible surfaces
%
%
% For more information on the OBJ file format see: 
% https://en.wikipedia.org/wiki/Wavefront_.obj_file
% http://paulbourke.net/dataformats/obj/minobj.html

%% EXAMPLES

clear; close all; clc;

%% Example 1: Export colored patch data to the OBJ format

%Define patch data 
testCase=1;
switch testCase
    case 1
        [F,V]=graphicsModels(9);
        t=V(:,1)-min(V(:,1));
        t=t./max(t(:));               
        C=sin(2*t*2*pi);
        C=abs(C);
    case 2
        [X,Y,Z]=peaks(25);
        [F,V,~]=grid2patch(X,Y,Z,Z);
        C=V(:,3);
end

%Define colormap
cMap=gjet(250);

%Define file name
gibbonFolder = fileparts(fileparts(mfilename('fullpath')));
savePath=fullfile(gibbonFolder,'data','OBJ');

fileName=fullfile(savePath,'test.obj');

%% 
% Visualiza patch data 

cFigure; hold on; 
title('MATLAB patch','FontSize',25);
hp=gpatch(F,V,C,'none'); hp.FaceColor='interp';
axisGeom;
colormap(cMap);
camlight headlight;
gdrawnow;

%% 
% Export to obj

patch2obj(fileName,F,V,C,cMap);

%%
