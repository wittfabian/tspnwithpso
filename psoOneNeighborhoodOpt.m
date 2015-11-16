function [ path, total_length, travelPoints ] = psoOneNeighborhoodOpt( data, path, swarmQuantity, cityIter, particleIter )

    travelPoints = data(:,1:2);

    for r=1:1:cityIter % rounds over all cities

        for n=1:1:length(path) % iterate through the path

            [cityBefore, cityBeyond] = getNextCities(path, n);

            particlePos = initializeSwarmMember( data(n,:), swarmQuantity );

            personalBest = particlePos;

            globalBest = personalBest(1,:); % initialize globalBest with personalBest of the first particle

            [ globalBest, ~ ] = findGlobalBest( personalBest, globalBest, travelPoints, path, n );

            lastVelocity = zeros(swarmQuantity, 2);
            lastVelocity(:) = 0.5;

            for iter=1:1:particleIter % number of iterations for optimization in the ellipse

                w = 0.005; % influence of the last velicity
                    
                for p=1:1:size(particlePos,1) % for each particle

                    phi1 = (1-0)*rand(1) + 0; % rand between 0 and 1
                    phi2 = phi1; %(1-0)*rand(1) + 0; % rand between 0 and 1

                    % v_i(t+1) => new velocity of the particle p
                    newVelocity = w * lastVelocity(p,:)' + phi1 * 1 * (globalBest' - particlePos(p,:)') + phi2 * (personalBest(p,:)' - particlePos(p,:)');

                    % x_i(t+1) => new position of the particle p
                    if isPointInEllipse( data(n,:), (particlePos(p,:) + newVelocity') ) == true
                        particlePos(p,:) = particlePos(p,:) + newVelocity';
                        lastVelocity(p,:) = newVelocity';
                    else
                        % if point leaves the ellipse => set the point at the border
                        [~, XYproj] = Residuals_ellipse(particlePos(p,:), [data(n,:) 0]); 

                        particlePos(p,:) = XYproj;
                    end

                    distpersonalBest = distanceTour([travelPoints(cityBefore,:); personalBest(p,:); travelPoints(cityBeyond,:)]);

                    distAktPos = distanceTour([travelPoints(cityBefore,:); particlePos(p,:); travelPoints(cityBeyond,:)]);

                    if distAktPos < distpersonalBest
                        personalBest(p,:) = particlePos(p,:);
                    end
                end
                % update globalBest after optimization
                [ globalBest, ~ ] = findGlobalBest( personalBest, globalBest, travelPoints, path, n );

            end
            % save the best route
            travelPoints(n,:) = globalBest;
        end
    end
    % calculate the total_length of the cycle
    total_length = total_length_of_cycle(distance(travelPoints), path);
end

