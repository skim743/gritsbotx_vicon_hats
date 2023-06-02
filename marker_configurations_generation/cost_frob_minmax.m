function cost = cost_frob_minmax(vc,m,varargin)

if nargin > 2
    M = varargin{1};
else
    M = size(vc,1);
end
N = size(vc,2)/3;

config_m = reshape(vc(m,:),3,N);

S = perms(1:N);

cost = -inf;
for i = 1 : M
    config_i = reshape(vc(i,:),3,N);
    for s = 1 : size(S,1)
        if i == m && s == size(S,1)
            continue
        end
        idx = S(s,:);
        config_i_s = config_i(:,idx);
        [~, cost_i_s] = find_best_rotation_unnormalized(config_m, config_i_s);
        if cost_i_s > cost
            cost = cost_i_s;
        end
    end
end

end