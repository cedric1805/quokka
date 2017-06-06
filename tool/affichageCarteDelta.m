function affichageCarteDelta( full_name_1,full_name_2,delta_name,variable_name,lat,lon,out)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

[ data_1 ] = filtre_data( full_name_1,variable_name );
[ data_2 ] = filtre_data( full_name_2,variable_name );

delta = data_2 - data_1;

[ titre ] = titreFigure_delta( full_name_1,variable_name );
titre = strcat(delta_name,{' '},'#',{' '}, titre);
commentaire = annotationFigure( full_name_1,variable_name);
affichageCarteData( delta, lat,lon, titre, commentaire)
titre = strrep(titre,':','_');
titre = strrep(titre,' ','_');
filename = strcat(out,'/',titre{:});
print('-dpng',filename);
close all
end

