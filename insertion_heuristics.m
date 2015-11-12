% generic insertion algorithm
function [path, total_length, distances] = insertion_heuristics(data,insertion_rule,idx_initial_city)

    distances = distance(data);
    n = length(distances);
    
    if nargin < 3
        idx_initial_city=ceil(rand(1)*n);
    end
    
    path = []; % initialize empty path
    outside = (1:n); % set all cities as outside
    
    % add initial city to the path and remove it from the outside list
    [path, outside] = add_to_path(path, outside, outside(idx_initial_city), 1);
    
    for i = 1:1:n-1
        entering_city = insertion_rule(path, outside, distances);
        entry_position = find_entry_position(distances, entering_city, path);
        [path,outside] = add_to_path(path, outside, entering_city, entry_position);
    end
    total_length = total_length_of_cycle(distances, path);
end

function [path, outside] = add_to_path(path, outside, entering_city, entry_position)
    old_path = path;
    outside(outside==entering_city) = []; % delete entering_city from outside list
    path(entry_position) = entering_city; % add entering_city to path
    for i = entry_position:1:length(old_path)
        path(i+1) = old_path(i);
    end
end

function entry_position = find_entry_position(distances, entering_city, path)
    min_increase_in_length = inf;
    global path_length
    path_length = length(path);
    for i=1:1:path_length
        before = distances(path(i), path(r(i+1)));
        after = distances(entering_city, path(i)) + distances(entering_city, path(r(i+1)));
        increase_in_length = after - before;
        if increase_in_length < min_increase_in_length
            min_increase_in_length = increase_in_length;
            entry_position = r(i+1);
        end
    end
end
    
% if index is greater than the path length, turn the index for one round
function result = r(index)
    global path_length
    if index > path_length
        result = index - path_length;
    else
        result = index;
    end
end

