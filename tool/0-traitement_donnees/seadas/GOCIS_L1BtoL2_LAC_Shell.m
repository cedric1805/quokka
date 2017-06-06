function GOCIS_L1BtoL2_LAC_Shell( full_path_script,cell_input_name,cell_output_name,seadas_commande,l2prod )
% GOCIS_L1BtoL2_LAC_Shell : Fonction qui cree un script shell afin d'executer les
% commandes SeaDAS souhaite. Les variables d'environnement et la permission
% pour executer ce script sont definies en entete lors de l'ecriture.
% Ensuite on boucle sur les noms des fichiers puis on execute une commande
% SeaDAS. Les noms de sortie ont ete modifie au prealable.
%
% ENTREE
%   full_path_script : chemin complet du script
%   scriptname : nom du script cree 
%   cell_input_name : tableau contenant les noms des fichiers en entree de
%                     la commande SeaDAS
%   cell_output_name : tableau contenant les noms des fichiers en sortie de
%                      la commande SeaDAS
%   seadas_commande : commande SeaDAS (l2gen)
%   l2prod : liste des produits a generer
%
% SORTIE
%   Ecriture du shell
%

n = size(cell_input_name);
n = n(2);


if ~isempty(cell_input_name) && isequal(size(cell_input_name),size(cell_output_name)) 
    % creation du script 
    fid=fopen(full_path_script,'w');
    fprintf(fid,'%s\n','#!/bin/bash');
    fprintf(fid,'%s\n','export PATH=/Applications/seadas-7.3/bin:$PATH');
    fprintf(fid,'%s\n','export OCSSWROOT=/Applications/seadas-7.3.2/ocssw');
    fprintf(fid,'%s\n','source $OCSSWROOT/OCSSW_bash.env');
    fprintf(fid,'%s\n','## =================================================');
    fprintf(fid,'%s\n','## =================================================');
    % fprintf(fid,'%s\n','l2gen -help');
    fclose(fid);
    % permission ok
    % !chmod +x traitementSeaDAS.sh
    permission = strcat('chmod +x',{' '},full_path_script);
    system(permission{:});
    
    
    

    fid=fopen(full_path_script,'a');
    % tableau des noms a mettre en entree
    fprintf(fid,'%s\n','## declare an array variable input');
    fprintf(fid,'%s','declare -a arr_input=(');
    for i=1:n
        input_name = char(cell_input_name{i});
        fprintf(fid,'%s\t',input_name);
    end%i
    fprintf(fid,'%s',')');
    fprintf(fid,'\n%s\n','## =================================================');
    fprintf(fid,'\n%s\n','## =================================================');
    % tableau des noms a mettre en sortie
    fprintf(fid,'%s\n','## declare an array variable output');
    fprintf(fid,'%s','declare -a arr_output=(');
    for i=1:n
        output_name = char(cell_output_name{i});
        fprintf(fid,'%s\t',output_name);
    end%i
    fprintf(fid,'%s',')');
    fprintf(fid,'\n%s\n','## =================================================');
    fprintf(fid,'\n%s\n','## =================================================');
    fprintf(fid,'%s\n','n=${#arr_input}');
    fprintf(fid,'%s\n','echo n');
    fprintf(fid,'%s\n','for ((i=0;i<$n;i++)); do');
    fprintf(fid,'\t%s\t%s%s\t%s%s\t%s%s%s\n',seadas_commande,'ifile=','"${arr_input[i]}"','ofile1=','"${arr_output[i]}"','l2prod="',l2prod,'"');
    fprintf(fid,'%s\n','done');
    fprintf(fid,'%s\n','exit 0');
    fclose(fid);
    
end%if

fclose('all');

