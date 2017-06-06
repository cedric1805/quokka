function [ lon,lat,data,M_lon,M_lat,M_data ] = analyse_indiv( filename,variable_name,num_slot,C_FiltrageSlot )
% Analyse_indiv Summary of this function goes here
%   Detailed explanation goes here

% Parametres filtrage flag
name_flag = 'CLDICE'; % nuage
operation_morpho = 'dilate';
[ index_mask,nbre_mask ] = index_flagMask( filename, name_flag);


% recuperation lat lon data dans le slot specifique 
index = find(C_FiltrageSlot{2} == num_slot);
coord_slot = [C_FiltrageSlot{end-3}(index), C_FiltrageSlot{end-2}(index), C_FiltrageSlot{end-1}(index), C_FiltrageSlot{end}(index)];
lon_GOCI = ncread(filename,'navigation_data/longitude') ; 
lon = lon_GOCI( coord_slot(1) : coord_slot(2) , coord_slot(3) : coord_slot(4) );
lat_GOCI = ncread(filename,'navigation_data/latitude') ; 
lat = lat_GOCI( coord_slot(1) : coord_slot(2) , coord_slot(3) : coord_slot(4) );

if strcmp( variable_name,'bbp_555_qqa_v5')
    fprintf('bbp_555_qqa_v5\n')
    
    RRS_ref = ncread(filename,strcat('geophysical_data','/','Rrs_555'));
    RRS_ref = RRS_ref( coord_slot(1) : coord_slot(2) , coord_slot(3) : coord_slot(4) );
    RRS_443 = ncread(filename,strcat('geophysical_data','/','Rrs_443'));
    RRS_443 = RRS_443( coord_slot(1) : coord_slot(2) , coord_slot(3) : coord_slot(4) );
    RRS_490 = ncread(filename,strcat('geophysical_data','/','Rrs_490'));
    RRS_490 = RRS_490( coord_slot(1) : coord_slot(2) , coord_slot(3) : coord_slot(4) );
    RRS_667 = ncread(filename,strcat('geophysical_data','/','Rrs_660'));
    RRS_667 = RRS_667( coord_slot(1) : coord_slot(2) , coord_slot(3) : coord_slot(4) );
    wave_ref = 555;
    aw = 0.0596; %d'apres M. Pope and Edward S. Fry
    bbp_lambda_0 = bbp_ref_QAA( RRS_ref,RRS_443,RRS_490,RRS_667,wave_ref,aw );
    bbp_lambda_0(imag(bbp_lambda_0) ~= 0) = NaN; % filtrer valeurs complexes
    
    data_slot_GOCI = bbp_lambda_0;
else
   

    %--------------------------------------------------------------------------
    % Traitement SeaDAS
    data_brute_GOCI = ncread(filename,strcat('geophysical_data','/',variable_name));
    data_slot_GOCI = data_brute_GOCI(coord_slot(1):coord_slot(2) , coord_slot(3):coord_slot(4));
    %--------------------------------------------------------------------------
end%if 


%--------------------------------------------------------------------------
% filtrage des data
% etape 1  : filtrage nuage dans portion slot
m_nuage = filtreNuage( filename, num_slot,C_FiltrageSlot,operation_morpho,index_mask,nbre_mask  );
% etape 2  : filtrage stat
m_stat = filtreStat( filename,variable_name, num_slot,C_FiltrageSlot);
% etape 3 : filtre commun 
m_filtre = m_nuage + m_stat; % nan correspond au pixels non communs ou non traitable 
m_filtre = ~isnan(m_filtre);

% Application du filtre global
%
% resultats sous forme matriciel
M_lon = lon;
M_lon(m_filtre == 0) = nan;
M_lat = lat;
M_lat(m_filtre == 0) = nan;
M_data = data_slot_GOCI;
M_data(m_filtre == 0) = nan;
% resultats sous forme vectoriel
lon = lon(m_filtre);
lat = lat(m_filtre);
data = data_slot_GOCI(m_filtre);






