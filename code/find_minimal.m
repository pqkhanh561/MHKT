function  pos = find_minimal(A)
    [m,n] = size(A);
    min_A = realmax;
    vtx = nan;
    vty = nan;
    for i = 1:m
        for j= 1:n
            if A(i,j) < min_A
                min_A = A(i,j);
                vtx = i;
                vty = j;
            end
        end
    end
    if isnan(vtx) || isnan(vty)
        pos =  false;
    else 
        pos = [vtx,vty];
    end
end