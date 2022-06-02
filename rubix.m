function err = rubix(moves)
% The rubix function houses the construction, visualization, and movement
% algorithms for an n-sized rubik's cube.
%
% This all depends on an established convention based on a geometrically
% proper xyz coordinate system.
%
% The unfolded cube pattern is shown below. These patterns are
% representative only, and the algorithm has been generalized to accomodate
% the construction of any n-sized rubik's cube (min = 2:increments of 1:max = your computer memory).
% r.unqids = {...
%     NaN,    NaN,    NaN,    'r11',  'r12',  'r13',  NaN,    NaN,    NaN,    NaN,    NaN,    NaN;...
%     NaN,    NaN,    NaN,    'r21',  'r22',  'r23',  NaN,    NaN,    NaN,    NaN,    NaN,    NaN;...
%     NaN,    NaN,    NaN,    'r31',  'r32',  'r33',  NaN,    NaN,    NaN,    NaN,    NaN,    NaN;...
%     'b11',  'b12',  'b13',  'w11',  'w12',  'w13',  'g11',  'g12',  'g13',  'y11',  'y12',  'y13';...
%     'b21',  'b22',  'b23',  'w21',  'w22',  'w23',  'g21',  'g22',  'g23',  'y21',  'y22',  'y23';...
%     'b31',  'b32',  'b33',  'w31',  'w32',  'w33',  'g31',  'g32',  'g33',  'y31',  'y32',  'y33';...
%     NaN,    NaN,    NaN,    'o11',  'o12',  'o13',  NaN,    NaN,    NaN,    NaN,    NaN,    NaN;...
%     NaN,    NaN,    NaN,    'o21',  'o22',  'o23',  NaN,    NaN,    NaN,    NaN,    NaN,    NaN;...
%     NaN,    NaN,    NaN,    'o31',  'o32',  'o33',  NaN,    NaN,    NaN,    NaN,    NaN,    NaN;...
%     };
% r.x = [...
%     NaN,    NaN,    NaN,    0.5,    1.5,    2.5,    NaN,    NaN,    NaN,    NaN,    NaN,    NaN;...
%     NaN,    NaN,    NaN,    0.5,    1.5,    2.5,    NaN,    NaN,    NaN,    NaN,    NaN,    NaN;...
%     NaN,    NaN,    NaN,    0.5,    1.5,    2.5,    NaN,    NaN,    NaN,    NaN,    NaN,    NaN;...
%     0,      0,      0,      0.5,    1.5,    2.5,    3,      3,      3,      2.5,    1.5,    0.5;...
%     0,      0,      0,      0.5,    1.5,    2.5,    3,      3,      3,      2.5,    1.5,    0.5;...
%     0,      0,      0,      0.5,    1.5,    2.5,    3,      3,      3,      2.5,    1.5,    0.5;...
%     NaN,    NaN,    NaN,    0.5,    1.5,    2.5,    NaN,    NaN,    NaN,    NaN,    NaN,    NaN;...
%     NaN,    NaN,    NaN,    0.5,    1.5,    2.5,    NaN,    NaN,    NaN,    NaN,    NaN,    NaN;...
%     NaN,    NaN,    NaN,    0.5,    1.5,    2.5,    NaN,    NaN,    NaN,    NaN,    NaN,    NaN;...
%     ];
% r.y = [...
%     NaN,    NaN,    NaN,    3,      3,      3,      NaN,    NaN,    NaN,    NaN,    NaN,    NaN;...
%     NaN,    NaN,    NaN,    3,      3,      3,      NaN,    NaN,    NaN,    NaN,    NaN,    NaN;...
%     NaN,    NaN,    NaN,    3,      3,      3,      NaN,    NaN,    NaN,    NaN,    NaN,    NaN;...
%     2.5,    2.5,    2.5,    2.5,    2.5,    2.5,    2.5,    2.5,    2.5,    2.5,    2.5,    2.5;...
%     1.5,    1.5,    1.5,    1.5,    1.5,    1.5,    1.5,    1.5,    1.5,    1.5,    1.5,    1.5;...
%     0.5,    0.5,    0.5,    0.5,    0.5,    0.5,    0.5,    0.5,    0.5,    0.5,    0.5,    0.5;...
%     NaN,    NaN,    NaN,    0,      0,      0,      NaN,    NaN,    NaN,    NaN,    NaN,    NaN;...
%     NaN,    NaN,    NaN,    0,      0,      0,      NaN,    NaN,    NaN,    NaN,    NaN,    NaN;...
%     NaN,    NaN,    NaN,    0,      0,      0,      NaN,    NaN,    NaN,    NaN,    NaN,    NaN;...
%     ];
% r.z = [...
%     NaN,    NaN,    NaN,    0.5,    0.5,    0.5,    NaN,    NaN,    NaN,    NaN,    NaN,    NaN;...
%     NaN,    NaN,    NaN,    1.5,    1.5,    1.5,    NaN,    NaN,    NaN,    NaN,    NaN,    NaN;...
%     NaN,    NaN,    NaN,    2.5,    2.5,    2.5,    NaN,    NaN,    NaN,    NaN,    NaN,    NaN;...
%     0.5,    1.5,    2.5,    3,      3,      3,      2.5,    1.5,    0.5,    0,      0,      0;...
%     0.5,    1.5,    2.5,    3,      3,      3,      2.5,    1.5,    0.5,    0,      0,      0;...
%     0.5,    1.5,    2.5,    3,      3,      3,      2.5,    1.5,    0.5,    0,      0,      0;...
%     NaN,    NaN,    NaN,    2.5,    2.5,    2.5,    NaN,    NaN,    NaN,    NaN,    NaN,    NaN;...
%     NaN,    NaN,    NaN,    1.5,    1.5,    1.5,    NaN,    NaN,    NaN,    NaN,    NaN,    NaN;...
%     NaN,    NaN,    NaN,    0.5,    0.5,    0.5,    NaN,    NaN,    NaN,    NaN,    NaN,    NaN;...
%     ];
%
% Move algorithms are based on a combination of the same coordinate system
% as well as more intuitive references to the rubik's cube.
% These references include:
% - horizontal(h) where the top-most row corresponds to index 1 and the index
%   increases by increments of 1 from top to bottom
% - vertical(v) where the left-most column corresponds to index 1 and the
%   index increases by increments of 1 from left to right
% - depth(d) where the front face correspondes to index 1 and the index
%   increases by increments of 1 from front to back
% - clockwise(cw) and counter-clockwise(ccw) where the direction of
%   rotation always corresponds to a particular axis with the perspective
%   of looking the positive direction along the given axis

