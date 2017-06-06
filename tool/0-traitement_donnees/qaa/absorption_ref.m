function [ a_lambda_0 ] = absorption_ref( RRS_ref,RRS_443,RRS_490,RRS_667,aw )
% absorption_ref : Fonction qui calcule le coefficient d'absorption associe
% a la longueur d'onde de reference. Cette fonction est une partie de
% l'algorithme QAA_v5. Cet algorithme est fourmie en pdf dans le dossier
% contenant ce code ou peut etre telecharge a l'adresse suivante : 
% http://www.ioccg.org/groups/Software_OCA/QAA_v5.pdf
%
%
% ENTREE
%   RRS_ref : Reflectance de teledetection pour la longueur d'onde de
%             reference (550;555;560) en str^-1
%   RRS_443 :  Reflectance de teledetection pour 443nm, en str^-1
%   RRS_490 :  Reflectance de teledetection pour 490nm, en str^-1
%   RRS_667 :  Reflectance de teledetection pour 667nm, en str^-1
%   aw : coefficient d'absorption de l'eau pure, en m^-1, pour la longueur 
%       d'onde de reference. Ce coefficient est fournie dans le pdf suivant:
%       Pope_Fry_Applied_Optics_36_(1997)_8710, selon les travaux de Pope
%       and Fry.
%
%
% SORTIE
%   a_lambda_0 : coefficient d'absorption de reference en m^-1


khi = log10( (RRS2rrs(RRS_443) + RRS2rrs(RRS_490)) ./ (RRS2rrs(RRS_ref)+5.*(RRS2rrs(RRS_667)./RRS2rrs(RRS_490)).*RRS2rrs(RRS_667)  ) );
a_lambda_0 = aw + 10.^(-1.146-1.366.*khi-0.469.*khi.*khi);