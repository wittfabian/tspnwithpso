function output = isEdgeCrossover( line1, line2 )

    output = false;

    slope = @(line) (line(2,2) - line(1,2))/(line(2,1) - line(1,1));
    
    m1 = slope(line1);
    m2 = slope(line2);
    
    intercept = @(line,m) line(1,2) - m*line(1,1);
    
    b1 = intercept(line1,m1);
    b2 = intercept(line2,m2);
    
    xintersect = (b2-b1)/(m1-m2);
    
    yintersect = m1*xintersect + b1;
    
    
    if xintersect >= 0 && yintersect >= 0 && ~isinf(xintersect) && ~isinf(yintersect) && sum(line1(1,:) == line2(1,:)) ~= size(line1,2) && sum(line1(2,:) == line2(2,:)) ~= size(line1,2)
        output = true;
    end
end

