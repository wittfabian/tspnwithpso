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

    pRand = particlePos;
    edgeExch = [];

    for randIter=1:1:iterSteps % apply two edge exchanges
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

