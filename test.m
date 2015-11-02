
%list of datafiles
filename = {'_tspn2DE5_1', '_tspn2DE5_2'};

%set the delimiter
delimiterIn = ' ';

%set the header, if exist
headerlinesIn = 1; 

%loop through the files
for f=1:1:size(filename,2)
    
    %load datafile
    datastruct = importdata(['data/' filename{f} '.dat'], delimiterIn, headerlinesIn);

    %get the data
    data = datastruct.data(:,:);

    %plot the ellipse
    for i=1:1:size(data,1)

        plotEllipse( data(i,1), data(i,2), data(i,3), data(i,4) );

    end
    
end

