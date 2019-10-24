% data = randi(10,4,4);
data = [5 8 4 50,
        6 6 3 40,
        3 9 6 60,
        20 95 35 150];
data(:,4) = [50 40 60 150];
data(4,:) = [20 95 35 150];
disp(data)
[t,r] = vogelModi(data)
% syms x1 x2 x3 y1 y2 y3 z1 z2 z3
% data = data(1:end-1,1:end-1);
% A = [x1 x2 x3,
%     y1 y2 y3,
%     z1 z2 z3];
% tmp = str(sum(sum(data.*A)));
% disp(sum(data(:,end-1).*A(:,end)