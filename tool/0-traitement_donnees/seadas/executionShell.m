function executionShell( full_path_script,l2prod )
% executionShell : Fonction qui execute un .sh depuis Matlab.
% Pour continuer a travailler sur Matlab, le shell peut etre execute
% dans la console directement 'sh scriptname.sh'
%
% ENTREE
%   full_path_script : chemin complet du script
%   l2prod : liste des produits (pour rappel)
%
% SORTIE
%   execution dans un terminal, verifier la memoire dans l'Activity Monitor
%   si besoin

button = questdlg(strcat('Ca va etre long !!! Do you want to continue ?','l2prod : ',l2prod),...
'Continue Operation','Yes','No','Help','No');
if strcmp(button,'Yes')
   disp('Creating file')
   system(full_path_script); % execution du .sh
elseif strcmp(button,'No')
   disp('Canceled file operation')
elseif strcmp(button,'Help')
   disp('Sorry, no help available')
end
