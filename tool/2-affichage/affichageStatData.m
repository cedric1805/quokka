function affichageStatData( data,titre,commentaire )
% affichageStatData : fonction qui cree une figure sur les informations 
% statistiques d'une variable patriculiere. On trace l'histogramme et on
% insere les annotations de bases pour caracteriser la distribution de
% cette derniere.
%
%
% ENTREE
%   data : matrice de donnees (OU VECTOR ???)
%   titre :  
%   commentaire : commentaire tel que l'unite de la variable
%
%
% SORTIE
%   figure

M = data(~isnan(data)); % sans NaN

min_data = min(M);
max_data = max(M);

mediane_data = median(M);
moyenne_data = mean(M);
sigma_data = std(M);


unite = commentaire{1};

figure 
% histogram(M); % Matlab2016
hist(M,100); fprintf('utiliser la fonction histogramm à la place de la fonction hist si Matlab 2016\n');  % Matlab2013
str = {strcat('Unite :',unite), strcat('Min :',num2str(min_data)),...
    strcat('Max :',num2str(max_data)),...
    strcat('Etendue :',num2str(max_data-min_data)),...
    strcat('Mediane :',num2str(mediane_data)),...
    strcat('Moyenne :',num2str(moyenne_data)),...
    strcat('Sigma :',num2str(sigma_data))};
% t = annotation('textbox'); %MAC
% t.Position = [0.6 0.7 0.1 0.1]; %MAC
% t.String = str; %MAC

dim = [0.6 0.7 0.1 0.1]; %W10
annotation('textbox',dim,'String',str,'FitBoxToText','on'); %W10

title(titre)