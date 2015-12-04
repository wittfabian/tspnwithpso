function [ path, total_length ] = psoOptDisc( data, swarmQuantity, particleIter, vRandType)

    distances = distance(data(:,1:2));

    path = 1:size(data,1); % initialize path
    
    total_length = distancePath( distances, path ); % initialize total_length

    % initialize particles: types: random
    particlePos = initializeSwarmMemberPermutation( data, swarmQuantity, 'random' );
    
    personalBest = particlePos;
    
    % initialize globalBest with personalBest of the first particle
    [ globalBestPath, globalBestDist ] = findGlobalBestPermutation( distances, personalBest );
    
    %fprintf('globalBestPath: %s, %f\n', sprintf('%i ', globalBestPath), globalBestDist);
    
    pi = 1;
    
    while true
        
        for p=1:1:size(particlePos, 1) % iterate through particles (one particle = one tour)
            
            rLoc = (1-0)*rand(1) + 0; % rand between 0 and 1
            rGlob = rLoc; %(1-0)*rand(1) + 0; % rand between 0 and 1
            rRand = (1-0)*rand(1) + 0; % rand between 0 and 1
            
            bLoc = 0.3;
            bGlob = 0.3;
            bRand = (1-0)*rand(1) + 0; % rand between 0 and 1
            
            % x_i(t+1) => new position of the particle p
            
            % difference x - y => shortest sequenz of transpositions T
            % length of difference is the length of the sequenz T
            % multiplication s * T => t1, .. t[s*k]
            % addition T1 + T2 = t1.1, ..., t1.k, t2.1, ..., t2.l
            % addition of a difference and a position => applying the transposition of the difference to the position
            
            % d = destination (point)
            % b_loc & b_glob are constant weights
            % r_loc & r_glob are drawn uniformly at random from [0,1]
            
            % d_loc = x_i(t) + r_loc * b_loc * (p_i - x_i(t))
            edgeExch = getListOfEdgeExchanges( particlePos(p,:), personalBest(p,:) ); % (p_i - x_i(t))
            if ~isempty(edgeExch) && round(size(edgeExch,1) * rLoc * bLoc) > 0
                dLoc_right = edgeExch(1:round(size(edgeExch,1) * rLoc * bLoc), :); % r_loc * b_loc * (p_i - x_i(t))
            else
                dLoc_right = [];
            end
            dLoc = applyEdgeExchange( dLoc_right, particlePos(p,:) ); % x_i(t) + r_loc * b_loc * (p_i - x_i(t))

            
            % d_glob = x_i(t) + r_glob * b_glob * (p_glob - x_i(t))
            edgeExch = getListOfEdgeExchanges( particlePos(p,:), globalBestPath ); % (p_glob - x_i(t))
            if ~isempty(edgeExch) && round(size(edgeExch,1) * rGlob * bGlob) > 0
                dGlob_right = edgeExch(1:round(size(edgeExch,1) * rGlob * bGlob), :); % r_glob * b_glob * (p_glob - x_i(t))
            else
            	dGlob_right = [];
            end
            dGlob = applyEdgeExchange( dGlob_right, particlePos(p,:) ); %  x_i(t) + r_glob * b_glob * (p_glob - x_i(t))

            % x_i_temp = d_glob + 0.5 * (d_loc - d_glob)
            edgeExch = getListOfEdgeExchanges( dGlob, dLoc ); % (d_loc - d_glob)
            if ~isempty(edgeExch) && round(size(edgeExch,1) * 0.5) > 0
                particlePos_mid = edgeExch(1:round(size(edgeExch,1) * 0.5), :); % 0.5 * (d_loc - d_glob)
            else
            	particlePos_mid = [];
            end
            particlePos_left = applyEdgeExchange( particlePos_mid, particlePos(p,:) ); % d_glob + 0.5 * (d_loc - d_glob)
            
            % add random position
            %pRand = psoDiscRandomFact( particlePos(p,:), distances, 0, vRandType );
            pRand = psoDiscRandomFact( particlePos_left, distances, 0, vRandType );
            
            % v_rand = r_rand * b_rand * (p_rand - x_i_temp)
            edgeExch = getListOfEdgeExchanges( particlePos_left, pRand ); 
            if ~isempty(edgeExch) && round(size(edgeExch,1) * rRand * bRand) > 0
                particlePos_rand = edgeExch(1:round(size(edgeExch,1) * rRand * bRand), :); 
            else
            	particlePos_rand = [];
            end
            
            % x_i(t+1) = x_i_temp + v_rand
            particlePos(p,:) = applyEdgeExchange( particlePos_rand,particlePos_left );

            % find new personalBest
            distpersonalBest = distancePath( distances, personalBest(p,:) );
            distAktPos = distancePath( distances, particlePos(p,:) );
            
            if distAktPos < distpersonalBest
                personalBest(p,:) = particlePos(p,:);
            end
        end
        
        % update globalBest after optimization
        [ globalBestPath, globalBestDist ] = findGlobalBestPermutation( distances, personalBest, globalBestPath );
        %fprintf('globalBestPath: %s, %f\n', sprintf('%i ', globalBestPath), globalBestDist);
        if pi >= particleIter
            break
        end
        
        pi = pi + 1;
    end
    % save the best route
    path = globalBestPath;
    
    % calculate the total_length of the cycle
    total_length = distancePath( distances, path );
end

