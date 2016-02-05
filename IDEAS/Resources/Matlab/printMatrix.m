function str = printMatrix(mat, delExtra)
    if nargin < 2
        delExtra = 0;
    end
    
    str = '[';
    for i=1:size(mat,1) 
        for j=1:size(mat,2) - delExtra
            str = [str num2str(mat(i,j),16)];
            if j == size(mat,2)  - delExtra
                if i ~= size(mat,1) 
                    str = [str ';'];
                end
            else
                str = [str ' , '];
            end
        end
    end
    str = [str ']'];
end