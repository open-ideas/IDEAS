function str = printStateSpace(sys, delExtra)
    if nargin < 2
        delExtra = 0;
    end
    
    str = ['A = ' printMatrix(sys.A,0) ',' ];
    str = [str 'B = ' printMatrix(sys.B,delExtra) ','];
    str = [str 'C = ' printMatrix(sys.C,0) ''];
    
    display(['A = ' printMatrix(sys.A,0) ',' ]);
    display(['B = ' printMatrix(sys.B,delExtra) ','])
    display(['C = ' printMatrix(sys.C,0) ','])
end