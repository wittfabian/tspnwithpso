function [ cityBefore, cityBeyond ] = getNextCities( path, aktCity )

    if find(path==aktCity) == 1 % aktCity is first element
        cityBefore = path(end);
        cityBeyond = path(2);
    elseif find(path==aktCity) == length(path) % aktCity is last element
        cityBefore = path(end-1);
        cityBeyond = path(1);
    else 
        cityBefore = path(find(path==aktCity)-1);
        cityBeyond = path(find(path==aktCity)+1);
    end

end

