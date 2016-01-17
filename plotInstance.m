
l = 29;

data = dataset_tspn2DE8_2;

travelPoints = optimalPath(:,:,l);

path = optimalPathOrder(l,:);

%plotSpace( data, path, true )

plotSpaceAfterPSO( data, path, travelPoints, true);