function [ titre ] = titreFigure_delta( filename,variable_name,num_slot )
% titreFigure : Fonction qui ecrit le titre de la figure !
%
%
% ENTREE
%   filename : nom du fichier contenant la variable a afficher 
%   variable_name : variable a traiter 
%   num_slot : numero du slot ou la variable a ete traite 
%
%
% SORTIE
%   titre



% Titre graphe
file_name = strsplit(filename,'/');
file_name = file_name(end);


c = strsplit(variable_name,'_');
var_name = {''};
for i=1:length(c)
    var_name = strcat(var_name,c{i},{' '});
end%i

c = strsplit(file_name{:},'.');
c = c(1);

date = filename2date( c{:} );

% titre = strcat(date,{':'},{' '},var_name,{':'},{' '},'#',num2str(num_slot));
if nargin > 2
    
    titre = strcat(date,{':'},{' '},var_name,{':'},{' '},'#',num_slot);
else
    titre = strcat(date,{':'},{' '},var_name);
end%if



