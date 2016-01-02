function particlePos = psoOptDiscMovement( particlePos, personalBest, globalBestPath, distances, moveOptions )

    % x_i(t+1) => new position of the particle p
            
    % difference x - y => shortest sequenz of transpositions T
    % length of difference is the length of the sequenz T
    % multiplication s * T => t1, ... t[s*k]
    % addition T1 + T2 = t1.1, ..., t1.k, t2.1, ..., t2.l
    % addition of a difference and a position => applying the transposition of the difference to the position

    % d = destination (point)
    % b_loc & b_glob are constant weights
    % r_loc & r_glob are drawn uniformly at random from [0,1]


    rLoc = (1-0)*rand(1) + 0; % rand between 0 and 1
    rGlob = (1-0)*rand(1) + 0; % rand between 0 and 1
    rRand = (1-0)*rand(1) + 0; % rand between 0 and 1
    bRand = (1-0)*rand(1) + 0; % rand between 0 and 1

    if moveOptions.bLoc >= 0 && moveOptions.bLoc <= 1
        bLoc = moveOptions.bLoc;
    else
        bLoc = 0.3;
    end
    
    if moveOptions.bGlob >= 0 && moveOptions.bGlob <= 1
        bGlob = moveOptions.bGlob;
    else
        bGlob = 0.3;
    end

    
    % d_loc = x_i(t) + r_loc * b_loc * (p_i - x_i(t))
    edgeExch = getListOfEdgeExchanges( particlePos, personalBest ); % (p_i - x_i(t))
    if ~isempty(edgeExch) && round(size(edgeExch,1) * rLoc * bLoc) > 0
        dLoc_list = edgeExch(1:round(size(edgeExch,1) * rLoc * bLoc), :); % r_loc * b_loc * (p_i - x_i(t))
    else
        dLoc_list = [];
    end
    dLoc = applyEdgeExchange( dLoc_list, particlePos ); % x_i(t) + r_loc * b_loc * (p_i - x_i(t))


    % d_glob = x_i(t) + r_glob * b_glob * (p_glob - x_i(t))
    edgeExch = getListOfEdgeExchanges( particlePos, globalBestPath ); % (p_glob - x_i(t))
    if ~isempty(edgeExch) && round(size(edgeExch,1) * rGlob * bGlob) > 0
        dGlob_list = edgeExch(1:round(size(edgeExch,1) * rGlob * bGlob), :); % r_glob * b_glob * (p_glob - x_i(t))
    else
        dGlob_list = [];
    end
    dGlob = applyEdgeExchange( dGlob_list, particlePos ); %  x_i(t) + r_glob * b_glob * (p_glob - x_i(t))

    % d_temp = d_glob + 0.5 * (d_loc - d_glob)
    edgeExch = getListOfEdgeExchanges( dGlob, dLoc ); % (d_loc - d_glob)
    if ~isempty(edgeExch) && round(size(edgeExch,1) * 0.5) > 0
        d_temp_list = edgeExch(1:round(size(edgeExch,1) * 0.5), :); % 0.5 * (d_loc - d_glob)
    else
        d_temp_list = [];
    end
    d_temp = applyEdgeExchange( d_temp_list, dGlob ); % d_glob + 0.5 * (d_loc - d_glob)

    
    % create random position with start or temp position
    if strcmp(moveOptions.randArt, 'randomStart')
        pRand = psoDiscRandomFact( particlePos, distances, moveOptions.vRandIter, moveOptions.vRandType );
    elseif strcmp(moveOptions.randArt, 'randomTemp')
        pRand = psoDiscRandomFact( d_temp, distances, moveOptions.vRandIter, moveOptions.vRandType );
    else % use randomStart
        pRand = psoDiscRandomFact( particlePos, distances, moveOptions.vRandIter, moveOptions.vRandType );
    end
    
    % v_rand = r_rand * b_rand * (p_rand - d_temp)
    edgeExch = getListOfEdgeExchanges( d_temp, pRand ); 
    if ~isempty(edgeExch) && round(size(edgeExch,1) * rRand * bRand) > 0
        v_rand_list = edgeExch(1:round(size(edgeExch,1) * rRand * bRand), :); 
    else
        v_rand_list = [];
    end

    % x_i(t+1) = d_temp + v_rand
    particlePos = applyEdgeExchange( v_rand_list, d_temp );

end

