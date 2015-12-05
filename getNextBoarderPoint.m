function borderPoint = getNextBoarderPoint( data, oldPoint, newPoint )

    borderPoint = [];

    rrx = data(1,3)^2;
    rry = data(1,4)^2;
    
    x21 = newPoint(1,1) - oldPoint(1,1);
    y21 = newPoint(1,2) - oldPoint(1,2);
    
    x10 = oldPoint(1,1) - data(1,1);
    y10 = oldPoint(1,2) - data(1,2);
    
    a = (x21 * x21 / rrx) + (y21 * y21 / rry);
    b = (x21 * x10 / rrx) + (y21 * y10 / rry);
    c = (x10 * x10 / rrx) + (y10 * y10 / rry);
    d = b * b - a * (c-1);
    
    if d >= 0
        e = sqrt(d);
        u1 = (-b-e) / a;
        u2 = (-b+e) / a;
        
        if 0 <= u1 && u1 <= 1
            borderPoint = [borderPoint; oldPoint(1,1)+x21*u1 oldPoint(1,2)+y21*u1];
        end
        
        if 0 <= u2 && u2 <= 1
            borderPoint = [borderPoint; oldPoint(1,1)+x21*u2 oldPoint(1,2)+y21*u2];
        end
    end
end

