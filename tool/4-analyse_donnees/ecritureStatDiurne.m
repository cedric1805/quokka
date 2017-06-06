function ecritureStatDiurne( A,full_path_txtFile )
% ecritureFiltrageSlot Fonction qui ecrit le resultat de la fonction 
% filtreSlot dans un fichier texte.
%
% ENTREE
%   A : nom du fichier L2
%
%
% SORTIE
%   ecriture du fichier full_path_txtFile.txt

if exist(full_path_txtFile, 'file')
    
    fid = fopen(full_path_txtFile, 'a');
    fprintf(fid, '%s\t%d\t%s\t%s\t%s\t%s\n',A{:});
    fclose(fid);
    
else
    
    fid = fopen(full_path_txtFile,'wt');
    fprintf(fid, '%s\n','===========================================================================================================================================================');
    fprintf(fid, '%s\n','date//num_slot//variable_name//unite//stat_name//value');
    fprintf(fid, '%s\n','===========================================================================================================================================================');
    fprintf(fid, '%s\t%d\t%s\t%s\t%s\t%s\n',A{:});
    fclose(fid);
    
end%if 

fclose('all');


