function path = applyEdgeExchange( exchList, path )

    if isempty(path) || isempty(exchList)
        return
    end
    
    l = 1;
    if size(exchList,1) > 1
        while true

            if exchList(l,:) == exchList(l+1,:)
                exchList(l+1,:) = [];
            end

            if l+1 >= size(exchList,1)
                break
            else
                l = l + 1;
            end
        end
    end

    for e=1:1:size(exchList,1)
        path = edgeR( path, exchList(e,1), exchList(e,2) );
    end
end

