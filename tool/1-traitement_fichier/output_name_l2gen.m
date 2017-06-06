function [ nom_arrive ] = output_name_l2gen( nom_depart )
% output_name_l2gen est une fonction qui permet de respecter la nomenclature des
% donnees de la NASA. Cette fonction est a modifier si on utilise une autre
% fonction seaDAS, differente de l2gen
%
% ENTREE
%   nom_depart
%
% SORTIE
%   nom_arrive
%
% EXEMPLE
% nom_depart = 'COMS_GOCI_L1B_GA_20130219041642.he5'
% nom_arrive = 'G2013529041642.L2_LAC_OC'




[pathstr,name,ext] = fileparts(nom_depart);
if isempty(name) 
    name = nom_depart;
end%if
C = strsplit(name,'_');
date_complette = C(end);
date_complette = date_complette{:};
Y = str2double(date_complette(1:4));
M = str2double(date_complette(5:6));
D = str2double(date_complette(7:8));
HMNS = str2double(date_complette(9:end));

n = datenum(Y,M,D) - datenum(Y,0,0);
n = sprintf('%03d',n); % 2->002, 22->022, 222->222
HMNS = sprintf('%06d',HMNS); 


if strcmp(C(3),'L1B') || strcmp(C(4),'L1B')
    end_output = '.L2_LAC_OC';
end%if
if strcmp(C(1),'COMS') || strcmp(C(2),'COMS') 
    stat_output = 'G';
end%if

nom_arrive = strcat(stat_output,num2str(Y),n,num2str(HMNS),end_output);


end

