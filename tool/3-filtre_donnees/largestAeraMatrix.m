function [row_min,row_max,col_min,col_max] = largestAeraMatrix( A )
% largestAeraMatrix : Fonction aui calcul les coordonnees du plus grand
% rectangle compose de 1 dans une matrice composee de 1 et de 0.

% EXEMPLE
% INPUT
%     A = [1,1,0,0,1,0 ; 0,1,1,1,1,1 ; 1,1,1,1,1,0 ; 0,0,1,1,0,0 ];
% OUTPUT 
%     areamax = 8 
%     col_min = 2
%     col_max = 5
%     row_max = 3
%     row_min = 2

% Traitement de 38 min pour matrice de taille 5567x5685

areamax = 0;
n = size(A);
% Calculate Auxilary matrix S 
S = A;
for i=2:n(1)
    for j=1:n(2)
        if (S(i,j) == 1)
            % A(i,j) = A(i-1,j) + 1;
            S(i,j) = S(i-1,j) + 1;
        end%if
    end%j
end%i

% Calculate maximum area in S for each row 
for i=1:n(1)
    [area,IndMin,InMax] = largestAeraHisto( S(i,:));
    if area>areamax
        areamax=area;
        col_min = IndMin + 1;
        col_max = InMax - 1;
        row_max = i;
        row_min = row_max - areamax/(col_max-col_min+1) + 1;
%         if IndMin > 0 && InMax > 0
%             col_min = IndMin + 1;
%             col_max = InMax - 1;
%             row_max = i;
%             row_min = row_max - areamax/(col_max-col_min+1) + 1;
%         end%if
    end%if
end%i