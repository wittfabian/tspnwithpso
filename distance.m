%for original data-matrix only use first two colums
function d = distance(a)
    n = length(a);
    d = zeros(n,n);
    for i = 1:n
        for j = i+1:n
            %d(i,j)=norm(a(i,:)-a(j,:));
            d(i,j)=pdist([a(i,:);a(j,:)],'euclidean');
            d(j,i)=d(i,j);
        end;
    end
end

