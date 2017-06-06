function [ date ] = filename2date( filename )
% filename2date : Fonction qui permet d'extraite la date d'un fichier
% contenant une variable a analyser. Cette fonction est utilise pour
% generer le titre de la figure contenant cette variable
%
%
% ENTREE
%   filename : le nom du fichier contenant une variable a analyser 
%
%
% SORTIE
%   date 

% filename = filename{:};
Y = str2double(filename(2:5));
numd = str2double(filename(6:8));

DateNumber = datenum(Y,0,0) + numd;
date = datestr(DateNumber);