function [ pos_to_supply, route ] = Vogel_method( supply, demand, cost )
%Vogel_method
route = zeros(size(supply,2),size(demand,2));
n = size(cost);
m = n(1);
n = n(2);
% Build a penaty row and column
p_row = [];
p_col = [];
for i = 1:m
    p_row = [p_row find_penaty_value(cost(i,:))];
end

for i = 1:n
    p_col = [p_col find_penaty_value(reshape(cost(:,i),1,[]))];
end

%Choose the highest in penaty => Choose column or row
highest_in_which = true; % True then highest in Row
[highest, highest_pos] = max(p_row);
if highest < max(p_col)
    highest_in_which = false;
    [~, highest_pos] = max(p_col);
end

%Find Cij min in selected column/row
if highest_in_which == true
    pos_to_supply = [find_min_in_arr(cost(highest_pos,:)), highest_pos];
else
    pos_to_supply = [highest_pos, find_min_in_arr(cost(:,highest_pos))];
end


%Supply goods
j = pos_to_supply(1);
i = pos_to_supply(2);
if supply(i) >= demand(j)
    route(i,j) = route(i,j) + demand(j);
    supply(i) = supply(i) - demand(j);
    demand(j) = [];
    cost(:,j) = [];
else
    route(i,j) = route(i,j) + supply(i);
    demand(j) = demand(j) - supply(i);
    supply(i) = [];
    cost(i,:) = [];
end
end

