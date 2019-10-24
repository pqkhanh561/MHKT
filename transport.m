supply = [50,40,60];
demand = [20,95,35];

costs = [[5,8,4],
        [6,6,3],
        [3,9,6]];
    
[vt, route] = Vogel_method(supply,demand,costs);
disp(vt)
disp(route)
