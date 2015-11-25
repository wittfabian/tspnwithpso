function particlePos = initializeSwarmMemberPermutation( data, quantity, type )

    switch(type)
        case 'random'
            particlePos = randomInitialization( data, quantity );
            
        case 'randomFif'
            particlePos = randomInitializationFif( data, quantity );
        
        otherwise
            particlePos = randomInitialization( data, quantity );
    end
end

function particlePos = randomInitialization( data, quantity )

    particlePos = zeros(quantity, size(data,1));

    if quantity > factorial(size(data,1))
        quantity = factorial(size(data,1));
    end

    for p=1:1:quantity % iterate through particles
    
        while true
            newPermutation = randsample(1:size(data,1), size(data,1));
        
            if ~ismember(newPermutation, particlePos, 'rows')
                particlePos(p,:) = newPermutation;
                break
            end
        end
    end
end

function particlePos = randomInitializationFif( data, quantity )

    particlePos = zeros(quantity, size(data,1));

    if quantity > factorial(size(data,1))
        quantity = factorial(size(data,1));
    end

    for p=1:1:quantity % iterate through particles
    
        while true
            newPermutation = [1 randsample(2:size(data,1), size(data,1)-1)];
        
            if ~ismember(newPermutation, particlePos, 'rows')
                particlePos(p,:) = newPermutation;
                break
            end
        end
    end
end
