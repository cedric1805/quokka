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
num_slot = 16; % slot a partitonner 
% txtname = 'CoordonneesPartitionSlot.txt';
txtname_output = 'CoordonneesPartitionSlot_16_level1.txt'; % output
%==========================================================================
%==========================================================================

% donnees traiter
folder_name_data_traiter = '1-donnees_traitees';
full_path_folder_data_traiter  = strcat(path,'/',folder_name_data_traiter);
full_path_txtFile_PartitionSlot = strcat(full_path_folder_data_traiter,'/',txtname_output);

% Recuperation des coordonnees slot
txtname = 'CoordonneesSlot.txt';
full_path_txtFile_Slot = strcat(full_path_folder_data_traiter,'/',txtname);
C_FiltrageSlot = lectureFiltrageSlot( full_path_txtFile_Slot);
%% sous partitionner CoordonneesSlot.txt
filtrePartitionSlot( full_path_txtFile_PartitionSlot,C_FiltrageSlot,num_slot )
% ecriturePartitionSlot(full_path_txtFile_PartitionSlot,C_FiltrageSlot,num_slot)

toc