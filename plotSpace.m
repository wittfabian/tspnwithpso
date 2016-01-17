function plotSpace( data, path, plotPath )

    if nargin < 3
        plotPath = false;
    end
    
    color = [1 1 0; 0 0 0; 0 0 1; 0 1 0; 0 1 1; 1 0 0; 1 0 1; 1 1 1; 0.251 0 0.502; 0.502 0.251 0; 0 0.251 0; 0.502 0.502 0.502; 0.502 0.502 1; 0 0.502 0.502; 0.502 0 0; 1 0.502 0.502];	


    figure;
    hold all;
    
    for i=1:1:size(data,1)
        %plotEllipse( data(i,1), data(i,2), data(i,3), data(i,4), color(i,:));
        plotEllipse( data(i,1), data(i,2), data(i,3), data(i,4));
    end
    
    if plotPath == true
        for j=1:1:size(path,2)-1
            plot([data(path(1,j),1) data(path(1,j+1),1)],[data(path(1,j),2) data(path(1,j+1),2)], 'k', 'LineWidth', 1.5)
        end

        plot([data(path(1,size(path,2)),1) data(path(1,1),1)],[data(path(1,size(path,2)),2) data(path(1,1),2)], 'k', 'LineWidth', 1.5)
    end
    
    hold off
end

