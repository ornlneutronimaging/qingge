%% Import Script for PoleFigure Data
%
% This script was automatically created by the import wizard. You should
% run the whoole script or parts of it in order to import your data. There
% is no problem in making any changes to this script.

%% Specify Crystal and Specimen Symmetries

% crystal symmetry
CS = symmetry('cubic');

% specimen symmetry
SS = symmetry('triclinic');
% SS = symmetry('orthorhombic');

% plotting convention
setMTEXpref('xAxisDirection','east');
setMTEXpref('zAxisDirection','outOfPlane');

%% Specify File Names

% path to files
pname = '/SNS/users/qx2/Desktop/LDRD/Texture of EQ9A (undeformed)';

% which files to be imported
fname = [pname '/VULCAN.rpf'];

%% Specify Miller Indice

h = { ...
  Miller(1,1,1,CS),...
  Miller(2,0,0,CS),...
  Miller(2,2,0,CS),...
  Miller(3,1,1,CS),...
  };

%% Import the Data

% create a Pole Figure variable containing the data
pf = loadPoleFigure(fname,h,CS,SS,'interface','siemens',...
  'wizard');

%% Correct Data

rot = rotation('Euler',0*degree,0*degree,0*degree);
pf = rotate(pf,rot);
