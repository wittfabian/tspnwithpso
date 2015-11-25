function list = getListOfEdgeExchanges( ispath, shallpath )
    
    list = [];

    if size(ispath,2) ~= size(shallpath,2)
        return
    end
    
    if sum( ispath == shallpath ) == size(shallpath,2)
        return 
    end

    while sum( ispath == shallpath ) ~= size(shallpath,2)

        for i=1:1:size(shallpath,2)

            if ispath(1,i) ~= shallpath(1,i)
                excEl = find(ispath==shallpath(1,i));
                ispath = edgeR(ispath, i, excEl);
                list = [list; i excEl];
            end
        end
    end
end

