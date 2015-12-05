function pRand = psoDiscRandomFact( particlePos, distances, iterSteps, type )

    switch(type)
        case 'edgeExch'
            pRand = edgeExchRandomFact( particlePos, iterSteps );
            
        case '2opt'
            pRand = twoOptRandomFact( particlePos, distances );
        
        otherwise
            pRand = particlePos;
    end
    
end

function pRand = edgeExchRandomFact( particlePos, iterSteps )

    if iterSteps <= 0 || isempty(iterSteps)
        iterSteps = 2;
    end

    pRand = particlePos;
    edgeExch = [];

    for randIter=1:1:iterSteps
        while true
            startR = max(round((size(pRand,2)-1)*rand(1) + 1),1);
            endR = startR + max(round((size(pRand,2)-1)*rand(1) + 1),1);

            if r(startR, pRand) ~= r(endR, pRand)
                edgeExch = [edgeExch; r(startR, pRand) r(endR, pRand)];
                break
            end 
        end
    end
    pRand = applyEdgeExchange( edgeExch, pRand );

end


function pRand = twoOptRandomFact( particlePos, distances )
    
    [pRand, ~] = opt2(particlePos, distances);
    
end

