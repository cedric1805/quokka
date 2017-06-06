function [ bbp_lambda_0 ] = bbp_ref_QAA( RRS_ref,RRS_443,RRS_490,RRS_667,wave_ref,aw )
% bbp_ref_QAA : Fonction qui calcul le coefficient de retrodiffusion bbp 
% pour la longueur d'onde de reference. Cette fonction est une partie de
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
%   wave_ref :  longueur d'onde de reference (550;555;560), en nm
%   aw : coefficient d'absorption de l'eau pure, en m^-1, pour la longueur 
%       d'onde de reference. Ce coefficient est fournie dans le pdf suivant:
%       Pope_Fry_Applied_Optics_36_(1997)_8710, selon les travaux de Pope
%       and Fry. Pour wave_ref = 555, on a : aw = 0.0596 m^-1
%
%
% SORTIE
%   bbp_lambda_0 : coefficient de retrodiffuison bbp, en en m^-1, pour la 
%   longueur d'onde de reference de reference 


a_lambda_0 = absorption_ref( RRS_ref,RRS_443,RRS_490,RRS_667,aw );

temp = (-0.0895 + (0.008+0.499.*RRS_ref).^0.5) ./ 0.249;
bb_lambda_0 = (temp.*a_lambda_0) ./ (0.249 - temp);

bbw = b_water( wave_ref ); % MOREL

bbp_lambda_0 = bb_lambda_0 - bbw;


%% Copie des parametres lors des traitements SeaDAS
% QAA v6 processing for 6 bands
% QAA v6 bands: (0) 412 nm, (1) 443 nm, (2) 490 nm, (3) 555 nm, (4) 660 nm
% QAA v6 wav  : 412.000000 443.000000 490.000000 555.000000 660.000000 680.000000
% QAA v6 aw   :   0.004883   0.006377   0.014271   0.057716   0.388044   0.457969
% QAA v6 bbw  :   0.003051   0.002231   0.001450   0.000856   0.000414   0.000366