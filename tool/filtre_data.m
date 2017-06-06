function [ data_filtree ] = filtre_data( full_name,variable_name )
%filtre_data Summary of this function goes here
%   Detailed explanation goes here

data_filtree = ncread(full_name,strcat('geophysical_data','/',variable_name)); % brute sans filtrage

% Parametres filtrage flag
name_flag = 'CLDICE'; % nuage
operation_morpho = 'dilate';
[ index_mask,nbre_mask ] = index_flagMask( full_name, name_flag);

[ m_nuage] = filtreNuage_delta(full_name,operation_morpho,index_mask,nbre_mask);
[ m_stat ] = filtreStat_delta( full_name,variable_name);

% application du filtre
m_filtre = m_nuage + m_stat; % nan correspond au pixels non traitable 
data_filtree(isnan(m_filtre)) = NaN;

end

