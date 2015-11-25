function result = change_in_path_length(path, i, j, distances)

    before = distances(path(r(i, path)), path(r(i+1,path))) + distances(path(r(i+1+j, path)), path(r(i+2+j, path)));
    
    after = distances(path(r(i, path)), path(r(i+1+j, path))) + distances(path(r(i+1, path)), path(r(i+2+j, path)));
    
    result = after - before; 
end