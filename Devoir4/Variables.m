classdef Variables
    properties (Constant)
        Rcy = 2;
        Hcyh = 20;
        Hcyb = 2;
        Hcy = Variables.Hcyh - Variables.Hcyb;
        CMcy = [4 4 11];
        
        xb = 1;
        yb = 2;
        zb = 5;
        CMb = [3.5 4 14.5];
        
        f1col = 'red';
        f2col = 'cyan';
        f3col = 'green';
        f4col = 'yellow';
        f5col = 'blue';
        f6col = 'magenta';
        
        N = 10;
        M = 10;
        
        essai = 1;
    end
end