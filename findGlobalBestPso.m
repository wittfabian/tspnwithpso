function [ globalBestCoord, globalBestDist ] = findGlobalBestPso( path, particlePos, globalBest )

    if nargin == 2
        globalBest = particlePos(:, :, 1);
    end

    globalBestCoord = globalBest;
    globalBestDist = distancePath(distance(globalBest), path);

    for d=1:1:size(particlePos,3)
        
        particlePosDist = distancePath(distance(particlePos(:,:,d)), path);
        
        if particlePosDist < globalBestDist
            globalBestCoord = particlePos(:,:,d);
            globalBestDist = particlePosDist;
        end
    end
end

