function [ data_GOCI,DMC] = comparaison_GociModis( full_path_folder_a_comparer,extension,variable_name, num_slot,C_FiltrageSlot )
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

%     index_GOCI
%     index_MODIS

for j=1:m
    % zone geographique commune 
    %--------------------------
    index = find(C_FiltrageSlot{2} == num_slot(j));
    coord_slot = [C_FiltrageSlot{end-3}(index), C_FiltrageSlot{end-2}(index), C_FiltrageSlot{end-1}(index), C_FiltrageSlot{end}(index)];

    % recuperation frontiere lon lat du slot en question GOCI
    lon_GOCI = ncread(cell_name_a_comparer{index_GOCI},'navigation_data/longitude') ; 
    lon = lon_GOCI( coord_slot(1) : coord_slot(2) , coord_slot(3) : coord_slot(4) );
    lat_GOCI = ncread(cell_name_a_comparer{index_GOCI},'navigation_data/latitude') ; 
    lat = lat_GOCI( coord_slot(1) : coord_slot(2) , coord_slot(3) : coord_slot(4) );
    F = [lon(1,:)',lat(1,:)' ; lon(:,end),lat(:,end) ; lon(end,:)',lat(end,:)' ; lon(:,1),lat(:,1)];

    % calcul minimum distance MODIS GOCI de la frontiere du slot 
    lon_MODIS = ncread(cell_name_a_comparer{index_MODIS},'navigation_data/longitude') ; 
    lat_MODIS = ncread(cell_name_a_comparer{index_MODIS},'navigation_data/latitude') ; 
    M = [lon_MODIS(:), lat_MODIS(:)];
    % filtrage longitude
    good_index_long = M(:,1) >= min(F(:,1)) &  M(:,1) <= max(F(:,1)); 
    M = M(good_index_long,:);
    % filtrage latitude
    good_index_lat = M(:,2) >= min(F(:,2)) &  M(:,2) <= max(F(:,2)); 
    M = M(good_index_lat,:);

    if ~isempty(M)
        FM = zeros(length(F),3); % frontiere MODIS du slot
        for i=1:length(F)
            dist =  sqrt( ( F(i,1) - M(:,1) ).^2 + ( F(i,2) - M(:,2) ).^2 );
            [min_dist,ind_dist] = min( dist );
            FM(i,:) = [M(ind_dist,1),M(ind_dist,2),min_dist];
        end%i

        % filtrage distance
        seuil_distance = 0.1;
        good_index_dist = (FM(:,3) < seuil_distance);
        FM = FM(good_index_dist,:);

        X = FM(:,1);
        Y = FM(:,2);
        K = convhull(X,Y);
        matrice_commun_slot = inpolygon(lon_MODIS,lat_MODIS,X(K),Y(K));

        % plot(X,Y,'b+',X(K),Y(K),'r-')
        % plot(lon_MODIS(IN),lat_MODIS(IN),'g*')

        % Comparaison avec grille commune 


        for k=1:l
            % recuperation variable GOCI traite
            %----------------------------------
            [ lon_GOCI,lat_GOCI,data_GOCI,M_lon,M_lat,M_data ] = analyse_indiv( cell_name_a_comparer{index_GOCI},variable_name{k},num_slot(j),C_FiltrageSlot );


        %     
        %     data_brute_GOCI = ncread(cell_name_a_comparer{2},strcat('geophysical_data','/',variable_name{k}));
        %     data_slot_GOCI = data_brute_GOCI(coord_slot(1):coord_slot(2) , coord_slot(3):coord_slot(4));
        %     m_filtre = zeros(size(data_slot_GOCI));
        %     for i = 1:1
        %         % etape 1  : filtrage nuage dans portion slot
        %         m_nuage = filtreNuage( cell_name_a_comparer{2}, num_slot(1),C_FiltrageSlot, 'dilate',index_mask,nbre_mask  );
        %         % etape 2  : filtrage stat
        %         m_stat = filtreStat( cell_name_a_comparer{2},variable_name{k}, num_slot(1),C_FiltrageSlot);
        %         % etape 3 : filtre commun 
        %         m_filtre = m_filtre + m_nuage + m_stat; % nan correspond au pixels non communs ou non traitable 
        %     end%i
        %     m_filtre = ~isnan(m_filtre);


            % attributs communs 
            %--------------------------
            data_brute_MODIS= ncread(cell_name_a_comparer{index_MODIS},strcat('geophysical_data','/',variable_name{k}));
            data_MODIS = [lon_MODIS(matrice_commun_slot), lat_MODIS(matrice_commun_slot), data_brute_MODIS(matrice_commun_slot) ] ;
            % data_GOCI = [lon(m_filtre),lat(m_filtre),data_slot_GOCI(m_filtre)];
            data_GOCI = [lon_GOCI,lat_GOCI,data_GOCI];

            DMC = zeros(length(data_GOCI),4); % data MODIS communes
            for i=1:length(data_GOCI)
                dist =  sqrt( ( data_GOCI(i,1) - data_MODIS(:,1) ).^2 + ( data_GOCI(i,2) - data_MODIS(:,2) ).^2 );
                [min_dist,ind_dist] = min( dist );
                DMC(i,:) = [data_MODIS(ind_dist,1),data_MODIS(ind_dist,2),data_MODIS(ind_dist,3),min_dist];
            end%i

            % filitrage distance
            seuil_distance = 0.1;
            good_index_dist = (DMC(:,end) < seuil_distance);
            DMC = DMC(good_index_dist,:);
            data_GOCI = data_GOCI(good_index_dist,:);

            % filitrage valeur nan
            good_index_value = ~isnan(DMC(:,3));
            DMC = DMC(good_index_value,:);
            data_GOCI = data_GOCI(good_index_value,:);
            
            if ~isempty(DMC)
                %affichage 
                unite = annotationFigure( cell_name_a_comparer{index_GOCI},variable_name{k});
                figure;clf
                subplot(2,1,1);plot(DMC(:,3),data_GOCI(:,3),'.','Color',[250 139 75] ./ 255);xlabel('MODIS');ylabel('GOCI');hold on;plot(data_GOCI(:,3),data_GOCI(:,3),'k');title('GOCI en fonction de MODIS')
                subplot(2,1,2);plot(data_GOCI(:,3));hold on;plot(DMC(:,3),'r');ylabel(unite);title('signal');legend('GOCI','MODIS','Location','northwest');
                [ax1,h1]=suplabel('index pixels');
                

                info_slot = strcat(num2str(C_FiltrageSlot{3}(index)),'#',num2str(num_slot(j)));
                titre = titreFigure( cell_name_a_comparer{index_GOCI},variable_name{k}, info_slot);
                [ax4,h3]=suplabel(titre{:},'t');
                set(h3,'FontSize',20)

                % affichage Yannick !
                figure;
                density(DMC(:,3), data_GOCI(:,3));xlabel('MODIS');ylabel('GOCI');
                [ax4,h3]=suplabel(titre{:},'t');
                set(h3,'FontSize',20)            
            else
                str = strcat('\t','Filtrage MODIS trop strict : ', variable_name{k},'#slot#',num2str(num_slot(j)),'\n');
                fprintf(str);
            end%if
        end%k  
    else
        str = strcat('No DATA : #',num2str(num_slot(j)),'#slot','\n');
        fprintf(str); 
        % ouput
        data_GOCI = nan;
        DMC = nan;
    end%if 
end%j