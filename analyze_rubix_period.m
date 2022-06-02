function analyze_rubix_period

%% get all combinations that will be run
possible_moves = {'h1cw','h2cw','h3cw','h1ccw','h2ccw','h3ccw','v1cw','v2cw','v3cw','v1ccw','v2ccw','v3ccw','d1cw','d2cw','d3cw','d1ccw','d2ccw','d3ccw'};
pm = 1:numel(possible_moves);
numchoose = 3;
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
    moves = repmat(B(ib,:),1,1000);
    err{ib} = rubix(moves);
    waitbar(ib/numB,h)
end
delete(h)
%% plot err
figure
histogram(cellfun(@numel,err),150)
title('histogram of 3 sequence periods')
xlabel('number of moves')


end