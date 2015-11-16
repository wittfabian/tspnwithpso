function [ path, total_length, travelPoints ] = psoOpt( data, path, swarmQuantity, particleIter, stopThreshold )

    travelPoints = data(:,1:2);
    
    anzCity = size(data,1);
    
    % initialize particles in each ellipse
    particlePos = initializeSwarmMemberFullPath( data, swarmQuantity, 'fourparts' );

    personalBest = particlePos;

    % initialize globalBest with personalBest of the first particle
    [ globalBest, globalBestDist ] = findGlobalBestFullPath( path, personalBest );

    lastVelocity = zeros(anzCity, 2, swarmQuantity);
    lastVelocity(:) = 0.5;
        
    lastGlobalBestDist = globalBestDist + 1;
    
    pi = 1;
    while true

        w = 0.8; % influence of the last velicity

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
            end

            distpersonalBest = distancePath( personalBest(:,:,p), path );

            distAktPos = distancePath( particlePos(:,:,p), path );

            if distAktPos < distpersonalBest
                personalBest(:,:,p) = particlePos(:,:,p);
            end

        end
        % update globalBest after optimization
        [ globalBest, globalBestDist ] = findGlobalBestFullPath( path, personalBest, globalBest );
        fprintf('globalBest %.3f\n', globalBestDist);
        
        if (lastGlobalBestDist - globalBestDist) < stopThreshold || pi >= particleIter
            break
        end
        pi = pi + 1;
        lastGlobalBestDist = globalBestDist;
    end
    % save the best route
    travelPoints = globalBest;
        
    % calculate the total_length of the cycle
    total_length = total_length_of_cycle(distance(travelPoints), path);
end

