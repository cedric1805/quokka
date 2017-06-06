function [ row_min,row_max,col_min,col_max ] = filtreSlot( full_name, num_slot )
% FILTRESLOT : Fonction qui permet de determiner la matrice la plus grande
% contenue dans un slot particulier.
% Les slots sont les tuilles de l'image GOCI, il y en 16 par image.
% 
% ENTREE
%   full_name : nom du fichier L2
%   num_slot : numero du slot (compris entre 1 et 16 inclus)
%
% SORTIE
%   row_min : ligne min de la matrice max dans le repere d'origine
%   row_max : ligne max de la matrice max dans le repere d'origine
%   col_min : colonne max de la matrice max dans le repere d'origine
%   col_max : colonne max de la matrice max dans le repere d'origine


slot = ncread(full_name,'geophysical_data/slot') ;
% slot est une matrice correspondant aux tuilles d'acquisition 
% slot est represente comme ceci :
% [1,2,3,4 ; 8,7,6,5 ; 9,10,11,12 ; 16,15,14,13]
% num_slot doit donc etre compris entre 1 et 16

A = double(slot==num_slot); % 1 correspond au slot en question

[row_min,row_max,col_min,col_max] = largestAeraMatrix( A );


