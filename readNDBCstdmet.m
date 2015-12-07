function obj = readNDBCstdmet(fn)
% read an NDBC wind file like those from ....

%#YY  MM DD hh mm WDIR WSPD GST  WVHT   DPD   APD MWD   PRES  ATMP  WTMP  DEWP  VIS  TIDE
%#yr  mo dy hr mn degT m/s  m/s     m   sec   sec deg    hPa  degC  degC  degC  nmi    ft
%2008 01 01 00 00  93  1.4  1.7 99.00 99.00 99.00 999 9999.0 999.0  16.7 999.0 99.0 99.00


obj = readtable(fn,'readVariableNames',false, 'format',...
                '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f', 'HeaderLines',2);

obj.Properties.VariableNames=strsplit(['YY  MM DD hh mm WDIR WSPD ' ...
                    'GST  WVHT   DPD   APD MWD   PRES  ATMP  WTMP  DEWP  VIS  TIDE'],' ');


obj.Properties.Description= fn;
obj.time=datenum(obj.YY,obj.MM,obj.DD,obj.hh,obj.mm,0);
obj.Properties.UserData=struct('filename',fn);
obj.Properties.VariableUnits=strsplit(['year month day hr min degT m/s  m/s     m   sec   ' ...
                    'sec deg    hPa  degC  degC  degC  nmi    ft ' ...
                    'datenum']);

obj.PRES(obj.PRES == 9999.0) = nan;
obj.WSPD(obj.WSPD == 99.0) = nan;
obj.WDIR(obj.WDIR == 999) = nan;
obj.GST(obj.GST == 99.0) = nan;
obj.WVHT(obj.WVHT == 99.0) = nan;
obj.TIDE(obj.TIDE == 99.0) = nan;
obj(:,[1:5]) =[];

