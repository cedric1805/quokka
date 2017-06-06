function [ cell_input_name ] = recuperationFileName( folder_path, extension )
% recuperationFile fonction qui recupere les noms d'un fichiers d'un dossier ayant une
% extension paticuliere. Si l'extension est manquante alors on recupere
% tous les fichiers inclus dans le dossier de travail.
%
% ENTREE
%   folder_path : exemple '0-donnees_brutes_GOCI_L1B/a_traiter'
%   extension : exemple 'he5'
%
% SORTIE
%   cell_input_name : cell array contenant les informations des fichiers.
%       c{1,i} pour acceder au nom AVEC extension

switch nargin
    case 2
        
        MyFolderInfo = dir(strcat(folder_path,'/*.',extension));
        c = struct2cell(MyFolderInfo);

        % n = nombre de fichier trouves
        n = size(c);
        n = n(2);

        % initialisation
        cell_input_name = cell(1,n);

        for i=1:n
            [pathstr,name,ext] = fileparts(c{1,i});
            cell_input_name{1,i} = strcat(folder_path,'/',name,ext);
        end%i

        
    case 1
        
        MyFolderInfo = dir(strcat(folder_path));
        c = struct2cell(MyFolderInfo);

        % n = nombre de fichier trouves
        n = size(c);
        n = n(2);

        % initialisation
        cell_input_name = cell(1,n);

        for i=1:n
            [pathstr,name,ext] = fileparts(c{1,i});
            cell_input_name{1,i} = strcat(folder_path,'/',name,ext);
        end%i
        
    otherwise
        cell_input_name = {};
end







