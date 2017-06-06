function analyse_groupe_delta( full_path_folder_a_analyser,extension,variable_name,outfile )
% Analyse_groupe Fonction qui permet d'extraire les informations d'un jeux
% de donnees journaliers. Les reusltats (moyenne et mediane) sont
% visualiser en sortie a l'aide de Figure et sont ecrit dans un fichier
% texte aui pourra etre reutilise par la suite (cf. analyse_diurne_globale)
% 
% ENTREE
%   full_name : nom du dossier contenant les donnees a analyser
%   variable_name 
%   num_slot : numero du slot (compris entre 1 et 16 inclus)
%
% SORTIE




cell_name_a_analyser = recuperationFileName( full_path_folder_a_analyser, extension );

if ~isempty(cell_name_a_analyser)

    % Parametres filtrage flag
    name_flag = 'CLDICE'; % nuage
    operation_morpho = 'dilate';
    [ index_mask,nbre_mask ] = index_flagMask( cell_name_a_analyser{1},  name_flag);
    
    % Recuperation logitude et latitude
    lon_GOCI = ncread(cell_name_a_analyser{1},'navigation_data/longitude') ; 
    lat_GOCI = ncread(cell_name_a_analyser{1},'navigation_data/latitude') ; 

    n = size(cell_name_a_analyser);
    n = n(2);



    l = length(variable_name);


        for k=1:l
            for i=1:n
                m_filtre = zeros(size(lon_GOCI));   
                if i==1 
                    %initialisation
                    data_brute = ncread(cell_name_a_analyser{i},strcat('geophysical_data','/',variable_name{k}));
%                     m_filtre = zeros(size(data_brute));
                    % etape 1  : filtrage nuage dans portion slot
                    m_nuage = filtreNuage_delta( cell_name_a_analyser{i}, operation_morpho,index_mask,nbre_mask  );
                    % etape 2  : filtrage stat
                    m_stat = filtreStat_delta( cell_name_a_analyser{i},variable_name{k});
                    % etape 3 : filtre commun 
                    m_filtre = m_filtre + m_nuage + m_stat; % nan correspond au pixels non communs ou non traitable
                    
                    data_filtree = data_brute;
                    data_filtree(isnan(m_filtre))= nan;
                    

                    A = cat(3, data_filtree);
                end%if
                
                if i==4 || i==5 || i==8
                    
                    data_brute = ncread(cell_name_a_analyser{i},strcat('geophysical_data','/',variable_name{k}));
%                     m_filtre = zeros(size(data_brute));
                    % etape 1  : filtrage nuage dans portion slot
                    m_nuage = filtreNuage_delta( cell_name_a_analyser{i}, operation_morpho,index_mask,nbre_mask  );
                    % etape 2  : filtrage stat
                    m_stat = filtreStat_delta( cell_name_a_analyser{i},variable_name{k});
                    % etape 3 : filtre commun 
                    m_filtre = m_filtre + m_nuage + m_stat; % nan correspond au pixels non communs ou non traitable
                    
                    data_filtree = data_brute;
                    data_filtree(isnan(m_filtre))= nan;
                    

                    A = cat(3, A, data_filtree);

                end%if
               

            end%i
            % delta des valeurs
            delta_diurne =  A(:,:,4) - A(:,:,1);
            delta_matin =  A(:,:,2) - A(:,:,1);
            delta_aprem =  A(:,:,4) - A(:,:,3);
                        
            % figure
            titre = titreFigure_delta( cell_name_a_analyser{1},variable_name{k} );
            unite = annotationFigure( cell_name_a_analyser{1},variable_name{k});
            
            
            affichageCarteDelta( delta_diurne, lat_GOCI,lon_GOCI, titre,unite,outfile);
            affichageCarteDelta( delta_matin, lat_GOCI,lon_GOCI, titre,unite,outfile);
            affichageCarteDelta( delta_aprem, lat_GOCI,lon_GOCI, titre,unite,outfile);

                     

        end%k

else
    fprintf('dossier vide\n');
end%for

