% check last n lements of dist whether the distance has changed
function res = checkDistChange( dist, n )

    if size(dist,1) <= n
        start = 1;
    else 
        start = size(dist,1) - n + 1;
    end

    res = ( sum( dist(start:end,1) ) / dist(end,1) ) ~= n;
end

