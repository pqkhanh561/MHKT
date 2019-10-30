function [max_find, route] = LCM(data)
cost = data(1:end-1,1:end-1);
dem = data(end,1:end-1);
sup = data(1:end-1,end)';
max_find = 0;
route = zeros(size(sup,2),size(dem,2));


while true
    pos_curr = find_minimal(cost);
    if pos_curr == false
        break;
    end
    i = pos_curr(1);
    j = pos_curr(2);
    %%%%%%Var%%%%%%
    %curr_value is a best value
    if check_sup_dem(sup,dem,i,j) == false
            cost(i,j) = nan;
            continue
    end
    curr_value = cost(i,j);
    pos_curr = [i,j];
    
    %Find a best value among many tie minimal value in cost
    T_cost = cost;
    while true
        pos_next = find_minimal(T_cost);
        if pos_next == false
            break;
        end
        if check_sup_dem(sup,dem,pos_next(1),pos_next(2)) == false
            cost(pos_next(1),pos_next(2)) = nan;
            T_cost(pos_next(1),pos_next(2)) = nan;
            continue
        end
        next_value = T_cost(pos_next(1),pos_next(2));
        if curr_value == next_value
           %find max abs of supp vs demand (curr vs others)
           value_next = min(sup(pos_next(1)), dem(pos_next(2)));
           value_curr = min(sup(pos_curr(1)),dem(pos_curr(2)));
           if value_next >= value_curr
              curr_value = next_value;
              pos_curr = pos_next;
              T_cost(pos_curr(1),pos_curr(2)) = nan;
           else
               %Break because optimal position had been found
               break
           end
        else
            %Break because the next position is not tie to the current one
            break;
        end
    end
    
    %After finding best solution. We had position which is optimal (var pos_curr) 
    i = pos_curr(1);
    j = pos_curr(2);
    if sup(i) >= dem(j)
        route(i,j) = route(i,j) + dem(j);
        max_find = max_find + route(i,j)*cost(i,j);
        sup(i) = sup(i) - dem(j);
        dem(j) = 0;
    else
        route(i,j) = route(i,j) + sup(i);
        max_find = max_find + route(i,j)*cost(i,j);
        dem(j) = dem(j) - sup(i);
        sup(i) = 0;
    end
    cost(pos_curr(1), pos_curr(2)) = nan;
end
end