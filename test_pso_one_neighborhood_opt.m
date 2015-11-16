% test PSO with one by one neighborhood optimization

% load datasets
% load('data/datasets.mat');

result = zeros(size(datasetname,2), 5);

showplot_h = false;
showplot_pso = false;

% loop through all files
fprintf('PSO with one by one neighborhood optimization:\n');
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
    
    fprintf('distance %f in %f ms:\n', round(result(f,1), 3), round(result(f,2), 3));
    
    if showplot_h == true
        plotSpace( data, path );
    end
    
    fprintf('particle swarm optimization:\n');
    tPso = tic;
    %[ path, total_length, travelPoints ] = psoOneNeighborhoodOpt( data, path, swarmQuantity, cityIter, particleIter )
    [ path, total_length_pso, travelPoints ] = psoOneNeighborhoodOpt( data, path, 50, 2, 2 );
    
    result(f,4) = toc(tPso) * 1000;
    result(f,3) = total_length_pso;
    result(f,5) = result(f,2) + result(f,4); % over all time in ms
    fprintf('distance %f in %f ms:\n', round(result(f,3), 3), round(result(f,4), 3));
    
    if showplot_pso == true
        plotSpaceAfterPSO( data, path, travelPoints );
    end
end

clearvars variables showplot_h showplot_pso f tHeuristic tPso