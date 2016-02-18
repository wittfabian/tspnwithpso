
l = 95; 

data = dataset_tspn2DE12_1;

travelPoints = optimalPath(:,:,l);

path = optimalPathOrder(l,:);

%plotSpace( data, path, true )

plotSpaceAfterPSO( data, path, travelPoints, true);