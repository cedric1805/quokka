function [ rrs ] = RRS2rrs( RRS )
% RRS2rrs : Fonction permet de pqsser de RRS a rrs. Cette fonction est une partie de
% l'algorithme QAA_v5. Cet algorithme est fourmie en pdf dans le dossier
% contenant ce code ou peut etre telecharge a l'adresse suivante : 
% http://www.ioccg.org/groups/Software_OCA/QAA_v5.pdf
%
%
% ENTREE
%   RRS : Reflectance de teledetection en str^-1
%
%
% SORTIE
%   rrs : Reflectance de teledetection en str^-1


rrs = RRS./(0.52 + 1.7.*RRS);
