function particlePos = initializeSwarmMember( ellipse, quantity )

    particlePos = zeros(quantity, 2);
    
    for i=1:1:quantity
        
        while true
            % x pos
            particlePos(i,1) = ((ellipse(1,1) + ellipse(1,3)) - (ellipse(1,1) - ellipse(1,3))) * rand(1) + (ellipse(1,1) - ellipse(1,3)); 
            % y pos
            particlePos(i,2) = ((ellipse(1,2) + ellipse(1,4)) - (ellipse(1,2) - ellipse(1,4))) * rand(1) + (ellipse(1,2) - ellipse(1,4));
            
            if isPointInEllipse( ellipse, particlePos(i,:) ) == true
                break
            end
        end
    end
end

