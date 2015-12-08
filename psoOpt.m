% optimization with PSO
% data - ellipse information with format: x0 y0 rx ry
% path - shortest path until now
% swarmQuantity - number of swarm members per ellipse
% particleIter - maximal number of iterations

function [ path, total_length, travelPoints ] = psoOpt( data, path, swarmQuantity, particleIter, moveOptionsPSO)

    travelPoints = data(:,1:2);
    
    anzCity = size(data,1);
    
    % initialize particles in each ellipse: types: random, fourparts or center
    particlePos = initializeSwarmMemberFullPath( data, swarmQuantity, 'random' );
    
    personalBest = particlePos;

    % initialize globalBest with personalBest of the first particle
    [ globalBest, ~ ] = findGlobalBestFullPath( path, personalBest );
    
    % initialize velocity
    lastVelocity = zeros(anzCity, 2, swarmQuantity);
    lastVelocity(:) = 0.5;
    
    noChangeCount = 0;

    pi = 1;
    while true

        w = 0.5; % influence of the last velicity

        for p=1:1:size(particlePos,3) % iterate through particles (one particle = one tour)

            for n=1:1:length(path) % iterate through the path

                phi1 = (1-0)*rand(1) + 0; % rand between 0 and 1
                phi2 = (1-0)*rand(1) + 0; % rand between 0 and 1

                % v_i(t+1) => new velocity of the particle p
                newVelocity = w * lastVelocity(n,:,p)' + phi1 * 1 * (globalBest(n,:)' - particlePos(n,:,p)') + phi2 * (personalBest(n,:,p)' - particlePos(n,:,p)');

                % x_i(t+1) => new position of the particle p
                if isPointInEllipse( data(n,:), (particlePos(n,:,p) + newVelocity') ) == true
                    particlePos(n,:,p) = particlePos(n,:,p) + newVelocity';
                    lastVelocity(n,:,p) = newVelocity';
                else
                    % if point leaves the ellipse => set the point at the border
                    XYproj = getNextBoarderPoint( data(n,:), particlePos(n,:,p), (particlePos(n,:,p) + newVelocity') );

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

                        particlePos(n,1,p) = XYproj(1,1) + (deltaX * signX) * moveOptionsPSO.boundaryhandlingPercentage;
                        particlePos(n,2,p) = XYproj(1,2) + (deltaY * signY) * moveOptionsPSO.boundaryhandlingPercentage;
                    end
                        
                end
                
                % find new personalBest for city n
                distpersonalBest = distancePath( distance(personalBest(:,:,p)), path );
                distAktPos = distancePath( distance(particlePos(:,:,p)), path );
                if distAktPos < distpersonalBest
                    personalBest(n,:,p) = particlePos(n,:,p);
                end
            end
        end
        
        % update globalBest after optimization
        lastGlobalBest = globalBest;
        [ globalBest, ~ ] = findGlobalBestFullPath( path, personalBest, globalBest );
        
        if lastGlobalBest == globalBest
            noChangeCount = noChangeCount + 1;
        end
        
        if noChangeCount > moveOptionsPSO.noChangeCountTh
            tfp = round( (swarmQuantity - 1) * rand(1) + 1 );
            particlePos(:,:,tfp) = initializeSwarmMemberFullPath( data, 1 ,'random');
            personalBest(:,:,tfp) = particlePos(:,:,tfp);
            noChangeCount = 0;
        end
       
        if pi >= particleIter
            break
        end

        pi = pi + 1;
    end
    % save the best route
    travelPoints = globalBest;
        
    % calculate the total_length of the cycle
    total_length = distancePath(distance(travelPoints), path);
end
