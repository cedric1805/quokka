function [C] = lectureStatDiurne( full_path_txtFile)
% ecritureFiltrageSlot Fonction qui ecrit le resultat de la fonction 
% filtreSlot dans un fichier texte.
%
% ENTREE
%   full_path_txtFile : nom complet du fichier txt a ouvrir 
%
%
% SORTIE
%   C : tableau contenant les informations du fichier texte, sans les
%   headers


fid   = fopen(full_path_txtFile);
% C = textscan(fid,'%s\t%d\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s'); %cf ecritureFiltrageSlot.m
C = textscan(fid,'%s\t%d\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s');
fclose(fid);

fclose('all');
