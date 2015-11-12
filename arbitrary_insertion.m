% function entering_city = arbitrary_insertion(path,outside,distances)
function entering_city = arbitrary_insertion(~,outside,~)

    entering_city = outside(ceil(rand(1) * length(outside)));
end

