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
% l2prod = 'Lw_nnn Rrs_vvv a_nnn_qaa bb_nnn_qaa bbp_nnn_qaa chlor_a nLw_nnn slot'; 
% l2prod = 'Rrs_vvv bbp_555_qaa chlor_a'; 	
l2prod = 'Rrs_vvv bbp_555_qaa chlor_a taua_nnn';
%==========================================================================
%==========================================================================



% donnees brutes
folder_name_data_brute = '0-donnees_brutes';
full_path_folder_data_brute  = strcat(path,'/',folder_name_data_brute);
% donnees a traiter
folder_name_a_traiter = '0-GOCI_L1B';
full_path_folder_a_traiter  = strcat(full_path_folder_data_brute,'/',folder_name_a_traiter);

% donnees traiter
folder_name_data_traiter = '1-donnees_traitees';
full_path_folder_data_traiter  = strcat(path,'/',folder_name_data_traiter);
% donnees en traitemenent
folder_name_en_traitement1 = '_00_en_traitement';
folder_name_en_traitement2 = '0-GOCI_L2_LAC';
full_path_folder_en_traitement  = strcat(full_path_folder_data_traiter,'/',folder_name_en_traitement1,'/',folder_name_en_traitement2);


% full_path_folder_a_traiter  = '/Users/cmenut/Desktop/stage_it2/1-donnees_brutes/0-nasa/0-GOCI/2015-09-30';
% full_path_folder_en_traitement = '/Users/cmenut/Desktop/stage_it2/2-traitements/0-SeaDAS/0-nasa/0-GOCI/2015-09-30';

%%
fprintf('Ecriture du .sh \n---------------------------\n'); 
seadas_commande = 'l2gen';
extension = 'he5';
[cell_input_name,cell_output_name] = name_inputNname_output(full_path_folder_a_traiter,extension,seadas_commande,full_path_folder_en_traitement);
scriptname = 'traitementSeaDAS_GOCI.sh';
full_path_script = strcat(path,'/',scriptname);
GOCIS_L1BtoL2_LAC_Shell( full_path_script,cell_input_name,cell_output_name,seadas_commande,l2prod );

fprintf('Execution du .sh \n---------------------------\n'); 
executionShell( full_path_script ,l2prod);
toc

%% 
%data_in = '/Volumes/CMENUT/stage_it2/1-donnees_brutes/0-nasa/0-GOCI/L1/2015-02-';
data_in = '/Volumes/MYPASSPORT/stage_it2/1-donnees_brutes/0-nasa/0-GOCI/L1/2015-06-';
parentFolder = '/Volumes/MYPASSPORT/stage_it2/2-traitements/0-SeaDAS/0-nasa/0-GOCI/';
seadas_commande = 'l2gen';
extension = 'he5';
for i=1:30
    ii = sprintf('%.2d',i);
    full_path_folder_a_traiter = strcat(data_in,ii)
    folderName = strcat('2015-06-',ii);
    full_path_folder_en_traitement = strcat(parentFolder,folderName)
    mkdir(full_path_folder_en_traitement);
    i
    fprintf('Ecriture du .sh \n---------------------------\n'); 
    [cell_input_name,cell_output_name] = name_inputNname_output(full_path_folder_a_traiter,extension,seadas_commande,full_path_folder_en_traitement);
    scriptname = strcat('traitementSeaDAS_GOCI-jun-',ii,'.sh');
    full_path_script = strcat(path,'/',scriptname);
    GOCIS_L1BtoL2_LAC_Shell( full_path_script,cell_input_name,cell_output_name,seadas_commande,l2prod );
    

end%i