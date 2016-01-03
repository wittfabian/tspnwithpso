function [ optimalPath, optimalPathLength, resultDist, resultTime ] = optimization( f, fullloops, data, datasetname, moveOptionsDPSO, moveOptionsPSO  )

    resultDist = zeros(fullloops, 2, size(datasetname,2)); % 1: min. DPSO, 2: min. PSO
    resultTime = zeros(fullloops, 3, size(datasetname,2)); % 1: min. DPSO, 2: min. PSO, 3: sum

    optimalPath = zeros(size(data,1), 2, fullloops);
    optimalPathLength = Inf(fullloops,1);

    parfor l=1:1:fullloops % runs to compute the mean error and the standard deviation
        
        tDpso = tic;
        % [ path, total_length_dpso, travelPoints ] = dPsoOpt( data , swarmQuantity, moveOptionsDPSO);
        [ path, total_length_dpso ] = psoOptDisc( data , 50, moveOptionsDPSO);

        dpsoResultTime = toc(tDpso) * 1000; % in ms
        %dpsoResultDist = total_length_dpso;
        
        
        tPso = tic;
        %[ path, total_length, travelPoints ] = psoOpt( data, path, swarmQuantity, moveOptionsPSO )
        [ ~, total_length_pso, travelPoints ] = psoOpt( data, path, 50, moveOptionsPSO);

        psoResultTime = toc(tPso) * 1000; % in ms
        %psoResultDist = total_length_pso;
        
        resultDist(l,:,f) = [total_length_dpso total_length_pso];
        
        resultTime(l,:,f) = [dpsoResultTime psoResultTime (dpsoResultTime + psoResultTime)];
        

        optimalPath(:,:,l) = travelPoints;
        optimalPathLength(l,1) = total_length_pso;
    end
end

