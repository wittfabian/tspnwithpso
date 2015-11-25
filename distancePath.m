function dist = distancePath(distances, path)

    dist = 0.0;

    for e=1:1:size(path,2)-1
        
        dist = dist + distances(path(e), path(e+1));
    end
    
    dist = dist + distances(path(end), path(1));
end