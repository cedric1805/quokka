function [C] = lectureFiltrageSlot( full_path_txtFile)
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
C = textscan(fid,'%s\t%d\t%d\t%d\t%d\t%d'); %cf ecritureFiltrageSlot.m
fclose(fid);

fclose('all');
