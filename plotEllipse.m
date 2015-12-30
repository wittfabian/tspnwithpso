function plotEllipse( x0, y0, r1, r2 )

    t = -pi:0.01:pi;

    x = x0 + r1 * cos(t);
    y = y0 + r2 * sin(t);

    plot(x0,y0,'+')
    hold on

    plot(x, y,'LineWidth',3)
    hold on


end

