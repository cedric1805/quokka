function ecritureFiltrageSlot( A,full_path_txtFile )
% ecritureFiltrageSlot : Fonction qui ecrit le resultat de la fonction 
% filtreSlot dans un fichier texte. Ici on travaille uniquement avec les
% 'vrais' slot. Cette fonction est uniquement appele par le script_slot.m,
% situe dans les script_annexe
%
% ENTREE
%   A : resultats sous forme de tableau de la fonction filtreSlot
%   full_path_txtFile : chemin complet du fichier texte ou l'on ecrit les
%                       resultats
%
%
% SORTIE
%   ecriture du fichier full_path_txtFile.txt

if exist(full_path_txtFile, 'file')
    
    fid = fopen(full_path_txtFile, 'a');
    fprintf(fid, '%s\t%d\t%d\t%d\t%d\t%d\n',A{:});
    fclose(fid);
    
else
    
    fid = fopen(full_path_txtFile,'wt');
    fprintf(fid, '%s\n','===========================================================================================================================================================');
    fprintf(fid, '%s\n','filename//num_slot//row_min//row_max//col_min//col_max');
    fprintf(fid, '%s\n','===========================================================================================================================================================');
    fprintf(fid, '%s\t%d\t%d\t%d\t%d\t%d\n',A{:});
    fclose(fid);
    
end%if 

fclose('all');

