function [best, all] = find_best_n_markers(vc, n, varargin)

M = size(vc,1);
N = size(vc,2)/3;

switch nargin
    case 2
        cost = 'minmax_nth';
        n_comp = M;
    case 3
        cost = varargin{1};
        n_comp = M;
    case 4
        cost = varargin{1};
        n_comp = varargin{2};
end

xyz_idx = [];
for i = 1 : N
    xyz_idx = [xyz_idx, (i-1)*3+(1:2)];
end
xyz_idx = [xyz_idx, (3:3:size(vc,2))];

c = zeros(M,1);
for m = 1 : M
    tic
    switch cost
        case 'min_nth'
            c(m) = cost_frob_min(vc,m,n_comp);
        case 'minmax_nth'
            c(m) = cost_frob_minmax(vc,m,n_comp);
    end
    toc
    disp([num2str(m), ' ', num2str(c(m))])
    disp('---')
end

[~,idx] = sort(c);

best = vc(idx(1:n),xyz_idx);
all = vc(idx,xyz_idx);

best(:,3*N-N+1:end) = round(4*best(:,3*N-N+1:end)/25.4);
all(:,3*N-N+1:end) = round(4*all(:,3*N-N+1:end)/25.4);

end