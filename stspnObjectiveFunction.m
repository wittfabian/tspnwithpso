function [ sum ] = stspnObjectiveFunction( q )

    sum = 0;

    for i=1:1:size(q,1)
        
        for j=1:1:size(q,1)
            
            if j > i
                
                sum = sum + hypot(q(j,1) - q(i,1), q(j,2) - q(i,2)); % xj - xi, yj - yi
               
            end
            
        end
        
    end

end


