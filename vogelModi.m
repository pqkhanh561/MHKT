function [ibfs,objCost] = vogelModi(data)
% ===DATA PREPARATION===
cost = data(1:end-1,1:end-1);
demand = data(end,1:end-1);
supply = data(1:end-1,end)';
ibfs = zeros(size(cost));

% ===VOGEL APPROXIMATION===
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
disp(ibfs)
disp(sum(sum(cost.*ibfs)))

objCost = sum(sum(ibfs.*cost));
%===MODIFIED DISTRIBUTION ===
val = -1;
while val< 0
    [prow,pcol]=find(ibfs> 0);
    occupiedCells=[prow,pcol]';
    [prow,pcol]=find(ibfs==0);
    unoccupiedCells = [prow,pcol]';

    [r,k] = occupiedSystemSolve(occupiedCells,cost); %need fix
    
    improvementIndex = zeros(length(unoccupiedCells(1,:)),3);
    for i = 1:length(unoccupiedCells(1,:))
        ri = unoccupiedCells(1,i);
        kj = unoccupiedCells(2,i);
        e = cost(ri,kj) - r(ri) - k(kj);
        improvementIndex(i,:) = [ri,kj,e];
    end
    [val,ind] = min(improvementIndex(:,end));
    if val< 0 %check whether improvement is required
        ri = improvementIndex(ind,1);
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

function [r,k] = occupiedSystemSolve(occ,cost)
% ===OTHER REQUIRED FUNCTIONS===
n = size(cost);
m = n(1);
n = n(2);
r = zeros(1,n);
k = zeros(1,m);
A = sym('A',[2,max(m,n)]);
E = [];
value = [];
for i = 1:length(occ)
    value = [value cost(occ(1,i),occ(2,i))];
    E = [E (A(1,occ(1,i))+A(2,occ(2,i)))];
end
E = E==value;
E = [E A(1,1) == 0];
X = solve(E);
X_cell = struct2cell(X);
for i = 1: (m+n)
    if i <= m
        r(i) = X_cell{i};
    else
        k(i-m) = X_cell{i};
    end
end
end

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


function get_possible_next_nodes(loop, not_visited):
    last_node = max(loop);
    nodes_in_row = [n for n in not_visited if n[0] == last_node[0]]
    for i = 1:length(not_visited)
        if not_visited(i)
    end
    nodes_in_column = [n for n in not_visited if n[1] == last_node[1]]
    if len(loop) < 2:
        return nodes_in_row + nodes_in_column
    else:
        prev_node = loop[-2]
        row_move = prev_node[0] == last_node[0]
        if row_move: return nodes_in_column
        return nodes_in_row
        end
    end
    end

function [] = get_loop(bv_positions, ev_positions)
    function  res = inner(loop)
        if len(loop) > 3
            can_be_closed = len(get_possible_next_nodes(loop, ev_position)) == 1;
            if can_be_closed 
                res  = loop;
                return
            end
        end
        not_visited = list(set(bv_positions) - set(loop));
        possible_net_nodes = get_possible_next_nodes(loop, not visited);
        for next_node 
    end
end

