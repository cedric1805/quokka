function [ areamax,IndMin,InMax] = largestAeraHisto( y )
% largestAeraHisto : fonction qui calcul l'aire du rectangle le plus grand
% dans un histogramme.

% EXEMPLE
% INPUT
%     y = [6, 2, 5, 4, 5, 1, 6];
% OUTPUT 
%     areamax = 12
%     IndMin = 2 
%     InMax = 6 

n = length(y);

areamax = 0;

for i=1:n
    t=0;
    while(y(i-t)>=y(i))
        t=t+1;
        if i-t==0
            break
        end%if
    end%while
    indmin=i-t;
    t=0;
    while(y(i+t)>=y(i))
        t=t+1;
        if i+t>n
            break
        end%if
    end%while
    indmax=i+t;
    
%     indmin
%     indmax
    
    area=(indmax-indmin-1)*y(i);
    if area>areamax
        % fprintf('here');
        areamax=area;
        IndMin=indmin;
        InMax=indmax;
    end%if

end%for

% areamax
if areamax == 0
    IndMin=0;
    InMax=0;
end%if


% M1=(InMax+IndMin)/2;

