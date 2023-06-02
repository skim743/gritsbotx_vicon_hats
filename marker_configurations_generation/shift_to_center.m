function [p1, p2] = shift_to_center(p1, p2)

N = size(p1,2);

g1 = mean(p1,2);
g2 = mean(p2,2);

p1 = p1 - repmat(g1, 1, N);
p2 = p2 - repmat(g2, 1, N);

end