function analyze_rubix_period

%% specify rubik's size
rubix_size = 3;

%% compute possible moves

combs = transpose(combvec(1:3,1:rubix_size,1:2));
hvd = {'h','v','d'};
idx = strtrim(transpose(cellstr(num2str(transpose(1:rubix_size)))));
rtn = {'cw','ccw'};
possible_moves = join([hvd(combs(:,1));idx(combs(:,2));rtn(combs(:,3))]','');

%% get all combinations that will be run

pm = 1:numel(possible_moves);
numchoose = 2;
b = nchoosek(pm,numchoose);
p = perms(1:numchoose);
B = cell(1,size(p,1));
for ip = 1:size(p,1)
    B{ip} = b(:,p(ip,:));
end
B = sortrows(vertcat(B{:}),1:numchoose);
B = possible_moves(B);
B(all(contains(B,'h'),2),:) = [];
B(all(contains(B,'v'),2),:) = [];
B(all(contains(B,'d'),2),:) = [];

%% do the rubix

h = waitbar(0,'analyzing');
numB = size(B,1);
err = cell(1,numB);
for ib = 1:numB
    moves = repmat(B(ib,:),1,5000);
    err{ib} = rubix(rubix_size,moves,false);
    waitbar(ib/numB,h)
end
delete(h)

%% plot err
figure
histogram(cellfun(@numel,err),150)
title('histogram of 3 sequence periods')
xlabel('number of moves')

end