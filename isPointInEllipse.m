% ellipseData = eData: x_e, y_e, rx, ry
% pointData = pData: x_p, y_p
%
% The region (disk) bounded by the ellipse is given by the equation
%
% ( (x_p - x_e)^2 / rx^2 ) + ( (y_p - y_e)^2 / ry^2 ) <= 1
% 
function test = isPointInEllipse( eData, pData )

    test = (((pData(1,1) - eData(1,1))^2 / eData(1,3)^2) + ((pData(1,2) - eData(1,2))^2 / eData(1,4)^2)) <= 1;

end

