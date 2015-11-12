function entering_city = farthest_insertion(path, outside, distances)

    max_distance = 0;
    
    for i = 1:1:length(path)
        for j = 1:length(outside)
            if distances(path(i), outside(j)) > max_distance
                max_distance = distances(path(i), outside(j));
                entering_city = outside(j);
            end
        end
    end
end

