function plotSpaceAfterPSO( data, path, travelPoints, plotPath )

    if nargin < 4
        plotPath = false;
    end

    figure;
    hold all;
    for i=1:1:size(data,1)
        plotEllipse( data(i,1), data(i,2), data(i,3), data(i,4) , 'k');
    end
    
    if plotPath == true
        for j=1:1:size(path,2)-1
            plot(travelPoints(path(1,j),1), travelPoints(path(1,j),2), 'o', 'MarkerSize', 5, 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'b');
            plot(travelPoints(path(1,j+1),1), travelPoints(path(1,j+1),2), 'o', 'MarkerSize', 5, 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'b');
            plot([travelPoints(path(1,j),1) travelPoints(path(1,j+1),1)],[travelPoints(path(1,j),2) travelPoints(path(1,j+1),2)], 'b', 'LineWidth', 1.0)
            hold on
        end

        plot(travelPoints(path(1,size(path,2)),1), travelPoints(path(1,size(path,2)),2), 'o', 'MarkerSize', 5, 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'b');
        plot(travelPoints(path(1,1),1), travelPoints(path(1,1),2), 'o', 'MarkerSize', 5, 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'b');
        plot([travelPoints(path(1,size(path,2)),1) travelPoints(path(1,1),1)],[travelPoints(path(1,size(path,2)),2) travelPoints(path(1,1),2)], 'b', 'LineWidth', 1.0)
    end
    
    hold off

end

