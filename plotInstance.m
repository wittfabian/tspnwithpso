
l = 1;

data = dataset_tspn2DE5_1;

travelPoints = optimalPath(:,:,l);

path = optimalPathOrder(l,:);

plotSpaceAfterPSO( data, path, travelPoints );