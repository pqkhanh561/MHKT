function [ res ] = find_penaty_value( arr )
%find min and submin in array
n = size(arr);
n = n(2);
res = intmax;
for i = 1:n
    for j = 1:n
        if i ~= j
            res = min(res, abs(arr(i) - arr(j)));
        end
    end
end

