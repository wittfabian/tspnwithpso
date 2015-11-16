function [ globalBestCoord, globalBestDist ] = findGlobalBestFullPath( path, personalBest, globalBest )

    if nargin == 2
        globalBest = personalBest(:, :, 1);
    end

    globalBestCoord = globalBest;
    globalBestDist = distancePath(globalBest, path);

    for d=1:1:size(personalBest,3)
        
        personalBestDist = distancePath(personalBest(:,:,d), path);
        
        if personalBestDist < globalBestDist
            globalBestCoord = personalBest(:,:,d);
            globalBestDist = personalBestDist;
        end
    end
end

