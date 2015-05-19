function [id,status]=gitdescribe(thing);
% GITDESCRIBE  Cfinds the indices of x that are closest to the point x0.
%function [index,distance]=near(x,x0,[n]);
%     x is an array, x0 is a point, n is the number of closest points to get
%     (in order of increasing distance).  Distance is the abs(x-x0)
% rsignell@usgs.gov

%

% David Forrest <drf@vims.edu>
% 2015-03-12

thing_path = which(thing);
fpath = fileparts(thing_path);
id = '';
status = '';

if (which(thing))
  % git information
  try
    [retval,id]= system(sprintf('cd %s ; git describe --tags',fpath));
    [retval,status]= system(sprintf('cd %s ;git status',fpath));
  catch ME
    disp(sprintf('No repository found in %s not found' ,fpath));
  end
else
   disp(sprintf('%s not found' ,fpath));
end


