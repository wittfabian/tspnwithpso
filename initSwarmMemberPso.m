function particlePos = initSwarmMemberPso( data, quantity, type )

    switch(type)
        case 'random'
            particlePos = randomInitialization( data, quantity );
            
        case 'fourparts'
            particlePos = fourpartsInitialization( data, quantity );
            
        case 'center'
            particlePos = centerInitialization( data, quantity );
        
        otherwise
            particlePos = randomInitialization( data, quantity );
    end
end

function particlePos = randomInitialization( data, quantity )

    particlePos = zeros(size(data,1), 2, quantity); % 3th dimension is the particle

    for p=1:1:quantity % iterate through particles
        
        for c=1:1:size(particlePos,1) % iterate through cities

            while true
                % x pos
                particlePos(c,1,p) = ((data(c,1) + data(c,3)) - (data(c,1) - data(c,3))) * rand(1) + (data(c,1) - data(c,3)); 
                % y pos
                particlePos(c,2,p) = ((data(c,2) + data(c,4)) - (data(c,2) - data(c,4))) * rand(1) + (data(c,2) - data(c,4));

                if isPointInEllipse( data(c,:), particlePos(c,:,p) ) == true
                    break
                end
            end
        end
    end
end

function particlePos = fourpartsInitialization( data, quantity )

    particlePos = zeros(size(data,1), 2, quantity); % 3th dimension is the particle

    for c=1:1:size(particlePos,1) % iterate through cities
        
        if quantity == 1
            particlePos = randomInitialization( data, quantity );
        elseif quantity > 1

            aktParticle = 1;

            % separate ellipse in four parts (upper left (1), upper right (2), lower right (3), lower left (4))
            while aktParticle <= quantity
                for s=1:1:4 % iterate through all parts

                    if aktParticle > quantity
                        break
                    end

                    upperBound = 0.0;
                    lowerBound = 0.0;
                    leftBound = 0.0;
                    rightBound = 0.0;

                    switch(s)
                        case 1 % upper left (1)
                            upperBound = data(c,2) + data(c,4);
                            lowerBound = data(c,2);
                            leftBound = data(c,1) - data(c,3);
                            rightBound = data(c,1);

                        case 2 % upper right (2)
                            upperBound = data(c,2) + data(c,4);
                            lowerBound = data(c,2);
                            leftBound = data(c,1);
                            rightBound = data(c,1) + data(c,3);

                        case 3 % lower right (3)
                            upperBound = data(c,2);
                            lowerBound = data(c,2) - data(c,4);
                            leftBound = data(c,1);
                            rightBound = data(c,1) + data(c,3);
                            
                        case 4 % lower left (4)
                            upperBound = data(c,2);
                            lowerBound = data(c,2) - data(c,4);
                            leftBound = data(c,1) - data(c,3);
                            rightBound = data(c,1);
                    end
                    
                    while true
                        % x pos
                        particlePos(c,1,aktParticle) = (rightBound - leftBound) * rand(1) + leftBound; 
                        % y pos
                        particlePos(c,2,aktParticle) = (upperBound - lowerBound) * rand(1) + lowerBound;

                        if isPointInEllipse( data(c,:), particlePos(c,:,aktParticle) ) == true
                            break
                        end
                    end
                    
                    aktParticle = aktParticle + 1;
                end
            end
        end
    end
end

function particlePos = centerInitialization( data, quantity )

    particlePos = zeros(size(data,1), 2, quantity); % 3th dimension is the particle

    for p=1:1:quantity % iterate through particles
        
        for c=1:1:size(particlePos,1) % iterate through cities

            particlePos(c,:,p) = data(c,1:2);
            
        end
    end
end