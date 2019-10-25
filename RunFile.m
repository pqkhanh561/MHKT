% data = randi(10,4,4);
data = [5 8 4 50,
        6 6 3 40,
        3 9 6 60,
        20 95 35 150];
% 
% data = [2 2 2 1 0 ,
%         10 8 5 4 0 ,
%         7 6 6 8 0
%         0 0 0 0 0];  
% data(1:3,5) = [30 70 50];
% data(4,1:4) = [40 30 40 40];
disp('Du lieu vao')
disp(data)
disp('1) Phuong phap goc tay bac')
[t, r] = NCM(data);
disp(r)
disp('--> Chi phi');
disp(t);

disp('2) Phuong phap han che toi tieu')
[t, r] = LCM(data);
disp(r)
disp('--> Chi phi');
disp(t);

disp('3) Phuong phap xap xi Vogel')
[t , r] = VOGELMETHOD(data);
disp(r)
disp('--> Chi phi');
disp(t);


cost = data(1:end-1,1:end-1);
demand = data(end,1:end-1);
supply = data(1:end-1,end)';

fileID = fopen('route.txt','w');
fprintf(fileID,'%5d',supply);
fprintf(fileID,'\n');
fprintf(fileID,'%5d',demand);
fprintf(fileID,'\n');
for i =1:size(cost,1)
    fprintf(fileID,'%5d',cost(i,:));
    fprintf(fileID,'\n');
end

for i =1:size(r,1)
    fprintf(fileID,'%5d',r(i,:));
    fprintf(fileID,'\n');
end
fclose(fileID);
