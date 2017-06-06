function [ m_stat ] = filtreStat( filename,variable_name, num_slot,C_FiltrageSlot)
% filtreStat : Fonction qui permet d'eliminer les donnees aberrantes
% statistiauement sur la matrice data. On conserve uniquement les valeurs
% comprises entre -3sigma et +3sigma.
% 
%
% ENTREE
%   filename : nom du fichier L2
%   variable_name : nom de la variable a traiter
%   num_slot : numero du slot (compris entre 1 et 16 inclus)
%   C_FiltrageSlot : information sur les coordonnees des slot, resultats de
%                    la fonction lectureFiltrageSlot.m
%
%
% SORTIE
%   m_stat : matrice des donnees filtrees statistiquement, de meme taille
%   que les donnees brutes et nan correspond aux valeurs non traitables 


index = find(C_FiltrageSlot{2} == num_slot);
coord_slot = [C_FiltrageSlot{end-3}(index), C_FiltrageSlot{end-2}(index), C_FiltrageSlot{end-1}(index), C_FiltrageSlot{end}(index)];

if strcmp( variable_name,'bbp_555_qqa_v5')
    fprintf('bbp_555_qqa_v5\n')
    %--------------------------------------------------------------------------
    % Variable calcule directement sous Matlab
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
    
    data = bbp_lambda_0;
    %--------------------------------------------------------------------------
else
    %--------------------------------------------------------------------------
    % Variable etant sous le format netCDF (par traitement SeaDAS par exemple)
    data = ncread(filename,strcat('geophysical_data','/',variable_name));
    data = data(coord_slot(1):coord_slot(2) , coord_slot(3):coord_slot(4));
    %--------------------------------------------------------------------------
    
end%if 

% calcul param stat
M = data(~isnan(data)); % sans NaN
moyenne = mean(M);
sigma = std(M);

m_stat = data;
m_stat(data<(moyenne-3*sigma) | data>(moyenne+3*sigma)  | data<0 ) = nan; % nan correspond au non traitable 