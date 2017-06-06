function analyse_groupe( full_path_folder_a_analyser,extension,variable_name, num_slot,C_FiltrageSlot )
% Analyse_groupe Fonction qui permet d'extraire les informations d'un jeux
% de donnees journaliers. Les reusltats (moyenne et mediane) sont
% visualiser en sortie a l'aide de Figure et sont ecrit dans un fichier
% texte ui pourra etre reutilise par la suite (cf. analyse_diurne_globale)
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


    n = size(cell_name_a_analyser);
    n = n(2);

    m = length(num_slot);

    l = length(variable_name);

    for j=1:m
        for k=1:l
            % recuperation des pixels communs et traitables 
            % initialisation
            % on recupere la taille du slot en prenant la premierere image
            data_brute = ncread(cell_name_a_analyser{1},strcat('geophysical_data','/',variable_name{k}));
    %         C_FiltrageSlot = lectureFiltrageSlot( full_path_txtFile_Slot);
            index = find(C_FiltrageSlot{2} == num_slot(j));
            coord_slot = [C_FiltrageSlot{end-3}(index), C_FiltrageSlot{end-2}(index), C_FiltrageSlot{end-1}(index), C_FiltrageSlot{end}(index)];
            data_slot = data_brute(coord_slot(1):coord_slot(2) , coord_slot(3):coord_slot(4));
            m_filtre = zeros(size(data_slot));
            for i = 1:n
                % etape 1  : filtrage nuage dans portion slot
                m_nuage = filtreNuage( cell_name_a_analyser{i}, num_slot(j),C_FiltrageSlot, operation_morpho,index_mask,nbre_mask  );
                % etape 2  : filtrage stat
                m_stat = filtreStat( cell_name_a_analyser{i},variable_name{k}, num_slot(j),C_FiltrageSlot);
                % etape 3 : filtre commun 
                m_filtre = m_filtre + m_nuage + m_stat; % nan correspond au pixels non communs ou non traitable 
            end%i

            %pixels communs
            index_commun = find(~isnan(m_filtre) == 1);

            % analyse des donnnes sur les zonnes communes
            moyenne = zeros(1,n);
            mediane = zeros(1,n);
            for i = 1:n
                if ~isempty(index_commun)
                % donnees brutes 
                data_brute = ncread(cell_name_a_analyser{i},strcat('geophysical_data','/',variable_name{k}));
            %     size(data_brute)
                % donnees brutes slot
                data_slot = data_brute(coord_slot(1):coord_slot(2) , coord_slot(3):coord_slot(4));
            %     size(data_slot)
                % donnees zone commune 
                data_communes = data_slot(index_commun);
%                 if i==1 
%                     %initialisation
%                     m_data_communes = nan(size(data_slot));
%                     m_data_communes(index_commun) = data_communes;
%                     A = cat(3, m_data_communes);
%                 end
%                 
%                 if i==4 || i==5 || i==8
%                     m_data_communes = nan(size(data_slot));
%                     m_data_communes(index_commun) = data_communes;
%                     A = cat(3, A, m_data_communes);
% 
%                 end
%             %     size(data_communes)
                moyenne(i) = mean(data_communes);
                mediane(i) = median(data_communes);

                end%if
            
                   
            end%i
%             A;
%             % delta des valeurs
%             delta_diurne =  A(:,:,4) - A(:,:,1);
%             delta_matin =  A(:,:,2) - A(:,:,1);
%             delta_aprem =  A(:,:,4) - A(:,:,3);
%             
%             lon_GOCI = ncread(cell_name_a_analyser{1},'navigation_data/longitude') ; 
%             lon = lon_GOCI( coord_slot(1) : coord_slot(2) , coord_slot(3) : coord_slot(4) );
%             lat_GOCI = ncread(cell_name_a_analyser{1},'navigation_data/latitude') ; 
%             lat = lat_GOCI( coord_slot(1) : coord_slot(2) , coord_slot(3) : coord_slot(4) );
%             %affichageCarteData( delta_diurne, lat,lon, 'titre', unite)

            titre = titreFigure( cell_name_a_analyser{i},variable_name{k}, num2str(num_slot(j)));
            if ~isempty(index_commun)
                unite = annotationFigure( cell_name_a_analyser{i},variable_name{k});

    %             affichageCarteData( delta_diurne, lat,lon, 'titre', unite)

                % affichage analyse groupe
                figure;clf
                subplot(2,1,1);plot(moyenne);ylabel(unite);title('moyenne')
                subplot(2,1,2);plot(mediane);ylabel(unite);title('mediane')
                [ax1,h1]=suplabel('nbre image');
                % titre = titreFigure( cell_name_a_analyser{i},variable_name{k}, num2str(num_slot(j)));
                [ax4,h3]=suplabel(titre{:},'t');
                set(h3,'FontSize',20)
            else
                fprintf('=====================================\n');
                fprintf('pas de pixels communs sur la journée :\n');
                fprintf(strcat(titre{:},'\n'));
                fprintf('=====================================\n');
            end%if


%             % ecriture des donnees 
%             % recuperation info donnee
%             file_name = strsplit(cell_name_a_analyser{i},'/');
%             file_name = file_name(end);
%             c = strsplit(file_name{:},'.');
%             c = c(1);
%             date = filename2date( c{:} );
%             unite = unite{:};
%             A = {date,num_slot(j),variable_name{k},unite,'moyenne',num2str(moyenne)};
%             B = {date,num_slot(j),variable_name{k},unite,'mediane',num2str(mediane)};
% 
%             txtname_moy = 'MoyenneDiurne-GOCI-june2015.txt';
%             txtname_med = 'MedianeDiurne-GOCI-june2015.txt';
%     %         full_path_txtFile_MoyDiurne = strcat(full_path_folder_a_analyser,'/',txtname_moy);
%     %         full_path_txtFile_MedianeDiurne = strcat(full_path_folder_a_analyser,'/',txtname_med);
%             full_path_txtFile_MoyDiurne = strcat('/Users/cmenut/Desktop/V3/1-donnees_traitees/2_a_analyser_groupe','/',txtname_moy);
%             full_path_txtFile_MedianeDiurne = strcat('/Users/cmenut/Desktop/V3/1-donnees_traitees/2_a_analyser_groupe','/',txtname_med);
%             ecritureStatDiurne( A,full_path_txtFile_MoyDiurne );
%             ecritureStatDiurne( B,full_path_txtFile_MedianeDiurne );

        end%k
    end%j
else
    fprintf('dossier vide\n');
end%for

