% ING2, ENSG : Outils d'aide a l'analyse des donnees GOCI
% Objectifs : Qualifier les donnees GOCI
% Juillet, 2016
%
%--------------------------------------------------------------------------
% DESCRIPTION :
% -----------
% Ce script permet de genere un fichier texte contenant les coordonnees 
% (lignes colonnes) des 4 coins de chaques slot (tuilles, imagettes) d'une 
% image GOCI. Une image GOCI est compose de 16 slots. 
% L'orbite etant geostationnaire, ces coordonnees
% peuvent etre calcule sur une seule image. Ce script peut etre utilise 
% pour un ensemble d'imageslot est un attribut qui doit etre genere par
% traitement (SeaDAS par exemple) lors du passage d'une image de niveau
% L1 au niveau L2.
%
% Inutile de lancer ce script si le fichier .txt existe deja
%
% UTILISATION
% -----------
% Placez des donnees L2 contenant la couche slot dans le dossier
% 'donnees_traitees_GOCI_L2/01_slot'
% (une image par defaut est dans ce dossier)
%
% Recuperez les resultat dans le fichier "CoordonneesSlot.txt",  situe dans
% le dossier '1-donnees_traitees_GOCI_L2'.
%--------------------------------------------------------------------------

clc
close all
clear
tic


addpath '../tool'
addpath '../tool/1-traitement_fichier'
addpath '../tool/3-filtre_donnees'
addpath '../tool/4-analyse_donnees'


%==========================================================================
%==========================================================================
% Parametres pour utilisation standard :
path = '/Users/cmenut/Desktop/V3'; % chemin absolue du dossier
num_slot = (1:16); % slot allant de 1 a 16 !!!!!!
%==========================================================================
%==========================================================================

% donnees traiter
folder_name_data_traiter = '1-donnees_traitees';
full_path_folder_data_traiter  = strcat(path,'/',folder_name_data_traiter);
% donnees obtention coordonnees slot
folder_name_slot = '_01_slot';
full_path_folder_slot  = strcat(full_path_folder_data_traiter,'/',folder_name_slot);

%%
fprintf('Ecriture des coordonnees slot\n------------------------------\n');
extension = 'L2_LAC_OC';
cell_name_slot = recuperationFileName(full_path_folder_slot, extension );

txtname = 'CoordonneesSlot.txt';
full_path_txtFile_Slot = strcat(full_path_folder_data_traiter,'/',txtname);

% n = nombre de fichier a filtrer
n = size(full_path_folder_slot);
n = n(2);

% m = nombre de slots a traiter
m = length(num_slot);

for j = 1:m
    [ row_min,row_max,col_min,col_max ] = filtreSlot( cell_name_slot{1}, num_slot(j));
    A = {cell_name_slot{1},num_slot(j),row_min,row_max,col_min,col_max};
    ecritureFiltrageSlot( A,full_path_txtFile_Slot );
end%i
toc