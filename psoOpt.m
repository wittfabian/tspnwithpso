% optimization with PSO
% data - ellipse information with format: x0 y0 rx ry
% path - shortest path until now
% swarmQuantity - number of swarm members per ellipse
% particleIter - maximal number of iterations

function [ path, total_length, travelPoints ] = psoOpt( data, path, swarmQuantity, particleIter, moveOptions)

    %travelPoints = data(:,1:2);
    
    anzCity = size(data,1);
    
    % initialize particles in each ellipse: types: random, fourparts or center
    particlePos = initSwarmMemberPso( data, swarmQuantity, 'random' );
    
    personalBest = particlePos;

    % initialize globalBest with personalBest of the first particle
    [ globalBest, ~ ] = findGlobalBestPso( path, personalBest );
    
    % initialize velocity
    lastVelocity = zeros(anzCity, 2, swarmQuantity);

    % last velicity
    if isfield(moveOptions,'initVelocity')
        lastVelocity(:) = moveOptions.initVelocity;
    else
        lastVelocity(:) = 0.5;
    end
    
    noChangeCount = 0;
    
    % influence of the last velicity
    if isfield(moveOptions,'omega')
        w = moveOptions.omega;
    else
        w = 0.5;
    end
    
    % constant that determine the attraction rate
    if isfield(moveOptions,'c1') % in direction to the global best
        c1 = moveOptions.c1; % 8.0
    else
        c1 = 0.8; % in direction to the global best
    end

    if isfield(moveOptions,'c2') % in direction to the personal best
        c2 = moveOptions.c2; % 5.0
    else
        c2 = 0.5; % in direction to the global best
    end

    pi = 1;
    while true

        for p=1:1:size(particlePos,3) % iterate through particle groups (one particle group = one tour)

            for n=1:1:length(path) % iterate through the path

                phi1 = (1-0.1)*rand(1) + 0.1; % rand between 0 and 1
                phi2 = (1-0.1)*rand(1) + 0.1; % rand between 0 and 1

                % v_i(t+1) => new velocity of the particle p
                newVelocity = w * lastVelocity(n,:,p) + phi1 * c1 * (globalBest(n,:) - particlePos(n,:,p)) + phi2 * c2 * (personalBest(n,:,p) - particlePos(n,:,p));

                % x_i(t+1) => new position of the particle p
                if isPointInEllipse( data(n,:), (particlePos(n,:,p) + newVelocity) ) == true
                    particlePos(n,:,p) = particlePos(n,:,p) + newVelocity;
                    lastVelocity(n,:,p) = newVelocity;
                else
                    %fprintf('out: pi: %i; p: %i; n: %i\n', pi, p, n);
                    % if point leaves the ellipse => set the point at the border
                    XYproj = getNextBoarderPoint( data(n,:), particlePos(n,:,p), (particlePos(n,:,p) + newVelocity) );

                    % XYproj isempty if line between particlePos and particlePos+newVelocity have no intersection with the ellipse
                    % this mean that particlePos lies on the border
                    if ~isempty(XYproj) 
                        deltaX = XYproj(1,1) - particlePos(n,1,p);
                        deltaY = XYproj(1,2) - particlePos(n,2,p);

                        if (deltaX / deltaX) > 0
                            signX = -1;
                        else
                            signX = 1;
                        end

                        if (deltaY / deltaY) > 0
                            signY = -1;
                        else
                            signY = 1;
                        end
                        
                        lastVelocity(n,1,p) = 0; % XYproj(1,1) - particlePos(n,1,p);
                        lastVelocity(n,2,p) = 0; % XYproj(1,2) - particlePos(n,2,p);

                        particlePos(n,1,p) = XYproj(1,1) + (deltaX * signX) * moveOptions.boundaryhandlingPercentage;
                        particlePos(n,2,p) = XYproj(1,2) + (deltaY * signY) * moveOptions.boundaryhandlingPercentage;
                    end
                        
                end
                
                % find new personalBest for city n
                distpersonalBest = distancePath( distance(personalBest(:,:,p)), path );
                distAktPos = distancePath( distance(particlePos(:,:,p)), path );
                if distAktPos <= distpersonalBest
                    personalBest(n,:,p) = particlePos(n,:,p);
                end
            end
        end
        
        % update globalBest after optimization
        lastGlobalBest = globalBest;
        [ globalBest, ~ ] = findGlobalBestPso( path, personalBest, globalBest );
        
        % use turbulence mechanism
        if lastGlobalBest == globalBest
            noChangeCount = noChangeCount + 1;
        end
        
        if isfield(moveOptions,'noChangeCountTh') && moveOptions.noChangeCountTh > 0 && noChangeCount > moveOptions.noChangeCountTh
            tfp = round( (swarmQuantity - 1) * rand(1) + 1 );
            particlePos(:,:,tfp) = initSwarmMemberPso( data, 1 ,'random');
            noChangeCount = 0;
        end
       
        if pi >= particleIter || (isfield(moveOptions,'noChangeIterStop') && noChangeCount > moveOptions.noChangeIterStop)
            break
        end

        pi = pi + 1;
    end
    % save the best route
    travelPoints = globalBest;
        
    % calculate the total_length of the cycle
    total_length = distancePath(distance(travelPoints), path);
end

