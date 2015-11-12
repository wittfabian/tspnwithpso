function plotSpace( data, path )

    figure;
    for i=1:1:size(data,1)
        plotEllipse( data(i,1), data(i,2), data(i,3), data(i,4) );
    end
    
    for j=1:1:size(path,2)-1
        plot([data(path(1,j),1) data(path(1,j+1),1)],[data(path(1,j),2) data(path(1,j+1),2)], 'k')
        hold on
    end

    plot([data(path(1,size(path,2)),1) data(path(1,1),1)],[data(path(1,size(path,2)),2) data(path(1,1),2)], 'k')
    hold off

end

