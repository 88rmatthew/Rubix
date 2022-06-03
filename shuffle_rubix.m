function shuffle_rubix

%% specify rubik's size
rubix_size = 2;

%% compute possible moves

combs = transpose(combvec(1:3,1:rubix_size,1:2));
hvd = {'h','v','d'};
idx = strtrim(transpose(cellstr(num2str(transpose(1:rubix_size)))));
rtn = {'cw','ccw'};
possible_moves = join([hvd(combs(:,1));idx(combs(:,2));rtn(combs(:,3))]','');

%% get all combinations that will be run

moves = possible_moves(randsample(length(possible_moves),200,true));

%% do the rubix

err = rubix(rubix_size,moves,true);

%% plot err
figure
plot(err,'ok')
xlabel('number of moves')
ylabel('error')

end