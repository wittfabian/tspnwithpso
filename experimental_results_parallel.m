% test PSO with one by one neighborhood optimization

%parpool('local',4);
%poolobj = gcp('nocreate');
%if matlabpool('size') == 0
%    matlabpool('local', 4)
%end

% load datasets
load('data/datasets.mat');

fullloops = 4;

% 1: relative error (with mean value), 
% 2: max. value found by the algorithm, 
% 3: mean value, 
% 4: standard deviation, 
% 5: best solution found by the algorithm
resultOverview = zeros(size(datasetname,2), 5);

% vRandType: edgeExch or 2opt
% vRandIter: interger > 0 (only for vRandType edgeExch)
% randArt: randomStart or randomTemp
moveOptionsDPSO = struct('bLoc', 0.2, 'bGlob', 0.2, 'randArt', 'randomTemp', 'vRandType', '2opt', 'vRandIter', 0, 'noChangeIterStop', 200, 'particleIter', 100);

moveOptionsPSO = struct('initVelocity', 0.0, 'omega', 0.3, 'noChangeCountTh', 0, 'boundaryhandlingPercentage', 0.0, 'noChangeIterStop', 1001, 'c1', 1.0, 'c2', 1.0, 'particleIter', 100);

% loop through all files
for f = 1%:1:size(datasetname,2) % iterate through datasets
    
    fprintf('dataset: %s\n',datasetname{f});

    % get the data: structure = X Y R1 R2
    data = eval(datasetname{f});

    [ optimalPath, optimalPathLength, optimalPathOrder, resultDist, resultTime ] = optimization( fullloops, data, moveOptionsDPSO, moveOptionsPSO  );
    
    % results
    resultOverview(f,3) = mean(resultDist(:,2)); % mean value
    
    resultOverview(f,1) = (resultOverview(f,3) - optimalValue(f,1)) / optimalValue(f,1); % relative error (with mean value)
    
    resultOverview(f,2) = max(resultDist(:,2)); % max. value found by the algorithm
    
    resultOverview(f,5) = min(resultDist(:,2)); % best solution found by the algorithm
    
    resultOverview(f,4) = std(resultDist(:,2)); % standard deviation
    
    %fprintf('relative error: %f\n', resultOverview(f,1));
    %fprintf('max. value: %f\n', resultOverview(f,2));
    %fprintf('mean value: %f\n', resultOverview(f,3));
    %fprintf('standard deviation: %f\n', resultOverview(f,4));
    %fprintf('best solution: %f\n', resultOverview(f,5));
    
    %save(['results/optimalPath_' num2str(f) '.mat'], 'optimalPath', 'optimalPathLength', 'optimalPathOrder');
    %save(['results/resultOverview_' num2str(f) '.mat'],'resultOverview', 'resultTime');
end

%save('results/resultOverview.mat','resultOverview');

clearvars
%clearvars variables showplot_dpso showplot_pso f l tDpso tPso fullloops total_length_dpso total_length_pso moveOptionsDPSO

%matlabpool close
