function [R, error] = find_best_rotation_unnormalized(p1, p2)

N = size(p1,2);

[p1, p2] = shift_to_center(p1, p2);

C = zeros(3);
for i = 1 : N
    C = C + p2(:,i) * p1(:,i)';
end

[U,~,V] = svd(C);

R = V*U';

% R = make_sure_is_a_rotation_matrix(R);

% error = 0;
% for i = 1 : N
%     error = error + norm(p1(:,i) - R * p2(:,i));
% end
error = norm(p1(:,i) - R * p2(:,i), 'fro');

end