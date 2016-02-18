function [ path, total_length ] = psoOptDisc( data, swarmQuantity, moveOptions)

    distances = distance(data(:,1:2));

    %path = 1:size(data,1); % initialize path
    
    %total_length = distancePath( distances, path ); % initialize total_length

    % initialize particles: types: randomNoDup, randomWithDup, randomFifNoDup
    particlePos = initSwarmMemberDpso( data, swarmQuantity, 'randomWithDup' );
    
    personalBest = particlePos;
    
    % initialize globalBest with personalBest of the first particle
    [ globalBestPath, ~ ] = findGlobalBestDpso( distances, particlePos );
    
    noChangeCount = 0;
    
    pi = 1;
    
    while true
        
        for p=1:1:size(particlePos, 1) % iterate through particles (one particle = one tour)
            
            personalBest(p,:) = psoOptDiscMovement( particlePos(p,:), personalBest(p,:), globalBestPath, distances, moveOptions );

            % find new personalBest
            distpersonalBest = distancePath( distances, personalBest(p,:) );
            distAktPos = distancePath( distances, particlePos(p,:) );
            
            if distAktPos < distpersonalBest
                personalBest(p,:) = particlePos(p,:);
            end
        end
        
        % update globalBest after optimization
        lastGlobalBest = globalBestPath;
        [ globalBestPath, globalBestDist ] = findGlobalBestDpso( distances, particlePos, globalBestPath );
        
        if lastGlobalBest == globalBestPath
            noChangeCount = noChangeCount + 1;
        end
        
        fprintf('%d\n', globalBestDist);
        
        if (isfield(moveOptions,'particleIter') && pi >= moveOptions.particleIter) || (isfield(moveOptions, 'noChangeIterStop') && noChangeCount > moveOptions.noChangeIterStop)
            break
        end
        
        pi = pi + 1;
    end
    % save the best route
    path = globalBestPath;
    
    % calculate the total_length of the cycle
    total_length = distancePath( distances, path );
end

