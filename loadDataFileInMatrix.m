function loadDataFileInMatrix( path, input, delimiterIn, headerlinesIn )

    if nargin < 4
        headerlinesIn = 1;
    end

    if nargin < 3
        delimiterIn = ' ';
    end

    
    if ischar(input)
    
        datastruct = importdata([path input], delimiterIn, headerlinesIn);
        
        assignin('base',['dataset' regexprep(input,'\.(.)*','')], datastruct.data(:,:)); 
        
    elseif iscell(input)
        
        for f=1:1:size(input,2)
            
            datastruct = importdata([path input{f}], delimiterIn, headerlinesIn);
        
            assignin('base',['dataset' regexprep(input{f},'\.(.)*','')], datastruct.data(:,:));   
            
        end  
            
    end
        
end

