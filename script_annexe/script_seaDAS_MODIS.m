% ING2, ENSG : Outils d'aide a l'analyse des donnees GOCI
% Objectifs : Qualifier les donnees GOCI
% Juillet, 2016
%
%--------------------------------------------------------------------------
% DESCRIPTION :
% -----------
% Ce script permet de generer un shell .sh permettant d'effectuer un 
% traitement SeaDAS sur un ensemble de jeux de donnees. Ce .sh est ecrit a
% la racine du dossier, il peut etre execute en ligne de commande ou par
% l'intermediaire de Matlab.
% Ce .sh fonctionne avec la version SeaDAS 7.3.2
%
% UTILISATION
% -----------
% Placez vos donnees brutes L1 a traiter dans le dossier 
% '0-donnees_brutes_GOCI_L1B/a_traiter'
%
% Une fois le .sh execute, recuperer les donnnees traitees dans le dossier
% '1-donnees_traitees_GOCI_L2/00_en_traitement' elles sont renommees de la
% meme maniere que lors d'un traitement SeaDAS.
%--------------------------------------------------------------------------

clc
close all
clear
tic

addpath '../tool'
addpath '../tool/0-traitement_donnees/seadas'
addpath '../tool/1-traitement_fichier'

%==========================================================================
%==========================================================================
% Parametres pour utilisation standard :
path = '/Users/cmenut/Desktop/V3'; % chemin absolue du dossier
l2prod = 'Rrs_vvv a_vvv_qaa b_vvv_qaa bb_vvv_qaa bbp_vvv_qaa chlor_a'; 
%==========================================================================
%==========================================================================

% donnees brutes
folder_name_data_brute = '0-donnees_brutes';
full_path_folder_data_brute  = strcat(path,'/',folder_name_data_brute);
% donnees a traiter
folder_name_a_traiter = '1-MODIS_L1A_LAC';
full_path_folder_a_traiter  = strcat(full_path_folder_data_brute,'/',folder_name_a_traiter);

% donnees traiter
folder_name_data_traiter = '1-donnees_traitees';
full_path_folder_data_traiter  = strcat(path,'/',folder_name_data_traiter);
% donnees en traitemenent
folder_name_en_traitement1 = '_00_en_traitement';
folder_name_en_traitement2 = '1-MODIS_L2_LAC';
full_path_folder_en_traitement  = strcat(full_path_folder_data_traiter,'/',folder_name_en_traitement1,'/',folder_name_en_traitement2);

%%
fprintf('Ecriture du .sh \n---------------------------\n'); 
seadas_commande = 'l2gen';
extension = 'L1A_LAC';
% [cell_input_name,cell_output_name] = name_inputNname_output(full_path_folder_a_traiter,extension,seadas_commande,full_path_folder_en_traitement);
[ cell_input_name ] = recuperationFileName( full_path_folder_a_traiter, extension );


scriptname = 'traitementSeaDAS_MODIS.sh';
full_path_script = strcat(path,'/',scriptname);
MODIS_L1AtoL2_LAC_Shell( full_path_script,cell_input_name,full_path_folder_en_traitement,l2prod )

% fprintf('Execution du .sh \n---------------------------\n'); 
executionShell( full_path_script ,l2prod);
toc