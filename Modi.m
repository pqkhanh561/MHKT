function [ibfs,objCost] = Modi(data)
x=input('enter the transportation matrix');
x=sd('supply; demand');
val = -1;
while val< 0
    [prow,pcol]=find(ibfs> 0);
    occupiedCells=[prow,pcol];
    [prow,pcol]=find(ibfs==0);
    unoccupiedCells = [prow,pcol];
    r = 0;
    k = [column occupied];
    for i = 1:length(occupiedCells(1,:))
        ri = occupiedCells(1,i);
        kj = occupiedCells(2,i);
        [r,k] = occupiedSystemSolve(r,k,ri,kj,cost);
    end
    improvementIndex = zeros(length(unoccupiedCells(1,:)),3);
    
    for i = 1:length(unoccupiedCells(1,:))
        ri = unoccupiedCells(1,i);
        kj = unoccupiedCells(2,i);
        e = cost(ri,kj) - r(ri) - k(kj);
        improvementIndex(i,:) = [ri,kj,e];
    end
    [val,ind] = min(improvementIndex(:,end));
    if val< 0 %check whether improvement is required ri = improvementIndex(ind,1);
        kj = improvementIndex(ind,2);
        disp(['Create a circuit around cell (' num2str(ri) ',' num2str(kj) ')' ]);
        circuitImproved = [ri,kj,0];
        n = input('Enter number of element that forms the circuit: ');
        for i = 1:n
            nCells = input(['Enter the index of cell ' num2str(i) ' that forms the circuit: ']);
            if mod(i,2) == 0
                circuitImproved(i+1,:) = [nCells, ibfs(nCells(1),nCells(2))];
            else
                circuitImproved(i+1,:) = [nCells, -ibfs(nCells(1),nCells(2))];
            end
        end
        ibfs = reallocateDemand(ibfs,circuitImproved);
        disp(ibfs)
        objCost = sum(sum(ibfs.*cost));
    end
end
end

function [r,k] = occupiedSystemSolve(r,k,ri,kj,cost)
if length(r)>=ri
    k(kj) = cost(ri,kj)-r(ri);
else
    r(ri) = cost(ri,kj)-k(kj);
end
end

function [y,demand,supply,ctemp] = chkdemandsupply(demand,supply,ded,sud,ctem)
tempd = demand;
temps = supply;
if tempd(ded) > temps(sud)
    temps(sud) = 0;
    tempd(ded) = demand(ded) - supply(sud);
    y = supply(sud);
    ctem(sud,:) = inf;
else
    if tempd(ded) < temps(sud)
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
    demand =tempd;
    supply = temps;
    ctemp = ctem;
    disp(['the transportation cost is ', sum(sum(ibfs.*cost))]);
end
end