%% rubix colors
global colors
colors = {...
    'w',    [1.0,    1.0,    1.0];...
    'b',    [0.0,    0.0,    1.0];...
    'o',    [1.0,    0.5,    0.0];...
    'g',    [0.0,    1.0,    0.0];...
    'r',    [1.0,    0.0,    0.0];...
    'y',    [1.0,    1.0,    0.0];...
    };

%% construct rubik's cube

rubix_size = 10; % size of 3 corresponds to 3x3x3 rubix, for now limit to 9x9x9

if ~isnumeric(rubix_size) || mod(rubix_size,1) ~= 0 || rubix_size < 2
    return
end

r.rubix_size = rubix_size;

% construct blocks of data corresponding to each color
block = struct;
block.d_nan = repmat({NaN},rubix_size);
for c = 1:6 % always a six sided rubix
    color = colors{c,1};
    block.(sprintf('d_%s',color)) = cell(rubix_size);
    for i = 1:rubix_size
        for j = 1:rubix_size
            block.(sprintf('d_%s',color)){i,j} = sprintf('%s%i%i',color,i,j);
        end
    end
end

% assemble blocks into unified array
r.unqids = [...
    block.d_nan,    block.d_r,      block.d_nan,    block.d_nan;...
    block.d_b,      block.d_w,      block.d_g,      block.d_y;...
    block.d_nan,    block.d_o,      block.d_nan,    block.d_nan;...
    ];
