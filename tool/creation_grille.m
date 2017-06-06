function [ G ] = creation_grille( lat_ref,lon_ref,k,lat,lon,M_data )
% creation_grille Summary of this function goes here
%   Detailed explanation goes here

% 
lon_min = min(lon_ref(:));
lon_max = max(lon_ref(:));
% 
lat_min = min(lat_ref(:));
lat_max = max(lat_ref(:));
% 
min(size(lat_ref));
%
% on cree une matrice carree pour simplifier la projection
cote = min(size(lon_ref));

pas_lon = k*(lon_max-lon_min)/cote;
pas_lat = k*(lat_max-lat_min)/cote;

G = zeros(round(cote/k),round(cote/k));

n =  round(cote/k);
% premiere colonne
for i = 1:n
    for j = 1:n
        
        lat_min = lat_min + (i-1)*pas_lat;
        lat_max = lat_min + i*pas_lat;
        lon_min = lon_min + (i-1)*pas_lon;
        lon_max = lon_min +j*pas_lon;
        good_index_lat = lat >= lat_min & lat <= lat_max;
        good_index_lon = lon >= lon_min & lon <= lon_max;
        good_index = good_index_lon & good_index_lat ;

        M = M_data(good_index);
        M = M(~isnan(M));
%         nnz(isnan(M))
        M = mean(M);

        G(i,j) = M;  
        
    end%j
end%i






% for i=1:size(G,1)
%     for j=1:size(G,2)
%        good_index_lat = lat >= lat_min + (i-1)*pas_lat & lat <= lat_min + i*pas_lat;
%        good_index_lon = lon >= lon_min + (j-1)*pas_lon & lon <= lon_min + j*pas_lon;
%        good_index = good_index_lon & good_index_lat ;
%        
%        M = mean(M_data(good_index));
%        G(i,j) = M;
%     end%j
% end%i