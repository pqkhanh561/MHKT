function [y,demand,supply,ctemp] = chkdemandsupply(demand,supply,ded,sud,ctem)
tempd = demand;
temps = supply;
if tempd(ded) > temps(sud)
    temps(sud) = 0;
    tempd(ded) = demand(ded) - supply(sud);
    y = supply(sud);ctem(sud,:) = inf;
elseif tempd(ded) < temps(sud)
    tempd(ded) = 0;
    temps(sud) = supply(sud) - demand(ded);
    y = demand(ded);
    ctem(:,ded) = inf;
elseif tempd(ded) == temps(sud)
    tempd(ded) = 0;
    temps(sud) = 0;
    y = demand(ded);
    ctem(:,ded) = inf;
    ctem(sud,:) = inf;
end
demand = tempd;
supply = temps;
ctemp = ctem;
end
