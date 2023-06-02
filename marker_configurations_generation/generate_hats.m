function vc = generate_hats(N_all, varargin)


valid_number_of_balls = @(x) isnumeric(x) && isscalar(x) && (x > 0);

p = inputParser;
p.addRequired('N_all',valid_number_of_balls);
p.addOptional('PLOT',false);
p.addOptional('N',4);
p.addOptional('FOOTPRINT',25);
p.addOptional('ZMIN',8);
p.addOptional('ZMAX',23);

parse(p,N_all,varargin{:});

N_all = p.Results.N_all;
PLOT = p.Results.PLOT;
N = p.Results.N;
FOOTPRINT = p.Results.FOOTPRINT;
ZMIN = p.Results.ZMIN;
ZMAX = p.Results.ZMAX;

% PLOT = false;
% N = 4;
% FOOTPRINT = 30;
% ZMIN = 8;
% ZMAX = ZMIN + 15;

allowed_area = 24.5*[cos(linspace((-90-75.26)/180*pi,(-90+45.92)/180*pi,50));
    sin(linspace((-90-75.26)/180*pi,(-90+45.92)/180*pi,50))];
allowed_area = [[-15.8 -15.8;0 -1.89], allowed_area, [17.6 10 10;-8.92 -6.15 0]];
allowed_area = [allowed_area, [1 0; 0 -1]*allowed_area(:,end:-1:1)];
forbidden_points = {};

if PLOT
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
end

n_valid = 0;
vc = NaN(N_all,N*3);
disp('starting generation ...')
while n_valid < N_all
    P = [-FOOTPRINT + 2*FOOTPRINT*rand(1,N);
        -FOOTPRINT + 2*FOOTPRINT*rand(1,N);
        ZMIN + (ZMAX-ZMIN)*rand(1,N)];
    if check_validity(P, allowed_area, forbidden_points, 8)
        n_valid = n_valid + 1;
        vc(n_valid,:) = reshape(P,1,N*3);
        % disp('valid')
        disp(['generated ', num2str(n_valid), ' valid markers'])
        if PLOT
            for i = 1 : size(P,2)
                hP(i) = plot3(P(1,i), P(2,i), P(3,i), 'g.', 'MarkerSize', 25);
            end
            drawnow
            % delete(hP)
        end
        % pause
    else
        % disp('invalid')
        % if PLOT
        %     for i = 1 : size(P,2)
        %         hP(i) = plot3(P(1,i), P(2,i), P(3,i), 'r*', 'MarkerSize', 2);
        %     end
        %     drawnow
        %     % delete(hP)
        % end
        % % pause
    end
end


end