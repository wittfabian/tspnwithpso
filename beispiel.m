
matlabpool('local', 4);

load('data/datasets.mat');

test = [0 0 0 0];

parfor l=1:1:4
    for i=1:1:1000
        test(1,l) = test(1,l) + 1;
    end
end

save('results/test.mat','test');

clearvars

matlabpool close