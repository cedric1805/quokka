function [ m_nuage] = filtreNuage_delta(full_name,operation_morpho,index_mask,nbre_mask,num_slot,C_FiltrageSlot)
% filtreNuage : Fonction qui permet de determiner les pixels non influences
%par les nuages. On effectue donc une dilation sur les pixels nuages puis
%on recupere les pixels non affectes. Les informations geographiques des 
%nuages se trouvent dans la couche le flag 'geophysical_data/l2_flags' du
%fichier netCDF. Dans le flag, on recupere le mask correspondant au nuage
%'CLDICE'. On travaille en utilisant l'index de ce mask ainsi
%que le nombre de mak pour pouvoir travailler en binaire.
%
% 
% ENTREE
%   full_name : nom du fichier L2 a traiter
%   num_slot : numero du slot (compris entre 1 et 16 inclus)
%   C_FiltrageSlot : information sur les coordonnees des slot, resultats de
%                    la fonction lectureFiltrageSlot.m
%   operation_morpho : nom de l'operation morphologique ('dilate')
%   index_mask : 
%   nbre_mask : 
%
% SORTIE
%   m_nuage : matrice des donnees filtrees par rapport aux nuages, 
%   de meme taille que les donnees brutes et nan correspond aux valeurs
%   non traitables


flags = ncread(full_name,'geophysical_data/l2_flags') ; 

% recuperation [ row_min,row_max,col_min,col_max ] correspondant au slot demande
% col_slot = C_FiltrageSlot{2};
if nargin > 4
    nargin
    index = find(C_FiltrageSlot{2} == num_slot);
    coord_slot = [C_FiltrageSlot{end-3}(index), C_FiltrageSlot{end-2}(index), C_FiltrageSlot{end-1}(index), C_FiltrageSlot{end}(index)];

    flags = flags(coord_slot(1) :coord_slot(2) ,coord_slot(3) :coord_slot(4));

end

m_b = de2bi(flags,nbre_mask); % matrice numel(m_flag) ligne et n colonnes
index_nuage = m_b(:,index_mask); 

m_nuage = zeros(size(flags)); % initialisation
for i=1:length(index_nuage) 
   m_nuage(i) = index_nuage(i);
end%for

m_nuage = double(bwmorph(m_nuage,operation_morpho));

m_nuage(m_nuage == 1) = nan;  % nan correspond au zone avec nuage