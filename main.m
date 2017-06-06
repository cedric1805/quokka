% ING2, ENSG : Outils d'aide a l'analyse des donnees GOCI
% Objectif : Qualifier les donnees GOCI
% Juillet, 2016
%
%--------------------------------------------------------------------------
% DESCRIPTION :
% -----------
% Ce script permet de generer des graphique afin de faciliter l'analyse des
% donnees GOCI de niveau L2. 
% 3 modes d'utilisations independants : 
%   1. Analyse individuelle d'images
%   2. Analyse groupee d'images (analyse diurne par exemple)
%   3. Comparaison d'une image GOCI avec une image MODIS

%
% UTILISATION
% -----------
% Selon le mode d'utilisation, placez des donnees L2 dans les dossiers
% suivants : 
% 'donnees_traitees_GOCI_L2/01_slot'
%   1. Analyse individuelle d'images : 
%       '1-donnees_traitees/1_a_analyser_indiv'
%   2. Analyse groupee d'images (analyse diurne par exemple) :
%       '1-donnees_traitees/2_a_analyser_groupe'
%   3. Comparaison d'une image GOCI avec une image MODIS : 
%       '1-donnees_traitees/3_a_comparer'
%
% Recuperez les resultats par visulalisation de figure ou par lecture de
% fichiers textes. 
%--------------------------------------------------------------------------

clc
close all
clear

addpath 'tool'
addpath 'tool/1-traitement_fichier'
addpath 'tool/2-affichage'
addpath 'tool/2-affichage/m_map1.4/m_map'
addpath 'tool/2-affichage/suplabel'
addpath 'tool/2-affichage/uneven';
addpath 'tool/3-filtre_donnees'
addpath 'tool/4-analyse_donnees'


%==========================================================================
%==========================================================================
% Parametres pour utilisation standard : 
path = 'C:/Users/Cedric/Desktop/quokka';% chemin absolue du dossier
%
%   1. Analyse individuelle d'images
variable_name_indiv = {'chlor_a'};
num_slot_indiv = (13); % slot allant de 1 a 16
%
%   2. Analyse groupee d'images (analyse diurne par exemple)
% variable_name_groupe = {'Rrs_555','bbp_555_qaa','chlor_a','taua_555'};
variable_name_groupe = {'Rrs_555'};
num_slot_groupe = (1:16); % slot allant de 1 a 16
%
%   3. Comparaison d'une image GOCI avec une image MODIS
variable_name_comparaison = {'Rrs_555','bbp_555_qaa','chlor_a'};
num_slot_comparaison = (1:16); % slot allant de 1 a 16
%==========================================================================
%==========================================================================

% donnees traiter
folder_name_data_traiter = '1-donnees_traitees';
full_path_folder_data_traiter  = strcat(path,'/',folder_name_data_traiter);
% donnees a analyser individuellement
folder_name_a_analyser_indiv = '1_a_analyser_indiv';
full_path_folder_a_analyser_indiv  = strcat(full_path_folder_data_traiter,'/',folder_name_a_analyser_indiv);
% donnees a analyser en groupe
folder_name_a_analyser_groupe = '2_a_analyser_groupe';
full_path_folder_a_analyser_groupe = strcat(full_path_folder_data_traiter,'/',folder_name_a_analyser_groupe);
% donnees a comparer avec MODIS
folder_name_a_comparer = '3_a_comparer';
full_path_folder_a_comparer = strcat(full_path_folder_data_traiter,'/',folder_name_a_comparer);
%
%
% Recuperation des coordonnees slot
txtname = 'CoordonneesSlot.txt';
full_path_txtFile_Slot = strcat(full_path_folder_data_traiter,'/',txtname);
C_FiltrageSlot = lectureFiltrageSlot( full_path_txtFile_Slot);
% Recuperation des coordonnees des sous slot
% txtname = 'CoordonneesPartitionSlot_16_level1.txt';
% full_path_txtFile_PartitionSlot = strcat(full_path_folder_data_traiter,'/',txtname);
% C_PartitionSlot = lecturePartitionSlot( full_path_txtFile_PartitionSlot);
%
%
% Recuperation des Moyennes Diurnes GOCI
%txtname_moy = 'MoyenneDiurne-GOCI.txt';
%txtname_moy = 'MoyenneDiurne-GOCI-#13.txt';
%txtname_moy = 'MoyenneDiurne-GOCI-sept2015.txt';
%full_path_txtFile_MoyDiurne = strcat(full_path_folder_a_analyser_groupe,'/',txtname_moy);
%[C_MoyDiurne] = lectureStatDiurne( full_path_txtFile_MoyDiurne);

% Recuperation des Medianes Diurnes GOCI       
%txtname_med = 'MedianeDiurne-GOCI.txt';
%txtname_med = 'MedianeDiurne-GOCI-#13.txt';
%txtname_med = 'MedianeDiurne-GOCI-sept2015.txt';
%txtname_med = 'MedianeDiurne-GOCI-sept2015-Slot13-level1.txt';
%txtname_med = 'MedianeDiurne-GOCI-sept2015-Slot16-level1.txt';
txtname_med = 'MedianeDiurne-GOCI-feb2015.txt';
full_path_txtFile_MedianeDiurne = strcat(full_path_folder_a_analyser_groupe,'/',txtname_med);
[C_MedianeDiurne] = lectureStatDiurne( full_path_txtFile_MedianeDiurne);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------- Analyse individuelle d'images ---------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
fprintf('Analyse individuelle d images\n------------------------------\n');
extension = 'L2_LAC_OC';
cell_name_a_analyser_indiv = recuperationFileName( full_path_folder_a_analyser_indiv, extension );
n = size(cell_name_a_analyser_indiv);
n = n(2);

