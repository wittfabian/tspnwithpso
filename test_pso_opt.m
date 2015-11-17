% test PSO with one by one neighborhood optimization

% load datasets
% load('data/datasets.mat');

result = zeros(size(datasetname,2), 5);

showplot_h = false;
showplot_pso = false;

% loop through all files
fprintf('PSO with full path optimization:\n');
for f = 1:1:size(datasetname,2)
    
    fprintf('dataset: %s\n',datasetname{f});
    
    % get the data: structure = X Y R1 R2
    data = eval(datasetname{f});
    
    fprintf('insertion_heuristics:\n');
    tHeuristic = tic; % start timer for insertion_heuristics
    % only first two columns of the dataset
    [path, total_length_h, dist_h] = insertion_heuristics(data(:,1:2), @farthest_insertion);
    
    result(f,2) = toc(tHeuristic) * 1000; % stop timer & save result
    result(f,1) = total_length_h;
    
    fprintf('distance %.3f in %.3f ms:\n', result(f,1), result(f,2));
    
    if showplot_h == true
        plotSpace( data, path );
    end
    
    fprintf('particle swarm optimization:\n');
    tPso = tic;
    %[ path, total_length, travelPoints ] = psoOpt( data, path, swarmQuantity, particleIter, stopThreshold, useTurbulenceFactor, tfNewSet )
    [ path, total_length_pso, travelPoints ] = psoOpt( data, path, 30, 50, 0.0000005, true, 5 );
    
    result(f,4) = toc(tPso) * 1000;
    result(f,3) = total_length_pso;
    result(f,5) = result(f,2) + result(f,4); % over all time in ms
    fprintf('distance %.3f in %.3f ms:\n', result(f,3), result(f,4));
    
    if showplot_pso == true
        plotSpaceAfterPSO( data, path, travelPoints );
    end
end

clearvars variables showplot_h showplot_pso f tHeuristic tPso