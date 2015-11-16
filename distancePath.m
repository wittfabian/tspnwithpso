function dist = distancePath(data, path)

    dist = 0.0;

    for e=1:1:size(path,2)-1
       
        dist = dist + pdist([data(path(e),:); data(path(e+1),:)], 'euclidean');
    end
    
    dist = dist + pdist([data(path(end),:); data(path(1),:)], 'euclidean');
end