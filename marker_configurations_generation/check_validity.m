function v = check_validity(P, allowed_area, forbidden_points, marker_diameter)

v = true;

N = size(P,2);
S = nchoosek(1:N,2);

condition = all(inpolygon(P(1,:), P(2,:), allowed_area(1,:), allowed_area(2,:))); % inside allowed area ...
if ~condition
    v = false;
    return
end

% ... and far enough from forbidden points
if ~isempty(forbidden_points)
    fp = forbidden_points{1};
    fr = forbidden_points{2};
    for i = 1 : size(P,2)
        Pi = P(:,i);
        for j = 1 : length(fr)
            Pj = fp(:,j);
            condition = condition & (norm(Pi(1:2,:)-Pj(1:2,:)) > fr(j));
        end
        if ~condition
            v = false;
            return
        end
    end
end

for s = 1 : size(S,1)
    i = S(s,1);
    j = S(s,2);
    Pi = P(:,i);
    Pj = P(:,j);
    condition = norm(Pi(1:2,:)-Pj(1:2,:)) > 2*marker_diameter; % ... and enough apart from each other
    if ~condition
        v = false;
        return
    end
end

end