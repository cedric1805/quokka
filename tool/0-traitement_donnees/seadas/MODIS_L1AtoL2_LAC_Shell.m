function MODIS_L1AtoL2_LAC_Shell( full_path_script,cell_input_name,full_path_output,l2prod )
% MODIS_L1AtoL2_LAC_Shell : Fonction qui cree un script shell afin d'executer les
% commandes SeaDAS souhaite. Les variables d'environnement et la permission
% pour executer ce script sont definies en entete lors de l'ecriture.
% Ensuite on boucle sur les noms des fichiers puis on execute une commande
% SeaDAS. Les noms de sortie ont ete modifie au prealable.
%
% ENTREE
%   full_path_script : chemin complet du script
%   cell_input_name : tableau contenant les noms des fichiers en entree de
%                     la commande SeaDAS
%   full_path_output : chemin complet de sortie 
%   l2prod : liste des produits a generer
%
% SORTIE
%   Ecriture du shell
%

n = size(cell_input_name);
n = n(2);

%nom extension
C = strsplit(cell_input_name{:},'/');
nom_extension = C(end);
nom_extension = nom_extension{:};

% chemin 
C = strsplit(cell_input_name{:},'/');
chemin ='';
for i = 1:size(C,2)-1
    chemin = strcat(chemin,C(i),'/');
end
chemin = chemin{:};
% nom avec chemin
C = strsplit(cell_input_name{:},'.');
nom = C(end-1);
nom = nom{:};
% nom seul
C = strsplit(nom,'/');
nom_seul = C(end);
nom_seul = nom_seul{:};


if ~isempty(cell_input_name) 
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
    % -------------------
    % STEP 1 : L1A to GEO
    % -------------------
    seadas_commande = 'modis_geo.py';
    %
    fprintf(fid,'\n%s\n','## Step 1 : L1A to GEO');
    fprintf(fid,'%s\n','## =================================================');
    input_name = cell_input_name{:};
    output_name = strcat(nom,'.GEO');
    fprintf(fid,'%s\t%s\t%s\t%s\n',seadas_commande,input_name,'-o',output_name);

    % -------------------------
    % STEP 2 : L1A + GEO to L1B
    % -------------------------
    seadas_commande = 'modis_L1B.py';
    %
    fprintf(fid,'\n%s\n','## Step 2 : L1A + GEO to L1B');
    fprintf(fid,'%s\n','## =================================================');
    fprintf(fid,'%s\t%s\n','cd',chemin);
    input_name = nom_extension;
    fprintf(fid,'%s\t%s\n',seadas_commande,input_name);
    % -------------------------
    % STEP 3 : L1B_LAC + GEO to L2LAC
    % -------------------------
    seadas_commande = 'l2gen';
    %
    fprintf(fid,'\n%s\n','## STEP 3 : L1B_LAC + GEO to L2LAC');
    fprintf(fid,'%s\n','## =================================================');
    input_name1 = strcat(nom_seul,'.L1B_LAC');
    input_name2 = strcat(nom_seul,'.GEO');
    output_name = strcat(full_path_output,'/',nom_seul,'.L2_LAC_OC');
    fprintf(fid,'%s\t%s%s\t%s%s\t%s%s\t%s%s%s\n',seadas_commande,'ifile=',input_name1,'geofile=',input_name2,'ofile1=',output_name,'l2prod="',l2prod,'"');

    
    
    fprintf(fid,'%s\n','exit 0');
    fclose(fid);
    
end%if

fclose('all');