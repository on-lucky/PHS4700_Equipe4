classdef Variables
    properties (Constant)
        Rcy = 2;
        Hcyh = 20;
        Hcyb = 2;
        Hcy = Variables.Hcyh - Variables.Hcyb;
        CMcy = [4; 4; 11];
        
        xb = 1;
        yb = 2;
        zb = 5;
        CMb = [3.5; 4; 14.5];
        
        notAlreadyCol = 0;
        f1col = 1;
        f2col = 2;
        f3col = 3;
        f4col = 4;
        f5col = 5;
        f6col = 6;
        
        plan1 = Variables.CMb(1) - Variables.xb / 2; % plan en yz
        plan2 = Variables.CMb(1) + Variables.xb / 2; % plan en yz
        plan3 = Variables.CMb(2) - Variables.yb / 2; % plan en xz
        plan4 = Variables.CMb(2) + Variables.yb / 2; % plan en xz
        plan5 = Variables.CMb(3) - Variables.zb / 2; % plan en xy
        plan6 = Variables.CMb(3) + Variables.zb / 2; % plan en xy
        
        N = 400;
        M = 400;
        
        nMaxCollisions = 100;
        
        essai = 3;
    end
end