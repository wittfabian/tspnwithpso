function [ globalBestPath, globalBestDist ] = findGlobalBestDpso( distances, particlePos, globalBest )

    if nargin == 2
        globalBest = particlePos(1,:);
    end

    globalBestPath = globalBest;
    globalBestDist = distancePath(distances, globalBestPath);

    for d=1:1:size(particlePos,1)
        
        particlePosDist = distancePath(distances, particlePos(d,:));
        
        if particlePosDist < globalBestDist
            globalBestPath = particlePos(d,:);
            globalBestDist = particlePosDist;
        end
    end
end