% given a list l = (c1, c2, ..., cn) of cities representing a round-trip,
% the edge recombination operator edgeR(i,j) inserts the sequenz of cities
% between indecies i an j
function newPath = edgeR( path, i, j )

    if i < j

        if i > 1
            front = path(1,1:i-1);
        else
            front = [];
        end

        list = path(1,i:j);

        if j < size(path,2)
            back = path(1,j+1:end);
        else
            back = [];
        end

        newPath = [front fliplr(list) back];
    else
        newPath = path;
    end

end

