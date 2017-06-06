function [ cell_intput_name,cell_output_name  ] = name_inputNname_output(full_path_folder_a_traiter,extension,seadas_commande,full_path_folder_en_traitement )
% name_inputNname_output fonction qui permet de generer deux tableaux de
% noms (entree et sortie) afin de les utiliser pour une commande SeaDAS.
% l2gen par exemple. 
%
% ENTREE
%   full_path_folder_a_traiter : chemin complet du dossier a traiter, les
%   entree de la commande seaDAS
%   extension : extension des fichier a traiter en entree
%   seadas_commande : commande SeaDAS
%   full_path_folder_en_traitement : chemin complet du dossier de traite,
%   les sorties de la commmande SeaDAS
%
%
% SORTIE
%   cell_intput_name : tableau contenant les noms a mettre en entree pour
%   la commande SeaDAS
%   cell_output_name : tableau contenant les noms a mettre en sortie pour
%   la commande SeaDAS
%
%
% recuperation des fichier dans le dossier specifique
% UTILISATION DE recuperationFileName ???
MyFolderInfo = dir(strcat(full_path_folder_a_traiter,'/*.',extension));
c = struct2cell(MyFolderInfo);

% n = nombre de fichier trouves
n = size(c);
n = n(2);

% initialisation
cell_intput_name = cell(1,n);
cell_output_name = cell(1,n);

for i=1:n
    [pathstr,name,ext] = fileparts(c{1,i});
    cell_intput_name{1,i} = strcat(full_path_folder_a_traiter,'/',name,'.',extension);
    
    if strcmp(seadas_commande,'l2gen')
        nom_arrive = output_name_l2gen( name );
        cell_output_name{1,i} = strcat(full_path_folder_en_traitement,'/',nom_arrive);
    end%if
  
end%i