r.home = r.unqids;
nansblock = NaN(rubix_size);
zeroblock = zeros(rubix_size);
onesblock = rubix_size*ones(rubix_size);
hincblock = repmat(0.5:1:rubix_size-0.5,rubix_size,1);
vincblock = transpose(hincblock);
r.x = [...
    nansblock,          hincblock,          nansblock,          nansblock;...
    zeroblock,          hincblock,          onesblock,          fliplr(hincblock);...
    nansblock,          hincblock,          nansblock,          nansblock;...
    ];
r.y = [...
    nansblock,          onesblock,          nansblock,          nansblock;...
    flipud(vincblock),  flipud(vincblock),  flipud(vincblock),  flipud(vincblock);...
    nansblock,          zeroblock,          nansblock,          nansblock;...
    ];
r.z = [...
    nansblock,          vincblock,          nansblock,          nansblock;...
    hincblock,          onesblock,          fliplr(hincblock),  zeroblock;...
    nansblock,          flipud(vincblock),  nansblock,          nansblock;...
    ];

%% rotate one of the faces

% figure('Position',[620,200,510,520],'Color','w')
% set(gca,'XTickLabels',[],'YTickLabels',[],'ZTickLabels',[],'XColor','none','YColor','none','ZColor','none',...
%     'NextPlot','replacechildren')
% possible_moves = {'h1cw','h2cw','h3cw','h1ccw','h2ccw','h3ccw','v1cw','v2cw','v3cw','v1ccw','v2ccw','v3ccw','d1cw','d2cw','d3cw','d1ccw','d2ccw','d3ccw'};
% moves = possible_moves(randsample(numel(possible_moves),1000,true));
% moves = repmat({'v3ccw','h1cw','d2ccw'},1,500);
% moves = {'h1cw','d3ccw'};
% figure('Position',[10,250,1400,330])
% err = NaN(1,numel(moves));
% err_0cnt = 0;
% for imo = 1:numel(moves)
%     r = make_a_move(r,moves{imo});
% %     subplot(1,5,imo)
% %     display_rubix(gca,r)
% %     title(moves{imo})
%     err(imo) = assess_error(r);
%     if err(imo) == 0
%         err_0cnt = err_0cnt + 1;
%         if err_0cnt == 2
%             break
%         end
%     end
% end
%
% err(1:find(err==0,1,'first')-1) = [];

% figure;
% plot(err,'-o')
% axis tight
r = make_a_move(r,'v3ccw');
r = make_a_move(r,'h7cw');
r = make_a_move(r,'d7cw');
%% display the rubix

figure('Position',[620,200,510,520],'Color','w')
set(gca,'XTickLabels',[],'YTickLabels',[],'ZTickLabels',[],'XColor','none','YColor','none','ZColor','none')
display_rubix(gca,r)

disp(r.unqids)

end

%% subfunction display_rubix
function display_rubix(theax,r)

global colors

ri = r.unqids(:);
rx = r.x(:);
ry = r.y(:);
rz = r.z(:);

axes(theax)
hold(theax,'on')

for ir = 1:length(ri)
    if isnan(ri{ir})
        continue
    end
    
    % fill orientation depends on what type of face, depend on established
    % coordinate system and fact that face corresponds to integer in x,y,z
    % maps
    c = colors{strcmp(ri{ir}(1),colors(:,1)),2};
    x = rx(ir);
    y = ry(ir);
    z = rz(ir);
    if mod(x,1)==0     % must be face in the yz plane
        xf = [x,x,x,x];
        yf = y + 0.5*[-1,+1,+1,-1];
        zf = z + 0.5*[-1,-1,+1,+1];
        fill3(xf,yf,zf,c,'LineWidth',4)
    elseif mod(y,1)==0 % must be face in the xz plane
        xf = x + 0.5*[-1,+1,+1,-1];
        yf = [y,y,y,y];
        zf = z + 0.5*[-1,-1,+1,+1];
        fill3(xf,yf,zf,c,'LineWidth',4)
    elseif mod(z,1)==0 % must be face in the xy plane
        xf = x + 0.5*[-1,+1,+1,-1];
        yf = y + 0.5*[-1,-1,+1,+1];
        zf = [z,z,z,z];
        fill3(xf,yf,zf,c,'LineWidth',4)
    end
