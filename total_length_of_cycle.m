% calculate the total length of a tour, given the distances and the path
function total_length = total_length_of_cycle(distances, path)
    total_length = 0;
    for i = 1:1:length(path)-1
        total_length = total_length + distances(path(i), path(i+1));
    end
    total_length = total_length + distances(path(end), path(1));
end

