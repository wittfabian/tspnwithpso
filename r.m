% if index is greater than the path length, turn the index for one round
function result = r(idx, path)

    pathLength = size(path, 2);

    if idx > pathLength
        result = idx - pathLength;
    else
        result = idx;
    end
end