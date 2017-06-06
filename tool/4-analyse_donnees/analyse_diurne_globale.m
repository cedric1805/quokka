function analyse_diurne_globale(C_MoyDiurne,variable_name,num_slot)
% Analyse_diurne_globale fonction aui permet de tracer un ensemble de variations
% diurnes sur un meme graphe. 
% 
% ENTREE
%   C_MoyDiurne : cell contenant l'ensemble des informations sur le jeux de
%   donnees a etudier. C_MoyDiurne est genere en lisant le fichier text aui
%   contient ces information, en debut de script
%   variable_name 
%   num_slot : numero du slot (compris entre 1 et 16 inclus)
%
% SORTIE
%   Figure 


m = length(num_slot);
l = length(variable_name);

for k=1:l
    
    moyenne_mois = zeros(m,8);
    mediane_mois = zeros(m,8);
    legende_mois = cell(1,length(m));

    for j=1:m
        % recuperation index de la ligne 
        index_slot = find(C_MoyDiurne{2} == num_slot(j));
        index_var = find(strcmp(C_MoyDiurne{3},variable_name(k)) == 1);
        index = intersect(index_slot,index_var);

        figure;
        c = strsplit(C_MoyDiurne{3}{index(1)},'_');
        var_name = {''};
        for i=1:length(c)
            var_name = strcat(var_name,c{i},{' '});
        end%i
        str1 = strcat('Variation diurne ( ', C_MoyDiurne{5}{index(1)},')');
        str2 = strcat(var_name,{':'},{' '},'#',num2str(num_slot(j)));
        titre = sprintf( '%s\n%s\n',str1,str2{:});

        title(titre,'FontSize',20);
        xlabel('heure ensoleillement');ylabel(C_MoyDiurne{4}{index(1)});

        date = cell(1,length(index)); 
        matrice_data = nan(length(index),8);
        for ii = 1:length(index)
            % recuperation data en fonction de l'index
            colum_start_data = 6; % depend de la construction du fichier.txt
            data = zeros(1,8);
            for i = colum_start_data:size(C_MoyDiurne,2)
                data(i-colum_start_data+1) = str2double(C_MoyDiurne{i}{index(ii)});
            end%i
            matrice_data(ii,:) = data;
            % recuperation des dates associees aux index 
            date{ii} = C_MoyDiurne{1}{index(ii)};

            % tracer
            hold on
            plot(data)
            hold on

        end%k
        
        
        % moyenne et mediane;
        moyenne = zeros(1,8);
        mediane = zeros(1,8);
        for i =1:length(moyenne)
            c = matrice_data(:,i);
            moyenne(i) = mean(c(~isnan(c)));
            mediane(i) = median(c(~isnan(c)));
        end%i
        plot(moyenne,'k:'); hold on; plot(mediane,'k--');
        % ajout de legende mediane et moyenne en fin de liste 
        date{end+1} = 'moyenne'; 
        date{end+1} = 'mediane';
        
        %legende
        legend(date,'Location','bestoutside')
 
        moyenne_mois(j,:) = moyenne;
        mediane_mois(j,:) = mediane;
        legende_mois{j} = strcat('slot#',num2str(num_slot(j)));

       
    end%k
    % tracer des 
    figure
    for i=1:size(mediane_mois,1)
        plot(mediane_mois(i,:))
        hold on
    end
    %legende
    legend(legende_mois,'Location','bestoutside')
    %titre
    str1 = strcat('Mediane des variations diurnes : ', var_name); % changer si calcul de moyenne
    % str2 = strcat('February 2015');
    str2 = strsplit(date{1},'-');
    str2 = strcat(str2(end-1),'-',str2(end)); % dans le cas d'une analyse sur le meme mois
    titre = sprintf( '%s\n%s\n',str1{:},str2{:});
    title(titre,'FontSize',20);
    xlabel('heure ensoleillement');ylabel(C_MoyDiurne{4}{index(1)});
    
end%j