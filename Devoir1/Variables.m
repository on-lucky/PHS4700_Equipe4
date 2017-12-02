classdef Variables
    properties (Constant)
        % Dimension
        
        rr = 4.2;
        h1r = 39.1;
        hbasr = (Variables.h1r + Variables.h2r)*2/3;
        hhautr = Variables.h1r - Variables.hbasr;
        h2r = 7.8;
        
        rp = 1.855;
        h1p = 39.9;
        h2p = 5.6;
        
        rn = 3.5;
        h1n = 27.93;
        h2n = 9.31;
        
        % Positions
        
        posCylindreReservoirBas = [0 Variables.rn + Variables.rr 0];
        posCylindreReservoirHaut = [0 Variables.rn + Variables.rr Variables.hbasr];
        posCylindrePropulseurDroit = [Variables.rr + Variables.rp Variables.rn + Variables.rr 0];
        posCylindrePropulseurGauche = [-Variables.rr - Variables.rp Variables.rn + Variables.rr 0];
        posCylindreNavette = [0 0 0];
        
        posConeReservoir = [0 Variables.rn + Variables.rr Variables.h1r];
        posConePropulseurDroit = [Variables.rr + Variables.rp Variables.rn + Variables.rr Variables.h1p];
        posConePropulseurGauche = [-Variables.rr - Variables.rp Variables.rn + Variables.rr Variables.h1p];
        posConeNavette = [0 0 Variables.h1n];
        
        % Masses
        
        mNavette = 109000;
        mPropulseur = 469000;
        mReservoirBas = 108000;
        mReservoirHaut = 631000;
    end
end
