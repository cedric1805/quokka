function filtrePartitionSlot( full_path_txtFile,C_FiltrageSlot,num_slot )
% ecritureFiltrageSlot : Fonction qui ecrit le resultat de la fonction 
% filtreSlot dans un fichier texte.
%
% ENTREE
%   full_path_txtFile : chemin complet du fichier texte cree
%   C_FiltrageSlot : nom du fichier L2
%   num_slot : nom du fichier L2
%
%
% SORTIE
%   ecriture du fichier texte

index = find(C_FiltrageSlot{2} == num_slot);
coord_slot = [C_FiltrageSlot{3}(index), C_FiltrageSlot{4}(index), C_FiltrageSlot{5}(index), C_FiltrageSlot{6}(index)];

n = 4; % on divisise la zone en 16 rectangles de 4 par 4;

pas_row = round((coord_slot(2)-coord_slot(1))/n);
pas_col = round((coord_slot(4)-coord_slot(3))/n);

if exist(full_path_txtFile, 'file')
    
    fid = fopen(full_path_txtFile, 'a');

    for k = 1:n
        if mod(k,2) == 1
            % colum impair 1 and 3
            for kk = 1:n
                row_min = coord_slot(1) + (kk-1)*pas_row;
                row_max = coord_slot(1) + kk*pas_row;
                col_min = coord_slot(3) + (k-1)*pas_col;
                col_max = coord_slot(3) + k*pas_col;

                coord_sous_slot = [row_min,row_max,col_min,col_max];

                A = {C_FiltrageSlot{1}{index},n*(k-1) + kk,C_FiltrageSlot{2}(index),0,0,0,0,coord_sous_slot};
                fprintf(fid, '%s\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n',A{:});         
            end%kk         
        else
             % colum pair 2 an 4
             for kk = n:-1:1
                row_min = coord_slot(1) + (kk-1)*pas_row;
                row_max = coord_slot(1) + kk*pas_row;
                col_min = coord_slot(3) + (k-1)*pas_col;
                col_max = coord_slot(3) + k*pas_col;

                coord_sous_slot = [row_min,row_max,col_min,col_max];

                A = {C_FiltrageSlot{1}{index},n*k+1-kk,C_FiltrageSlot{2}(index),0,0,0,0,coord_sous_slot};
                fprintf(fid, '%s\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n',A{:});        
             end%kk   
        end%if
    end%k
    
    fclose(fid);
    
else
    
    fid = fopen(full_path_txtFile,'wt');
    fprintf(fid, '%s\n','====================================================================================================================================================================');
    fprintf(fid, '%s\n','filename//num_slot//slot_parents_niveau1//slot_parents_niveau2//slot_parents_niveau3//slot_parents_niveau4//slot_parents_niveau5//row_min//row_max//col_min//col_max');
    fprintf(fid, '%s\n','====================================================================================================================================================================');
    
    for k = 1:n
        if mod(k,2) == 1
            % colum impair 1 and 3
            for kk = 1:n
                row_min = coord_slot(1) + (kk-1)*pas_row;
                row_max = coord_slot(1) + kk*pas_row;
                col_min = coord_slot(3) + (k-1)*pas_col;
                col_max = coord_slot(3) + k*pas_col;

                coord_sous_slot = [row_min,row_max,col_min,col_max];

                A = {C_FiltrageSlot{1}{index},n*(k-1) + kk,C_FiltrageSlot{2}(index),0,0,0,0,coord_sous_slot};
                fprintf(fid, '%s\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n',A{:});         
            end%kk         
        else
             % colum pair 2 an 4
             for kk = n:-1:1
                row_min = coord_slot(1) + (kk-1)*pas_row;
                row_max = coord_slot(1) + kk*pas_row;
                col_min = coord_slot(3) + (k-1)*pas_col;
                col_max = coord_slot(3) + k*pas_col;

                coord_sous_slot = [row_min,row_max,col_min,col_max];

                A = {C_FiltrageSlot{1}{index},n*k+1-kk,C_FiltrageSlot{2}(index),0,0,0,0,coord_sous_slot};
                fprintf(fid, '%s\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n',A{:});        
             end%kk   
        end%if
    end%k
    
    fclose(fid);
    
end%if 

fclose('all');