function [max_find, route] = NCM(data)
%Northwest Corner Method
%  max_find: contain sum of the optimal route
%  route: matrix present for optimal path
cost = data(1:end-1,1:end-1);
dem = data(end,1:end-1);
sup = data(1:end-1,end)';
route = zeros(size(sup,2),size(dem,2));
i = 1;
j = 1;
max_find = 0;
while true
    if sup(i) >= dem(j)
        route(i,j) = route(i,j) + dem(j);
        max_find = max_find + route(i,j)*cost(i,j);
        sup(i) = sup(i) - dem(j);
        dem(j) = 0;
        j = j + 1;
    else
        route(i,j) = route(i,j) + sup(i);
        max_find = max_find + route(i,j)*cost(i,j);
        dem(j) = dem(j) - sup(i);
        sup(i) = 0;
        i = i + 1;
    end
    if i > size(sup,2)
        break
    end
    if j > size(dem,2)
        break
    end
    
end
end

