function [ globalBestPath, globalBestDist ] = findGlobalBestPermutation( distances, personalBest, globalBest )

    if nargin == 2
        globalBest = personalBest(1,:);
    end

    globalBestPath = globalBest;
    globalBestDist = distancePath(distances, globalBestPath);

    for d=1:1:size(personalBest,1)
        
        personalBestDist = distancePath(distances, personalBest(d,:));
        
        if personalBestDist < globalBestDist
            globalBestPath = personalBest(d,:);
            globalBestDist = personalBestDist;
        end
    end
end