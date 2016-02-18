function [ optimalPath, optimalPathLength, optimalPathOrder, resultDist, resultTime ] = optimization( fullloops, data, moveOptionsDPSO, moveOptionsPSO  )

    resultDist = zeros(fullloops, 2); % 1: min. DPSO, 2: min. PSO
    resultTime = zeros(fullloops, 3); % 1: min. DPSO, 2: min. PSO, 3: sum

    optimalPathOrder = zeros(fullloops, size(data,1));
    optimalPath = zeros(size(data,1), 2, fullloops);
    optimalPathLength = Inf(fullloops,1);

    parfor l=1:1:fullloops % runs to compute the mean error and the standard deviation
        
        tDpso = tic;
        fprintf('DPSO\n');
        % [ path, total_length_dpso, travelPoints ] = dPsoOpt( data , swarmQuantity, moveOptionsDPSO);
        [ path, total_length_dpso ] = psoOptDisc( data , 50, moveOptionsDPSO);

        dpsoResultTime = toc(tDpso) * 1000; % in ms
        %dpsoResultDist = total_length_dpso;
        
        
        tPso = tic;
        fprintf('PSO\n');
        %[ path, total_length, travelPoints ] = psoOpt( data, path, swarmQuantity, moveOptionsPSO )
        [ ~, total_length_pso, travelPoints ] = psoOpt( data, path, 50, moveOptionsPSO);

        psoResultTime = toc(tPso) * 1000; % in ms
        %psoResultDist = total_length_pso;
        
        resultDist(l,:) = [total_length_dpso total_length_pso];
        
        resultTime(l,:) = [dpsoResultTime psoResultTime (dpsoResultTime + psoResultTime)];
        
        optimalPathOrder(l,:) = path;
        optimalPath(:,:,l) = travelPoints;
        optimalPathLength(l,1) = total_length_pso;
    end
end

