function affichageCarteData( data, lat,lon, titre, commentaire)
% affichageCarteData : Fonction qui permet d'afficher des donnees en
% fonction de son emprise geographique. On utilise la toolbox m_map1.4.
%
%
% ENTREE
%   data : Matrice des donnees a cartographier
%   lat :  Matrice correspondant aux latitudes des donnees a cartographier 
%   lon :  Matrice correspondant aux longitudes des donnees a cartographier
%   titre :  Titre de la figure
%   commentaire : annotation a inserer dans la figure 
%
%
% SORTIE
%   figure

unite = commentaire{1};

figure
% Initialisation de la projection
m_proj('UTM','longitude',[115 150],'latitude',[20 50],'ellipse','wgs84'); % GOCI area
% Insertion des donnees
m_pcolor(lon,lat,data);
shading flat;
% Création des traits de côtes
m_coast;
% Création de la grille d'affichage
m_grid;
% Insertion titre - légende
title(titre,'fontsize',16,'fontweight','bold');
set(gca,'fontsize',16)
h = colorbar;
ylabel(h,unite);


% % Test 
% m_proj('oblique mercator');
% m_coast;
% m_grid;
