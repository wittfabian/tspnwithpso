
% test insertion_heuristics

% load datasets
% load('data/datasets.mat');

result = zeros(size(datasetname,2), 2);

showplot = false;

% loop through all files
fprintf('insertion_heuristics with farthest_insertion:\n');
for f = 1:1:size(datasetname,2)
    tic;
    fprintf('dataset: %s\n',datasetname{f});
    
    % get the data: structure = X Y R1 R2
    data = eval(datasetname{f});
    
    % only first two columns of the dataset
    [path, total_length, dist] = insertion_heuristics(data(:,1:2), @farthest_insertion);
    
    result(f,1) = total_length;
    result(f,2) = toc * 1000;
    
    if showplot == true
        plotSpace( data, path );
    end
end

clearvars variables showplot f data path total_length dist