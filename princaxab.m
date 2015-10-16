function [majmin]=princaxtheta(z);
% princaxtheta -- angle of major axis from princax
%
% Usage:  dnums=yyyymmdd2datenum(yyyymmdd);
%
%    Inputs:  degrees = decimal degrees
%             ndigit  = number of decimal places for minutes
%
%    Outputs: degstring = matlab datenums
%
%    Example:
%
%       x=[19610807;20001112.131415123;20150417.235959003;20001358.486060];
%       datestr(yyyymmdd2datenum(x),'dd-mmm-yyyy HH:MM:SS.FFF')
%
% % ans =
% %
% % 07-Aug-1961 00:00:00.000
% % 12-Nov-2000 13:14:15.121
% % 17-Apr-2015 23:59:59.004
% % 01-Mar-2001 01:01:00.000

%
% Please note that there is no bounds checking on the month, year, hour, minute, second components passed into datenum() so 
% out-of-bound numbers may produce unexpected behavior.
%
[theta, maj, min, wr] = princax(z);



majmin = complex(maj,real(min));

