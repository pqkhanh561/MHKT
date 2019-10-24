% data = randi(10,4,4);
% data = [5 8 4 50,
%         6 6 3 40,
%         3 9 6 60,
%         20 95 35 150];
% data = [
data = [2 2 2 1 0 ,
        10 8 5 4 0 ,
        7 6 6 8 0
        0 0 0 0 0];  
data(1:3,5) = [30 70 50];
data(4,1:4) = [40 30 40 40];
disp(data)
[t,r] = vogelModi(data)
% syms x1 x2 x3 y1 y2 y3 z1 z2 z3
% data = data(1:end-1,1:end-1);
% A = [x1 x2 x3,
%     y1 y2 y3,
%     z1 z2 z3];
% tmp = str(sum(sum(data.*A)));
% disp(sum(data(:,end-1).*A(:,end)