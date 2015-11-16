function dist = distanceTour(data)

    dist = 0.0;

    for e=1:1:size(data,1)-1
       
        dist = dist + pdist([data(e,:); data(e+1,:)],'euclidean');
        
    end
end
