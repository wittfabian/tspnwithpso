function [path, total_length] = opt2(path, distances)

    n = size(path,2);
    
    for i=1:n
        for j=1:n-3
            if change_in_path_length(path, i, j, distances) < 0 
                path = change_path(path, i, j);
            end
        end
    end
    
    total_length = distancePath(distances, path);
end
