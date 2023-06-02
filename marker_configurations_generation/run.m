clc
clear
close all

addpath(genpath(pwd))

uniquedate = datestr(datetime,'yyyymmdd-HHMMSS');

% generate N_all and pick the best N_best
N_all = 5000;
N_best = 50;

% generate hats ...
% vc = generate_hats_discrete_heights(N_all, ...
%     'PLOT', false, ...
%     'N', 5, ...
%     'FOOTPRINT', [46, 45], ...
%     'Z', 25.4*[1/2, 3/4, 1, 5/4], ...
%     'MARKER_DIAMETER', 10);
% save(['gritsbotx_hats_generated_', num2str(N_all), '_configurations_not_ranked_', uniquedate])
% ... or load pregenerated ones
load gritsbotx_hats_generated_5000_configurations_not_ranked_20181118-130853.mat
N_all = size(vc,1);

if N_all > N_best
    [best, all_sorted] = find_best_n_markers(vc, N_best, 'minmax_nth', N_all);
    print_to_xlsx(best, ['gritsbotx_hats_5_markers_best_', num2str(N_best), '_', uniquedate])
else
    print_to_xlsx(vc, ['gritsbotx_hats_5_markers_best_', num2str(N_all), '_', uniquedate])
end

save(['gritsbotx_hats_generated_', num2str(N_all), '_configurations_ranked_', uniquedate])
