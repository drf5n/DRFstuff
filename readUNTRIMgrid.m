function gridobj = readUNTRIMgrid(gridfile,zone)
%% readUNTRIMgrid -- read in a untrim-type grid and return grid structure
% The structure would contain nodes, elements and other metadata
% gridfile is a untrim format gridfile
% zone is a UTM zone for translating the data from UTM to lon/lat
%   If zone <1 or > 60, then to uTM translation is performed
% 
%
%% example
% filename = '/Users/drf/2015/PROJECTS/HoustonIke/DATA/untrim_new2014utm15nlandSG10v7squaregrid.grd';
% ug = readUNTRIMgrid(filename)
% size(ug.x)
%
%Depends on read_namelist from
% http://www.mathworks.com/matlabcentral/fileexchange/30292-fortran-namelist-suite
% and utm2ell from the getodetic toolbox http://de.mathworks.com/matlabcentral/fileexchange/15285-geodetic-toolbox
%

disp(gridfile);

gridobj.source=gridfile;
gridobj.x=1:10;

fh = fopen(gridfile);
if fh == -1
    error('DF:readUNTRIMgrid','no such file as %s',gridfile)
end
gridobj.nml=read_namelist(gridfile,'GRD_2008');
if ~ isfield (gridobj.nml,'nv')
    error('DF:readUNTRIMgrid','no NV read from ',gridfile)
end


C = textscan(fh,'%d%f%f',gridobj.nml.nv,'headerlines',length(fieldnames(gridobj.nml))+2);

gridobj.x=C{2};
gridobj.y=C{3};

if (0 <= zone && zone <= 60 ) % can do UTM
    [gridobj.lat,gridobj.lon] = utm2ell(gridobj.y,gridobj.x,zone);
    gridobj.lat = rad2deg(gridobj.lat);
    gridobj.lon = rad2deg(gridobj.lon);
else
    [gridobj.lat,gridobj.lon] = [gridobj.y,gridobj.x];
end

% elements
C = textscan(fh,'%d%d%f%f%d%d%d%d',gridobj.nml.ne,'headerlines',length(fieldnames(gridobj.nml))+2);

gridobj.ele=[C{5:8}];
gridobj.nele=[C{2}];
% sides:
%            1           5976           5977              1              2

C = textscan(fh,'%d%d%d%d%d',gridobj.nml.ne,'headerlines',length(fieldnames(gridobj.nml))+2);

gridobj.sidenodes=[C{2:3}];
gridobj.sideels=[C{4:5}];

fclose(fh);

end


