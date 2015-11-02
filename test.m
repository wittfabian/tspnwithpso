
%list of datafiles
filename = {'_tspn2DE5_1', '_tspn2DE5_2', '_tspn2DE6_1', '_tspn2DE6_2', '_tspn2DE7_1', '_tspn2DE7_2', '_tspn2DE8_1', '_tspn2DE8_2', '_tspn2DE9_1', '_tspn2DE9_2', '_tspn2DE10_1', '_tspn2DE10_2', '_tspn2DE11_1', '_tspn2DE11_2', '_tspn2DE12_1', '_tspn2DE12_2', '_tspn2DE13_1', '_tspn2DE13_2', '_tspn2DE14_1', '_tspn2DE14_2', '_tspn2DE15_1', '_tspn2DE15_2', '_tspn2DE16_1', '_tspn2DE16_2'};

%set the delimiter
delimiterIn = ' ';

%set the header, if exist
headerlinesIn = 1; 

%loop through the files
for f=1:1:1 %size(filename,2)
    
    %load datafile
    datastruct = importdata(['data/' filename{f} '.dat'], delimiterIn, headerlinesIn);

    %get the data
    data = datastruct.data(:,:);

    %plot the ellipse
    for i=1:1:size(data,1)

        plotEllipse( data(i,1), data(i,2), data(i,3), data(i,4) );

    end
    
end

