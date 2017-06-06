function [ bbw ] = b_water( wave )
%b_water fonction qui calcul le coefficient de retrodiffusion pour le cas
%de l'eau pure.

% SOURCE : 
% MOREL & SHIFRIN :
% Optical backscattering properties of the ?clearest? natural waters
% 
% MOREL bis :
% manuscrit_these_M_Kheireddine 

% MOREL
bbw = 3.5*power(wave/450,-4.32)*0.001;

% % MOREL
% bbw_MOREL = 3.5*power(wave/450,-4.32)*0.001;
% % MOREL bis 
% bbw_MORELbis = 2.88*power(wave/500,-4.3)*0.001;
% % SHIFRIN  
% bbw_SHIFRIN = 1.49*power(wave/546,-4.17)*0.001;
% 
% bbw = [bbw_MOREL,bbw_MORELbis,bbw_SHIFRIN];