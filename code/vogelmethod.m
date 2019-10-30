function [ cp, ibfs ] = VOGELMETHOD( data )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
cost = data(1:end-1,1:end-1);
demand = data(end,1:end-1);
supply = data(1:end-1,end)';
ibfs = zeros(size(cost));
ctemp = cost;
%temporal cost matrix
while length(find(demand==0)) < length(demand) || length(find(supply==0)) < length(supply)
    prow = sort(ctemp,1);
    prow = prow(2,:) - prow(1,:);
    %row penalty
    pcol = sort(ctemp,2);
    pcol = pcol(:,2) - pcol(:,1);
    %column penaltyvo
    [rmax,rind] = max(prow);
    [cmax,cind] = max(pcol);
    if rmax>cmax
        [~,mind] = min(ctemp(:,rind));
        [amt,demand,supply,ctemp] = chkdemandsupply(demand,supply,rind,mind,ctemp);
        ibfs(mind,rind) = amt;
    elseif cmax>= rmax
        [~,mind] = min(ctemp(cind,:));
        [amt,demand,supply,ctemp] = chkdemandsupply(demand,supply,mind,cind,ctemp);
        ibfs(cind,mind) = amt;
    end
end
% disp(ibfs)
% disp(sum(sum(cost.*ibfs)))
cp = sum(sum(cost.*ibfs));
end

