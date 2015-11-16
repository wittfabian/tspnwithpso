function [ globalBestCoord, globalBestDist ] = findGlobalBest( personalBest, globalBest, travelPoints, path, aktPos )

    [cityBefore, cityBeyond] = getNextCities(path, aktPos);
    
    globalBestCoord = globalBest;
    globalBestDist = distanceTour([travelPoints(cityBefore,:); globalBestCoord; travelPoints(cityBeyond,:)]);

    for i=1:1:size(personalBest,1)

        distParticle = distanceTour([travelPoints(cityBefore,:); personalBest(i,:); travelPoints(cityBeyond,:)]);

        if distParticle < globalBestDist % set new global best if distance is smaller
            globalBestCoord = personalBest(i,:);
            globalBestDist = distParticle;
        end
    end
end

