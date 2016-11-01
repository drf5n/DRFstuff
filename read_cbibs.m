function vals = read_cbibs(filename)
%read_cbibs   read datafiles produced by the CBIBS GUI data system
%
%  The CBIBC data has a couple header lines and some mixed quoted date and CSV data
%  vals= textscan(fid,'%*s%*s%*s%{yyyy-M-d HH:mm}D%f','delimiter',',','HeaderLines',3);fclose(fid);
%   For example, 
%
%           vals = read_cbibs('goosesReefDO.csv');
%
%   See also TEXTSCAN


  fid=fopen(filename);
  vals= textscan(fid,'%*s%*s%*s%{yyyy-M-d HH:mm}D%f','delimiter',',','HeaderLines',3);fclose(fid);

