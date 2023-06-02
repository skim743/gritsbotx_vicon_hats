function vc = generate_hats_discrete_heights(N_all, varargin)


valid_number_of_balls = @(x) isnumeric(x) && isscalar(x) && (x > 0);

p = inputParser;
p.addRequired('N_all',valid_number_of_balls);
p.addOptional('PLOT',false);
p.addOptional('N',5);
p.addOptional('FOOTPRINT',[46, 45]);
p.addOptional('Z',[6.35, 12.7, 19.05, 25.4]); % 1/4in, 2/4in, 3/4in, 4/4in
p.addOptional('MARKER_DIAMETER', 10);

parse(p,N_all,varargin{:});

N_all = p.Results.N_all;
PLOT = p.Results.PLOT;
N = p.Results.N;
FOOTPRINT = p.Results.FOOTPRINT;
Z = p.Results.Z;
MARKER_DIAMETER = p.Results.MARKER_DIAMETER;

allowed_area = [0 0;FOOTPRINT(1) 0; FOOTPRINT(1) FOOTPRINT(2);0 FOOTPRINT(2); 0 0]';
forbidden_points = {};

if PLOT
    figure
    hold on
    grid on
    grid minor
    axis equal
    axis([0 FOOTPRINT(1) 0 FOOTPRINT(2) 0 Z(end)])
    xlabel('x')
    ylabel('y')
    zlabel('z')
    view([3 4 2.5])
    % view([0 0 1])
    line(allowed_area(1,:), allowed_area(2,:), 'LineWidth', 2)
    n_points = size(allowed_area,2);
    patch(repmat(allowed_area(1,:),1,2), ...
        repmat(allowed_area(2,:),1,2), ...
        [Z(1)*ones(1,n_points) Z(end)*ones(1,n_points)], ...
        'w')
    
    hP = gobjects(N);
end

COLORS = [0    0.4470    0.7410
    0.8500    0.3250    0.0980
    0.9290    0.6940    0.1250
    0.4940    0.1840    0.5560
    0.4660    0.6740    0.1880
    0.3010    0.7450    0.9330
    0.6350    0.0780    0.1840
    0         0    1.0000
    0    0.5000         0
    1.0000         0         0
    0    0.7500    0.7500
    0.7500         0    0.7500
    0.7500    0.7500         0
    0.2500    0.2500    0.2500];

n_valid = 0;
vc = NaN(N_all,N*3);
disp('starting generation ...')
while n_valid < N_all
    P = [FOOTPRINT(1)*rand(1,N);
        FOOTPRINT(2)*rand(1,N);
        Z(randi(length(Z),1,N))];
    if check_validity(P, allowed_area, forbidden_points, MARKER_DIAMETER)
        n_valid = n_valid + 1;
        vc(n_valid,:) = reshape(P,1,N*3);
        % disp('valid')
        disp(['generated ', num2str(n_valid), ' valid markers'])
        if PLOT
            color = COLORS(randi(14,1),:);
            for i = 1 : size(P,2)
                hP(i) = plot3(P(1,i), P(2,i), P(3,i), '.', 'MarkerSize', 25, 'Color', color);
            end
            drawnow
            % delete(hP)
        end
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