end

axis([-1,r.rubix_size+1,-1,r.rubix_size+1,-1,r.rubix_size+1])
axis vis3d
view(145,25)
drawnow

end

%% subfunction make_a_move
function r = make_a_move(r,move)
% - reference is to always look at the white face with orange facing down
%   then specify what should be rotated and in which direction
% - horz, vert, dpth, top to bottom, left to right, front to back, like how
%   matlab builds its matrix indexes
% - clockwise or counterclockwise are always assessed as if look in the
%   positive direction of the corresponding axis
cw = -1;
ccw = 1;

mt = regexp(move,'([h,v,d])(\d+)(c{1,2}w)','tokens');
hvd = mt{1}{1};
idx = str2double(mt{1}{2});
rtn = mt{1}{3};
if isnan(idx) || idx<1 || idx> r.rubix_size
    warndlg('invalid move selected','invalid move','ok');
    return
end
switch sprintf('%s-%s',hvd,rtn)
    case 'h-cw'
        r.unqids(r.rubix_size+idx,:) =...
            r.unqids(r.rubix_size+idx,[r.rubix_size*3+1:r.rubix_size*4,1:r.rubix_size*3]);
        % r.unqids(4,:) = r.unqids(4,[10:12,1:9]);
        if idx == 1
            r.unqids(1:r.rubix_size,r.rubix_size+1:r.rubix_size*2) =...
                rot90(r.unqids(1:r.rubix_size,r.rubix_size+1:r.rubix_size*2),ccw);
            % r.unqids(1:3,4:6) = rot90(r.unqids(1:3,4:6),ccw);
        elseif idx == r.rubix_size
            r.unqids(r.rubix_size*2+1:r.rubix_size*3,r.rubix_size+1:r.rubix_size*2) =...
                rot90(r.unqids(r.rubix_size*2+1:r.rubix_size*3,r.rubix_size+1:r.rubix_size*2),cw);
            % r.unqids(7:9,4:6) = rot90(r.unqids(7:9,4:6),cw);
        end
    case 'h-ccw'
        r.unqids(r.rubix_size+idx,:) =...
            r.unqids(r.rubix_size+idx,[r.rubix_size+1:r.rubix_size*4,1:r.rubix_size]);
        % r.unqids(4,:) = r.unqids(4,[4:12,1:3]);
        if idx == 1
            r.unqids(1:r.rubix_size,r.rubix_size+1:r.rubix_size*2) =...
                rot90(r.unqids(1:r.rubix_size,r.rubix_size+1:r.rubix_size*2),cw);
            % r.unqids(1:3,4:6) = rot90(r.unqids(1:3,4:6),cw);
        elseif idx == r.rubix_size
            r.unqids(r.rubix_size*2+1:r.rubix_size*3,r.rubix_size+1:r.rubix_size*2) =...
                rot90(r.unqids(r.rubix_size*2+1:r.rubix_size*3,r.rubix_size+1:r.rubix_size*2),ccw);
            % r.unqids(7:9,4:6) = rot90(r.unqids(7:9,4:6),ccw);
        end
    case 'v-cw'
        col = [flipud(r.unqids(r.rubix_size+1:r.rubix_size*2,r.rubix_size*4-idx+1));r.unqids(:,r.rubix_size+idx)];
        col = [col(r.rubix_size*3+1:r.rubix_size*4);col(1:r.rubix_size*3)];
        r.unqids(:,r.rubix_size+idx) = col(r.rubix_size+1:r.rubix_size*4);
        r.unqids(r.rubix_size+1:r.rubix_size*2,r.rubix_size*4-idx+1) = flipud(col(1:r.rubix_size));
        % col = [flipud(r.unqids(4:6,12));r.unqids(:,4)];
        % col = [col(10:12);col(1:9)];
        % r.unqids(:,4) = col(4:12);
        % r.unqids(4:6,12) = flipud(col(1:3));
        if idx == 1
            r.unqids(r.rubix_size+1:r.rubix_size*2,1:r.rubix_size) =...
                rot90(r.unqids(r.rubix_size+1:r.rubix_size*2,1:r.rubix_size),cw);
            % r.unqids(4:6,1:3) = rot90(r.unqids(4:6,1:3),cw);
        elseif idx == r.rubix_size
            r.unqids(r.rubix_size+1:r.rubix_size*2,r.rubix_size*2+1:r.rubix_size*3) =...
                rot90(r.unqids(r.rubix_size+1:r.rubix_size*2,r.rubix_size*2+1:r.rubix_size*3),ccw);
            % r.unqids(4:6,7:9) = rot90(r.unqids(4:6,7:9),ccw);
        end
    case 'v-ccw'
        col = [flipud(r.unqids(r.rubix_size+1:r.rubix_size*2,r.rubix_size*4-idx+1));r.unqids(:,r.rubix_size+idx)];
        col = [col(r.rubix_size+1:r.rubix_size*4);col(1:r.rubix_size)];
        r.unqids(:,r.rubix_size+idx) = col(r.rubix_size+1:r.rubix_size*4);
        r.unqids(r.rubix_size+1:r.rubix_size*2,r.rubix_size*4-idx+1) = flipud(col(1:r.rubix_size));
        % col = [flipud(r.unqids(4:6,12));r.unqids(:,4)];
        % col = [col(4:12);col(1:3)];
        % r.unqids(:,4) = col(4:12);
        % r.unqids(4:6,12) = flipud(col(1:3));
        if idx == 1
            r.unqids(r.rubix_size+1:r.rubix_size*2,1:r.rubix_size) =...
                rot90(r.unqids(r.rubix_size+1:r.rubix_size*2,1:r.rubix_size),ccw);
            % r.unqids(4:6,1:3) = rot90(r.unqids(4:6,1:3),ccw);
        elseif idx == r.rubix_size
            r.unqids(r.rubix_size+1:r.rubix_size*2,r.rubix_size*2+1:r.rubix_size*3) =...
                rot90(r.unqids(r.rubix_size+1:r.rubix_size*2,r.rubix_size*2+1:r.rubix_size*3),cw);
            % r.unqids(4:6,7:9) = rot90(r.unqids(4:6,7:9),cw);
        end
    case 'd-cw'
        if idx == 1
            r.unqids(r.rubix_size:r.rubix_size*2+1,r.rubix_size:r.rubix_size*2+1) =...
                rot90(r.unqids(r.rubix_size:r.rubix_size*2+1,r.rubix_size:r.rubix_size*2+1),ccw);
            % r.unqids(3:7,3:7) = rot90(r.unqids(3:7,3:7),ccw);
        elseif idx == r.rubix_size
            r.unqids(1:r.rubix_size*3,1:r.rubix_size*3) =...
                rot90(r.unqids(1:r.rubix_size*3,1:r.rubix_size*3),ccw);
            r.unqids(2:r.rubix_size*3-1,2:r.rubix_size*3-1) =...
                rot90(r.unqids(2:r.rubix_size*3-1,2:r.rubix_size*3-1),cw);
            r.unqids(r.rubix_size+1:r.rubix_size*2,r.rubix_size*3+1:r.rubix_size*4) =...
                fliplr(rot90(fliplr(r.unqids(r.rubix_size+1:r.rubix_size*2,r.rubix_size*3+1:r.rubix_size*4)),ccw));
            % r.unqids(1:9,1:9) = rot90(r.unqids(1:9,1:9),ccw);
            % r.unqids(2:8,2:8) = rot90(r.unqids(2:8,2:8),cw);
            % r.unqids(4:6,10:12) = fliplr(rot90(fliplr(r.unqids(4:6,10:12)),ccw));
        else
            r.unqids(r.rubix_size-idx+1:r.rubix_size*2+idx,r.rubix_size-idx+1:r.rubix_size*2+idx) =...
                rot90(r.unqids(r.rubix_size-idx+1:r.rubix_size*2+idx,r.rubix_size-idx+1:r.rubix_size*2+idx),ccw);
            r.unqids(r.rubix_size-idx+2:r.rubix_size*2+idx-1,r.rubix_size-idx+2:r.rubix_size*2+idx-1) =...
                rot90(r.unqids(r.rubix_size-idx+2:r.rubix_size*2+idx-1,r.rubix_size-idx+2:r.rubix_size*2+idx-1),cw);
            % r.unqids(2:8,2:8) = rot90(r.unqids(2:8,2:8),ccw);
            % r.unqids(3:7,3:7) = rot90(r.unqids(3:7,3:7),cw);
        end
    case 'd-ccw'
        if idx == 1
            r.unqids(r.rubix_size:r.rubix_size*2+1,r.rubix_size:r.rubix_size*2+1) =...
                rot90(r.unqids(r.rubix_size:r.rubix_size*2+1,r.rubix_size:r.rubix_size*2+1),cw);
            % r.unqids(3:7,3:7) = rot90(r.unqids(3:7,3:7),cw);
        elseif idx == r.rubix_size
            r.unqids(1:r.rubix_size*3,1:r.rubix_size*3) =...
                rot90(r.unqids(1:r.rubix_size*3,1:r.rubix_size*3),cw);
            r.unqids(2:r.rubix_size*3-1,2:r.rubix_size*3-1) =...
                rot90(r.unqids(2:r.rubix_size*3-1,2:r.rubix_size*3-1),ccw);
            r.unqids(r.rubix_size+1:r.rubix_size*2,r.rubix_size*3+1:r.rubix_size*4) =...
                fliplr(rot90(fliplr(r.unqids(r.rubix_size+1:r.rubix_size*2,r.rubix_size*3+1:r.rubix_size*4)),cw));
            % r.unqids(1:9,1:9) = rot90(r.unqids(1:9,1:9),cw);
            % r.unqids(2:8,2:8) = rot90(r.unqids(2:8,2:8),ccw);
            % r.unqids(4:6,10:12) = fliplr(rot90(fliplr(r.unqids(4:6,10:12)),cw));
        else
            r.unqids(r.rubix_size-idx+1:r.rubix_size*2+idx,r.rubix_size-idx+1:r.rubix_size*2+idx) =...
                rot90(r.unqids(r.rubix_size-idx+1:r.rubix_size*2+idx,r.rubix_size-idx+1:r.rubix_size*2+idx),cw);
            r.unqids(r.rubix_size-idx+2:r.rubix_size*2+idx-1,r.rubix_size-idx+2:r.rubix_size*2+idx-1) =...
                rot90(r.unqids(r.rubix_size-idx+2:r.rubix_size*2+idx-1,r.rubix_size-idx+2:r.rubix_size*2+idx-1),ccw);
            % r.unqids(2:8,2:8) = rot90(r.unqids(2:8,2:8),cw);
            % r.unqids(3:7,3:7) = rot90(r.unqids(3:7,3:7),ccw);
        end
    otherwise
        warndlg('invalid move selected','invalid move','ok');
        return
end
end

%% subfunction assess_error

function error = assess_error(r)

rh = r.home(:);
ri = r.unqids(:);
rx = r.x(:);
ry = r.y(:);
rz = r.z(:);

d = NaN(size(ri));

for ir = 1:length(ri)
    if isnan(ri{ir})
        continue
    end
    
    i1 = ri(ir);
    x1 = rx(ir);
    y1 = ry(ir);
    z1 = rz(ir);
    i2 = strcmp(rh,i1);
    x2 = rx(i2);
    y2 = ry(i2);
    z2 = rz(i2);
    
    d(ir) = sqrt((x1-x2)^2+(y1-y2)^2+(z1-z2)^2);
    
end

error = sum(d,'omitnan');

end