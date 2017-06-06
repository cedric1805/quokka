function data = nc_read(filename,varget)
% path='/Volumes/HDYHUOT/Data2/Data_MODIS_aqua_BOUSSOLE/data'
if nargin >1
    varget=varget;
else
    varget={};
end
% cd(path)
% filename='A2007018122500.L2_LAC_OC.x.nc';
ncid = netcdf.open(filename,'NC_NOWRITE');
grpsid=netcdf.inqGrps(ncid);
%going through the groups
data.filename=filename;

%reading global attributes
[a,b,natts,c] = netcdf.inq(ncid);

for iglobatt=0:natts-1
    global_att_name = netcdf.inqAttName(ncid,netcdf.getConstant('NC_GLOBAL'),iglobatt);
    global_att_value = netcdf.getAtt(ncid, netcdf.getConstant('NC_GLOBAL'),global_att_name);
    data.globatt.(global_att_name)=  global_att_value;
end
%reading the rest of the file
for ii=1:length(grpsid)
    groupName = netcdf.inqGrpName(grpsid(ii));
    %going through the variables
    varids = netcdf.inqVarIDs(grpsid(ii));
    for ivar=1:length(varids)
        [varname, a, b, atts] = netcdf.inqVar(grpsid(ii),varids(ivar));
        if ~isempty(varget) %case when only a few variables are read,this isn't the fastest way to do this, but fast enough
            if any(strcmp(varget,varname))              
                data.(groupName).(varname).data=ncread(filename,['/' groupName '/' varname]); %using ncread applies all the scale factor and add offset
                for iatt = 0:atts-1
                    attname = netcdf.inqAttName(grpsid(ii),varids(ivar),iatt);
                    attrvalue = netcdf.getAtt(grpsid(ii),varids(ivar),attname);
                    data.(groupName).(varname).(regexprep(attname,'_',''))=attrvalue;
                end
            end
            
        else
            data.(groupName).(varname).data=ncread(filename,['/' groupName '/' varname]); %using ncread applies all the scale factor and add offset
            for iatt = 0:atts-1
                attname = netcdf.inqAttName(grpsid(ii),varids(ivar),iatt);
                attrvalue = netcdf.getAtt(grpsid(ii),varids(ivar),attname);
                data.(groupName).(varname).(regexprep(attname,'_',''))=attrvalue;
            end
        end
    end
end
netcdf.close(ncid);