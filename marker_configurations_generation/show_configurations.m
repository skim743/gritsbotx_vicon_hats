function show_configurations(vc, N, allowed_area, ZMIN, ZMAX)

figure
hold on
grid on
grid minor
axis equal
lim = 50;
axis([-lim lim -lim lim 0 2*lim])
xlabel('x')
ylabel('y')
zlabel('z')
% view([3 4 2.5])
view([0 0 1])
line(allowed_area(1,:), allowed_area(2,:), 'LineWidth', 2)
n_points = size(allowed_area,2);
patch(repmat(allowed_area(1,:),1,2), ...
    repmat(allowed_area(2,:),1,2), ...
    [ZMIN*ones(1,n_points) ZMAX*ones(1,n_points)], ...
    'w')

hP = gobjects(N);

for n = 1 : size(vc,1)
    
    P = reshape(vc(n,:),3,N);
    
    for i = 1 : size(P,2)
        hP(i) = plot3(P(1,i), P(2,i), P(3,i), 'g.', 'MarkerSize', 25);
    end
    drawnow
    pause
    delete(hP)
end