function [ index_mask,n ] = index_flagMask( filename,  name_flag)
% index_flagMask : Fonction qui renvoie l'index d'un flag particulier.
% Pour connaitre le nom des flag, se ramener a ncdisp(filename).
%
% ENTREE
%   filename : nom du fichier L2
%   name_flag : nom du flag
%
% SORTIE
%   index_mask : index du mask a etudier
%   n : nombre de mask dans le flag
%
% EXEMPLE
%   filename : cell_name_traitees{1,1}
%   name_flag : 'CLDICE'
%
%   index_mask : 10
%   n : 32
%   value_mask : 512

ncid = netcdf.open(filename,'nowrite');
gid = netcdf.inqNcid(ncid,'geophysical_data');
varid = netcdf.inqVarID(gid,'l2_flags');
flag_meanings = netcdf.getAtt(gid,varid,'flag_meanings');
C = strsplit(flag_meanings,' ');
n = length(C); % nombre de mask
index = find(strcmp(C,name_flag));

% flag_masks = netcdf.getAtt(gid,varid,'flag_masks');
% value_mask = flag_masks(index);
index_mask = index;
netcdf.close(ncid);

