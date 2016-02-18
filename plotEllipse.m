function plotEllipse( x0, y0, r1, r2, color)

    t = -pi:0.01:pi;

    x = x0 + r1 * cos(t);
    y = y0 + r2 * sin(t);

    scatter(x0, y0, [], 'black', 'x', 'MarkerFaceColor', 'black')
    
    if nargin < 5
        plot(x, y, 'LineWidth', 2) 
    else 
        plot(x, y, 'LineWidth', 1, 'Color', color)    
    end
    
    
end

