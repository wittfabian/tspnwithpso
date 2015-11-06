% Mixed Integer NonLinear Program (MINLP)
% as Symmetric Traveling Salesman Problem With Neighbordhood (STSPN)

% list of datafiles
% filename = {'_tspn2DE5_1.dat', '_tspn2DE5_2.dat', '_tspn2DE6_1.dat', '_tspn2DE6_2.dat', '_tspn2DE7_1.dat', '_tspn2DE7_2.dat', '_tspn2DE8_1.dat', '_tspn2DE8_2.dat', '_tspn2DE9_1.dat', '_tspn2DE9_2.dat', '_tspn2DE10_1.dat', '_tspn2DE10_2.dat', '_tspn2DE11_1.dat', '_tspn2DE11_2.dat', '_tspn2DE12_1.dat', '_tspn2DE12_2.dat', '_tspn2DE13_1.dat', '_tspn2DE13_2.dat', '_tspn2DE14_1.dat', '_tspn2DE14_2.dat', '_tspn2DE15_1.dat', '_tspn2DE15_2.dat', '_tspn2DE16_1.dat', '_tspn2DE16_2.dat'};

% loadDataFileInMatrix('data/', filename, ' ', 1)

filename = {'dataset_tspn2DE5_1', 'dataset_tspn2DE5_2', 'dataset_tspn2DE6_1', 'dataset_tspn2DE6_2', 'dataset_tspn2DE7_1', 'dataset_tspn2DE7_2', 'dataset_tspn2DE8_1', 'dataset_tspn2DE8_2', 'dataset_tspn2DE9_1', 'dataset_tspn2DE9_2', 'dataset_tspn2DE10_1', 'dataset_tspn2DE10_2', 'dataset_tspn2DE11_1', 'dataset_tspn2DE11_2', 'dataset_tspn2DE12_1', 'dataset_tspn2DE12_2', 'dataset_tspn2DE13_1', 'dataset_tspn2DE13_2', 'dataset_tspn2DE14_1', 'dataset_tspn2DE14_2', 'dataset_tspn2DE15_1', 'dataset_tspn2DE15_2', 'dataset_tspn2DE16_1', 'dataset_tspn2DE16_2'};

% loop through all files
for f=1%:1:size(filename,2)
    
    fprintf('dataset: %s\n',filename{f});

    data = eval(filename{f});
    
    % plot the ellipse
    figure;
    for i=1:1:size(data,1)

        plotEllipse( data(i,1), data(i,2), data(i,3), data(i,4) );

    end
    
    % number of towns (stops)
    nStops = size(data,1);
    
    % calculate all possible town combinations / anz = n!/((n?k)! * k!)
    idxs = nchoosek(1:nStops,2);
    
    % calculate all the trip distances = sqrt(abs(a).^2 + abs(b).^2)
    %dist = hypot(data(idxs(:,1),1) - data(idxs(:,2),1), ... % x
    %             data(idxs(:,1),2) - data(idxs(:,2),2)); % y
    dist = stspnObjectiveFunction( data(:,1:2) );
    lendist = length(dist);
    
end