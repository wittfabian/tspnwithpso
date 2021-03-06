% test PSO with one by one neighborhood optimization

% load datasets
load('data/datasets.mat');

fullloops = 2;

resultDist = zeros(fullloops, 2, size(datasetname,2)); % 1: min. DPSO, 2: min. PSO
resultTime = zeros(fullloops, 3, size(datasetname,2)); % 1: min. DPSO, 2: min. PSO, 3: sum

% 1: relative error (with mean value), 
% 2: max. value found by the algorithm, 
% 3: mean value, 
% 4: standard deviation, 
% 5: best solution found by the algorithm
resultOverview = zeros(size(datasetname,2), 5);

% vRandType: edgeExch or 2opt
% vRandIter: interger > 0 (only for vRandType edgeExch)
% randArt: randomStart or randomTemp
moveOptionsDPSO = struct('bLoc', 0.2, 'bGlob', 0.2, 'randArt', 'randomTemp', 'vRandType', '2opt', 'vRandIter', 0, 'noChangeIterStop', 100);

moveOptionsPSO = struct('initVelocity', 0.0, 'initInertiaWeight', 0.3, 'noChangeCountTh', 0, 'boundaryhandlingPercentage', 0.0, 'noChangeIterStop', 100);

% loop through all files
for f = 1%:1:size(datasetname,2) % iterate through datasets
    
    fprintf('dataset: %s\n',datasetname{f});

    % get the data: structure = X Y R1 R2
    data = eval(datasetname{f});
    
    optimalPath = zeros(size(data,1), 2, fullloops);
    optimalPathLength = Inf(fullloops,1);
    
    for l=1:1:fullloops % runs to compute the mean error and the standard deviation
        
        tDpso = tic;
        % [ path, total_length_dpso, travelPoints ] = dPsoOpt( data , swarmQuantity, particleIter, moveOptionsDPSO);
        [ path, total_length_dpso ] = psoOptDisc( data , 50, 1000, moveOptionsDPSO);

        dpsoResultTime = toc(tDpso) * 1000; % in ms
        dpsoResultDist = total_length_dpso;
        
        
        tPso = tic;
        %[ path, total_length, travelPoints ] = psoOpt( data, path, swarmQuantity, particleIter, moveOptionsPSO )
        [ path, total_length_pso, travelPoints ] = psoOpt( data, path, 50, 1000, moveOptionsPSO);

        psoResultTime = toc(tPso) * 1000; % in ms
        psoResultDist = total_length_pso;
        
        resultDist(l,:,f) = [total_length_dpso total_length_pso];
        
        resultTime(l,:,f) = [dpsoResultTime psoResultTime (dpsoResultTime + psoResultTime)];
        

        optimalPath(:,:,l) = travelPoints;
        optimalPathLength(l,1) = total_length_pso;        
    end
    
    % results
    resultOverview(f,3) = mean(resultDist(:,2,f)); % mean value
    
    resultOverview(f,1) = (resultOverview(f,3) - optimalValue(f,1)) / optimalValue(f,1); % relative error (with mean value)
    
    resultOverview(f,2) = max(resultDist(:,2,f)); % max. value found by the algorithm
    
    resultOverview(f,5) = min(resultDist(:,2,f)); % best solution found by the algorithm
    
    resultOverview(f,4) = std(resultDist(:,2,f)); % standard deviation
    
    fprintf('relative error: %f\n', resultOverview(f,1));
    fprintf('max. value: %f\n', resultOverview(f,2));
    fprintf('mean value: %f\n', resultOverview(f,3));
    fprintf('standard deviation: %f\n', resultOverview(f,4));
    fprintf('best solution: %f\n', resultOverview(f,5));
    
    save(['results/optimalPath_' num2str(f) '.mat'], 'optimalPath', 'optimalPathLength');
end

save('results/resultOverview.mat','resultOverview');

clearvars variables showplot_dpso showplot_pso f l tDpso tPso fullloops total_length_dpso total_length_pso moveOptionsDPSO