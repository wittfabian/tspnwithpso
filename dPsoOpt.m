function [ path, total_length ] = dPsoOpt( data, swarmQuantity, particleIter)

    path = 1:size(data,1); % initialize path
    
    total_length = distancePath( data(:,1:2), path ); % initialize total_length

    % initialize particles: types: random
    particlePos = initializeSwarmMemberPermutation( data, swarmQuantity, 'random' );
    
    personalBest = particlePos;
    
    % initialize globalBest with personalBest of the first particle
    [ globalBestPath, globalBestDist ] = findGlobalBestPermutation( data, personalBest );
    
    fprintf('globalBestPath: %s, %f\n', sprintf('%i ', globalBestPath), globalBestDist);
    
    % initialize velocity
    %lastVelocity = zeros(swarmQuantity,1);
    %lastVelocity(:) = 0; %size(data,1) / 2;
    
    pi = 1;
    
    %w = 0;
    
    while true
        
        for p=1:1:swarmQuantity % iterate through particles (one particle = one tour)
            
            rLoc = (1-0)*rand(1) + 0; % rand between 0 and 1
            rGlob = rLoc; %(1-0)*rand(1) + 0; % rand between 0 and 1
            rRand = (1-0)*rand(1) + 0; % rand between 0 and 1
            
            bLoc = 0.5;
            bGlob = 0.5;
            bRand = (1-0)*rand(1) + 0; % rand between 0 and 1
            
            pRand = initializeSwarmMemberPermutation( data, 1, 'random' );
            
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

            edgeExch = getListOfEdgeExchanges( data, particlePos(p,:), personalBest(p,:) ); % (p_i - x_i(t))
            if ~isempty(edgeExch) && round(size(edgeExch,1) * rLoc * bLoc) > 0
                dLoc_right = edgeExch(1:max(round(size(edgeExch,1) * rLoc * bLoc),1), :); % r_loc * b_loc * (p_i - x_i(t))
            else
                dLoc_right = [];
            end
            dLoc = applyEdgeExchange( dLoc_right, particlePos(p,:) ); % x_i(t) + r_loc * b_loc * (p_i - x_i(t))

            
            % d_glob = x_i(t) + r_glob * b_glob * (p_glob - x_i(t))
            edgeExch = getListOfEdgeExchanges( data, particlePos(p,:), globalBestPath ); % (p_glob - x_i(t))
            if ~isempty(edgeExch) && round(size(edgeExch,1) * rGlob * bGlob) > 0
                dGlob_right = edgeExch(1:max(round(size(edgeExch,1) * rGlob * bGlob),1), :); % r_glob * b_glob * (p_glob - x_i(t))
            else
            	dGlob_right = [];
            end
            dGlob = applyEdgeExchange( dGlob_right, particlePos(p,:) ); %  x_i(t) + r_glob * b_glob * (p_glob - x_i(t))

            
            % v_rand = r_rand * b_rand * (p_rand - x_i(t))
            edgeExch = getListOfEdgeExchanges( data, particlePos(p,:), pRand ); % (p_rand - x_i(t))
            if ~isempty(edgeExch) && round(size(edgeExch,1) * rLoc * bLoc) > 0
                vRand = edgeExch(1:max(round(size(edgeExch,1) * rRand * bRand),1), :); % r_rand * b_rand * (p_rand - x_i(t))
            else
            	vRand = [];
            end

            % x_i(t+1) = d_glob + 0.5 * (d_loc - d_glob) + v_rand;
            edgeExch = getListOfEdgeExchanges( data, dGlob, dLoc ); % (d_loc - d_glob)
            if ~isempty(edgeExch) && round(size(edgeExch,1) * 0.5) > 0
                particlePos_mid = edgeExch(1:max(round(size(edgeExch,1) * 0.5),1), :); % 0.5 * (d_loc - d_glob)
            else
            	particlePos_mid = [];
            end
            %fprintf('p: %i; 1 - path: %s\n', p, sprintf('%i ', particlePos(p,:)));
            particlePos_left = [particlePos_mid; vRand]; % 0.5 * (d_loc - d_glob) + v_rand
            particlePos(p,:) = applyEdgeExchange( particlePos_left, particlePos(p,:) ); %  d_glob + 0.5 * (d_loc - d_glob) + v_rand
            

            % find new personalBest
            distpersonalBest = distancePath( data, personalBest(p,:) );
            distAktPos = distancePath( data, particlePos(p,:) );
            
            %fprintf('p: %i; 2 - path: %s; %f\n', p, sprintf('%i ', particlePos(p,:)), distAktPos);
            %fprintf('p: %i; anzChanges: %i\n', p, size(particlePos_left,1));
            
            if distAktPos < distpersonalBest
                personalBest(p,:) = particlePos(p,:);
            end
            fprintf('p: %i; path: %s; %f\n', p, sprintf('%i ', particlePos(p,:)), distAktPos);
        end
        
        % update globalBest after optimization
        [ globalBestPath, globalBestDist ] = findGlobalBestPermutation( data, personalBest, globalBestPath );
        fprintf('globalBestPath: %s, %f\n', sprintf('%i ', globalBestPath), globalBestDist);
        if pi >= particleIter
            break
        end
        
        pi = pi + 1;
    end
    % save the best route
    path = globalBestPath;
    
    % calculate the total_length of the cycle
    total_length = total_length_of_cycle(distance(data), path);
end

