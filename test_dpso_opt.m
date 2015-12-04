% test PSO with one by one neighborhood optimization

% load datasets
% load('data/datasets.mat');

showplot_dpso = false;
showplot_pso = false;

fullloops = 5;

result = zeros(size(datasetname,2), 5, fullloops);

% loop through all files
fprintf('PSO with full path optimization:\n');
for f = 22%:1:size(datasetname,2)
    
    fprintf('dataset: %s\n',datasetname{f});

    % get the data: structure = X Y R1 R2
    data = eval(datasetname{f});
    
    travelPoints = data(:,1:2);
    
    last_dpso_dist = 0;
    
    last_pso_dist = 0;
    
    l = 1;
    %while true
        
        fprintf('descrete PSO (loop %i):\n', l);
        tDpso = tic; % start timer for insertion_heuristics
        % only first two columns of the dataset
        % vRandType: random or 2opt
        % [ path, total_length_dpso, travelPoints ] = dPsoOpt( data , swarmQuantity, particleIter, vRandType);
        [ path, total_length_dpso ] = psoOptDisc( data , 30, 1000, '2opt');

        result(f,2,l) = toc(tDpso) * 1000; % stop timer & save result
        result(f,1,l) = total_length_dpso;

        fprintf('distance %.3f in %.3f ms:\n', result(f,1,l), result(f,2,l));

        if showplot_dpso == true
            plotSpace( [travelPoints data(:,3:4)], path );
        end
        
    while true
        
        fprintf('particle swarm optimization (loop %i):\n', l);
        tPso = tic;
        %[ path, total_length, travelPoints ] = psoOpt( data, path, swarmQuantity, particleIter, stopThreshold, useTurbulenceFactor, tfNewSet, changeInLastElements )
        [ path, total_length_pso, travelPoints ] = psoOpt( data, path, 50, 100, 0, true, 5, 20 );

        result(f,4,l) = toc(tPso) * 1000;
        result(f,3,l) = total_length_pso;
        result(f,5,l) = result(f,2) + result(f,4); % over all time in ms
        
        fprintf('distance %.3f in %.3f ms:\n', result(f,3,l), result(f,4,l));

        if showplot_pso == true
            plotSpaceAfterPSO( data, path, travelPoints );
        end
        
        %if l >= fullloops || ( last_dpso_dist <= total_length_dpso && l > 1 )
        if l >= fullloops
            break
        end
        
        last_dpso_dist = total_length_dpso;
        last_pso_dist = total_length_pso;
        l = l + 1;
    end
end

clearvars variables showplot_dpso showplot_pso f tDpso tPso fullloops