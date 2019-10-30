function check = check_sup_dem(supply, demand, poss, posd)
% Check if supplier supply enough for demand 
%   Detailed explanation goes here
if supply(poss) > 0 && demand(posd)>0
    check = true;
elseif supply(poss) ==0 || demand(posd)==0
    check = false;
end
end

