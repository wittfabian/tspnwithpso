% optimization with PSO
% data - ellipse information with format: x0 y0 rx ry
% path - shortest path until now
% swarmQuantity - number of swarm members per ellipse
% particleIter - maximal number of iterations
% stopThreshold - minimal change in global distance to continue optimization
% useTurbulenceFactor - decide whether turbulence factor should be used or not
% tfNewSet - if useTurbulenceFactor == true: number of particles that were used for turbulence factoring

function [ path, total_length, travelPoints ] = psoOpt( data, path, swarmQuantity, particleIter, stopThreshold, useTurbulenceFactor, tfNewSet, changeInLastElements )

    travelPoints = data(:,1:2);
    
    anzCity = size(data,1);
    
    % initialize particles in each ellipse: types: random, fourparts or center
    particlePos = initializeSwarmMemberFullPath( data, swarmQuantity, 'random' );
    
    personalBest = particlePos;

    % initialize globalBest with personalBest of the first particle
    [ globalBest, globalBestDist ] = findGlobalBestFullPath( path, personalBest );
    
    % initialize velocity
    lastVelocity = zeros(anzCity, 2, swarmQuantity);
    lastVelocity(:) = 0.5;
        
    lastGlobalBestDist(1,1) = globalBestDist + 1;
    lastGlobalBestDist(2,1) = globalBestDist + 2;
    
    addTF = 0;
    pi = 1;
    while true

        w = 0.5; % influence of the last velicity

        for p=1:1:size(particlePos,3) % iterate through particles (one particle = one tour)

            for n=1:1:length(path) % iterate through the path

                phi1 = (1-0)*rand(1) + 0; % rand between 0 and 1
                phi2 = phi1; %(1-0)*rand(1) + 0; % rand between 0 and 1

                % v_i(t+1) => new velocity of the particle p
                newVelocity = w * lastVelocity(n,:,p)' + phi1 * 1 * (globalBest(n,:)' - particlePos(n,:,p)') + phi2 * (personalBest(n,:,p)' - particlePos(n,:,p)');

                % x_i(t+1) => new position of the particle p
                if isPointInEllipse( data(n,:), (particlePos(n,:,p) + newVelocity') ) == true
                    particlePos(n,:,p) = particlePos(n,:,p) + newVelocity';
                    lastVelocity(n,:,p) = newVelocity';
                else
                    % if point leaves the ellipse => set the point at the border
                    [ ~, XYproj ] = Residuals_ellipse(particlePos(n,:,p), [data(n,:) 0]); 

                    particlePos(n,:,p) = XYproj;
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
        [ globalBest, globalBestDist ] = findGlobalBestFullPath( path, personalBest, globalBest );
        %fprintf('globalBest %.3f\n', globalBestDist);
        
        
        %fprintf('lastGlobalBestDist: %.5f; globalBestDist: %.5f; iter: %i\n', lastGlobalBestDist(end,1), globalBestDist, pi);
        lastGlobalBestDist = [lastGlobalBestDist; globalBestDist];
        tfUsed = zeros(size(path,2), tfNewSet);
        if ~checkDistChange( lastGlobalBestDist, 2 ) && addTF < 1 && useTurbulenceFactor == true % add turbulence factor 
            %fprintf('add turbulence factor\n');
            
            for s=1:1:size(path,2)
                for pt = 1:1:tfNewSet
                    while true
                        tfp = round( (swarmQuantity - 1) * rand(1) + 1 ); 

                        if sum(ismember(tfUsed(s,:), tfp)) == 0

                            particlePos(s,:,tfp) = initializeSwarmMember( data(s,:), 1 ); 
                            personalBest(s,:,tfp) = particlePos(s,:,tfp);
                            tfUsed(s,pt) = tfp;
                            break
                        end
                    end
                end
            end
            lastGlobalBestDist = [];
            lastGlobalBestDist(1,1) = globalBestDist + 1;
            lastGlobalBestDist(2,1) = globalBestDist + 2;
            addTF = addTF + 1;
            
        elseif ((lastGlobalBestDist(end-1,1) - globalBestDist) < stopThreshold && (lastGlobalBestDist(end-1,1) - globalBestDist) > 0) || ~checkDistChange( lastGlobalBestDist, changeInLastElements ) || pi >= particleIter
            break
        end

        pi = pi + 1;
    end
    % save the best route
    travelPoints = globalBest;
        
    % calculate the total_length of the cycle
    total_length = distancePath(distance(travelPoints), path);
end

