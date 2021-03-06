function export_VPSC(odf,filename,varargin)
% export an ODF to the VPSC format
%
%% Syntax
% export_VPSC(odf,'file.txt','points',points)
%
%% Input
%  odf      - ODF to be exported
%  filename - name of the ascii file
%
%% Options
%  points    - number of orientations
%
%% See also
% ODFImportExport
  
% get number of points
points = get_option(varargin,'points',5000);

% simulate EBSD
ebsd = calcEBSD(odf,points,varargin{:});

% export EBSD
export_VPSC(ebsd,filename,varargin{:});
