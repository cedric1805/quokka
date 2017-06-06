function [ G_GOCI,G_MODIS] = comparaison_GociModis_grille( full_path_folder_a_comparer,extension,variable_name, num_slot,C_FiltrageSlot,param_grille )
% comparaison_GociModis Fonction aui compare une image GOCI avec une image
% MODIS.

cell_name_a_comparer = recuperationFileName( full_path_folder_a_comparer,extension);
n = size(cell_name_a_comparer);
n = n(2);

m = length(num_slot);
l = length(variable_name);


% recuperation des index correspondant aux noms des images GOCI ou MODIS 
for i=1:n
    C = strsplit(cell_name_a_comparer{i},'/');
    namefile = C(end);
    namefile = namefile{:};
    if strcmp(namefile(1),'G') 
        % GOCI
        index_GOCI = i;
    end%if

    if strcmp(namefile(1),'A')
        index_MODIS = i;
    end%if
end%i


for j=1:m
    for k=1:l
        % recuperation lon lat reference
        index = find(C_FiltrageSlot{2} == num_slot(j));
        coord_slot = [C_FiltrageSlot{end-3}(index), C_FiltrageSlot{end-2}(index), C_FiltrageSlot{end-1}(index), C_FiltrageSlot{end}(index)];   
        lon_ref = ncread(cell_name_a_comparer{index_GOCI},'navigation_data/longitude') ; 
        lon_ref = lon_ref( coord_slot(1) : coord_slot(2) , coord_slot(3) : coord_slot(4) );
        lat_ref = ncread(cell_name_a_comparer{index_GOCI},'navigation_data/latitude') ; 
        lat_ref = lat_ref( coord_slot(1) : coord_slot(2) , coord_slot(3) : coord_slot(4) );

        % recuperation lon lat data GOCI
        [ lon_GOCI,lat_GOCI,data_GOCI,M_lon,M_lat,M_data ] = analyse_indiv( cell_name_a_comparer{index_GOCI},variable_name{k},num_slot(j),C_FiltrageSlot );
        if ~nnz(~isnan(data_GOCI)) == 0 && ~isempty(data_GOCI)
            % data_GOCI non vide et non NaN
            
            % remplissage grille
            [ G_GOCI ] = creation_grille( lat_ref,lon_ref,param_grille,M_lat,M_lon,M_data );
            % recuperation lon lat data MODIS
            lon_MODIS = ncread(cell_name_a_comparer{index_MODIS},'navigation_data/longitude') ; 
            lat_MODIS = ncread(cell_name_a_comparer{index_MODIS},'navigation_data/latitude') ; 
            data_brute_MODIS= ncread(cell_name_a_comparer{index_MODIS},strcat('geophysical_data','/',variable_name{k}));
            % remplissage grille
            [ G_MODIS ] = creation_grille( lat_ref,lon_ref,param_grille,lat_MODIS,lon_MODIS,data_brute_MODIS );


            % filitrage valeur nan
            data_GOCI = G_GOCI(:);
            data_MODIS = G_MODIS(:);

        else
            str = strcat('No DATA : #',num2str(num_slot(j)),'#slot','\n');
            fprintf(str); 
            data_GOCI = []; 
            data_MODIS = [];
        end %if
        
        
        if ~isempty(data_GOCI) || ~isempty(data_MODIS)

            %affichage 
            unite = annotationFigure( cell_name_a_comparer{index_GOCI},variable_name{k});
            figure;clf
            subplot(2,1,1);plot(data_MODIS,data_GOCI,'.','Color',[250 139 75] ./ 255);hold on;;xlabel('MODIS');ylabel('GOCI');plot(data_GOCI,data_GOCI,'k');title('GOCI en fonction de MODIS')
            subplot(2,1,2);plot(data_GOCI);hold on;plot(data_MODIS,'r');ylabel(unite);title('signal');legend('GOCI','MODIS','Location','northwest');
            [ax1,h1]=suplabel('index pixels');
            titre = titreFigure( cell_name_a_comparer{index_GOCI},variable_name{k}, num2str(num_slot(j)));
            [ax4,h3]=suplabel(titre{:},'t');
            set(h3,'FontSize',20)

            % affichage Yannick !
            figure;
            density(data_MODIS, data_GOCI);xlabel('MODIS');ylabel('GOCI');
            [ax4,h3]=suplabel(titre{:},'t');
            set(h3,'FontSize',20)   
        
        else 
            str = strcat('No DATA : #',num2str(num_slot(j)),'#slot','\n');
            fprintf(str); 
        end

    end%k
end%j