m = length(num_slot_indiv);

l = length(variable_name_indiv);

for i=1:n
    for j=1:m
        for k=1:l
            [ lon,lat,data,M_lon,M_lat,M_data] = analyse_indiv( cell_name_a_analyser_indiv{i},variable_name_indiv{k},num_slot_indiv(j),C_FiltrageSlot ); % slot
            % [ lon,lat,data,M_lon,M_lat,M_data] = analyse_indiv( cell_name_a_analyser_indiv{i},variable_name_indiv{k},num_slot_indiv(j),C_PartitionSlot ); % partition slot
            titre = titreFigure( cell_name_a_analyser_indiv{i},variable_name_indiv{k}, num2str(num_slot_indiv(j)));
            commentaire = annotationFigure( cell_name_a_analyser_indiv{i},variable_name_indiv{k});
            affichageStatData( data,titre,commentaire );
            affichageCarteData( M_data, M_lat,M_lon, titre, commentaire);
        end%k
    end%m
end%n
toc
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------- Analyse groupee d'images --------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
fprintf('Analyse groupee d images\n------------------------------\n');
extension = 'L2_LAC_OC';

% groupe de donnees sur une journee 
% full_path_folder_a_analyser_groupe = strcat(full_path_folder_a_analyser_groupe,'/','2015-02-01');
% analyse_groupe( full_path_folder_a_analyser_groupe,extension,variable_name_groupe,num_slot_groupe,C_FiltrageSlot ); 

%-----------
% calcul delta 

out = 'D:/resultat_delta';
data_in = 'G:/stage_it2/2-traitements/0-SeaDAS/0-nasa/0-GOCI/2015-06-';
for j = 1:31
    tic 
    close all
    ii = sprintf('%.2d',j);
    full_path_folder_a_analyser_groupe = strcat(data_in,ii);
    
    [ cell_input_name ] = recuperationFileName( full_path_folder_a_analyser_groupe, extension );
    if size(cell_input_name,2) == 8

        full_name_1 = cell_input_name{1};
        full_name_4 = cell_input_name{4};
        full_name_5 = cell_input_name{5};
        full_name_8 = cell_input_name{end};

        % lat/lon de la journée (à utiliser pour tout le mois ?)
        lon = ncread(full_name_1,'navigation_data/longitude') ; 
        lat = ncread(full_name_1,'navigation_data/latitude') ; 
        delta_name = {'delta matin','delta apres-midi','delta diurne'};
        variable_name = {'Rrs_555','bbp_555_qaa','chlor_a'};

        for i=1:length(variable_name)
            affichageCarteDelta( full_name_1,full_name_4,delta_name{1},variable_name{i},lat,lon,out) % delta matin
            affichageCarteDelta( full_name_5,full_name_8,delta_name{2},variable_name{i},lat,lon,out) % delta apres-midi
            affichageCarteDelta( full_name_1,full_name_8,delta_name{3},variable_name{i},lat,lon,out) % delta diurne
        end%for

    else 
        fprintf('nombre invalide d image \n');
        fprintf(full_path_folder_a_analyser_groupe);
        fprintf('\n ------------------------------\n');


    end%if
    
    toc
end%for

%-----------


% outfile = '/Users/cmenut/Desktop/test';
% analyse_groupe_delta( full_path_folder_a_analyser_groupe,extension,variable_name_groupe,outfile) ;

% % groupe de donnees sur une journee, sur un mois 
% % data_in = '/Volumes/CMENUT/stage_it2/2-traitements/0-SeaDAS/0-nasa/0-GOCI/2015-02-';
% data_in = '/Volumes/CMENUT/stage_it2/2-traitements/0-SeaDAS/0-nasa/0-GOCI/2015-02-';
% % data_in = '/Volumes/MYPASSPORT/stage_it2/2-traitements/0-SeaDAS/0-nasa/0-GOCI/2015-06-';
% for i=1:30
%     tic 
%     ii = sprintf('%.2d',i);
%     full_path_folder_a_analyser_groupe = strcat(data_in,ii);
%     fprintf('Analyse groupee d images\n------------------------------\n');
%     i
%     %analyse_groupe( full_path_folder_a_analyser_groupe,extension,variable_name_groupe,num_slot_groupe,C_FiltrageSlot );
%     analyse_groupe2( full_path_folder_a_analyser_groupe,extension,variable_name_groupe,num_slot_groupe,C_FiltrageSlot );
%     toc
% end%i

% fprintf('Analyse diurne globale\n------------------------------\n');
% variable_name = {'Rrs_555','bbp_555_qaa','chlor_a','taua_555'};
% num_slot = (1:16);
% %analyse_diurne_globale(C_MoyDiurne,variable_name,num_slot);
% analyse_diurne_globale(C_MedianeDiurne,variable_name,num_slot);

toc
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------- Comparaison GOCI / MODIS --------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
extension = 'L2_LAC_OC';
param_grille = 2;
fprintf('Comparaison GOCI / MODIS\n------------------------------\n');

% [ data_GOCI,DMC] = comparaison_GociModis( full_path_folder_a_comparer,extension,variable_name_comparaison, num_slot_comparaison,C_PartitionSlot );

[ G_GOCIS,G_MODIS] = comparaison_GociModis_grille( full_path_folder_a_comparer,extension,variable_name_comparaison, num_slot_comparaison,C_PartitionSlot,param_grille );

toc
