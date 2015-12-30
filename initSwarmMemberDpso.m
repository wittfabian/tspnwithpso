function particlePos = initSwarmMemberDpso( data, quantity, type )

    switch(type)
        case 'randomNoDup'
            particlePos = randomInitializationNoDuplicate( data, quantity );
            
        case 'randomWithDup'
            particlePos = randomInitializationWithDuplicate( data, quantity );
            
        case 'randomFifNoDup'
            particlePos = randomInitializationFifNoDuplicate( data, quantity );
        
        otherwise
            particlePos = randomInitializationNoDuplicate( data, quantity );
    end
end

function particlePos = randomInitializationNoDuplicate( data, quantity )

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

function particlePos = randomInitializationWithDuplicate( data, quantity )

    particlePos = zeros(quantity, size(data,1));

    for p=1:1:quantity % iterate through particles
        
        particlePos(p,:) = randsample(1:size(data,1), size(data,1));
        
    end
end

% fif: first is fixed; first position is always position one (1)
function particlePos = randomInitializationFifNoDuplicate( data, quantity )

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
