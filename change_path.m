function path = change_path(path, i, j)

    oldPath = path;
    %fprintf('i: %i, j: %i\n', i, j);
    %fprintf('oldPath: %s\n', sprintf('%i ', oldPath));
    % exchange edge cities
    path(r(i+1, path)) = oldPath(r(i+1+j, path));
    path(r(i+1+j, path)) = oldPath(r(i+1, path));
    
    % change direction of intermediate path 
    for k=1:j-1
        path(r(i+1+k, path)) = oldPath(r(i+1+j-k, path));
    end
    
    %fprintf('newPath: %s\n', sprintf('%i ', path));
end