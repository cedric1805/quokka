function [ annotation ] = annotationFigure( filename,variable_name )
% annotationFigure : fonction qui permet de recuperer des annotations
% specifiques a une variable telle que son unite.
%
%
% ENTREE
%   filename : matrice de donnees (OU VECTOR ???)
%   variable_name :  
%   commentaire : commentaire tel que l'unite de la variable
%
%
% SORTIE
%   annotation : information sur la variable, ici l'unite

if strcmp( variable_name,'bbp_555_qqa_v5')
    % cas particulier lors du calcul qqa directement par Matlab
    unite = 'm^-1';
    
elseif strcmp( variable_name,'taua_555')
    % cas particulier lors du calcul taua 
    unite = 'unite';
    
else
    % Unite
    ncid = netcdf.open(filename,'nowrite');
    gid = netcdf.inqNcid(ncid,'geophysical_data');
    varid = netcdf.inqVarID(gid,variable_name);
    unite = netcdf.getAtt(gid,varid,'units');
    netcdf.close(ncid);
    
    % suppression des espaces dans les unites
    % les espaces rendent la lecture du fichier texte impossible 
    tf = isspace(unite);
    unite(isspace(unite)) = '.';
    
end%if


annotation = {unite};

