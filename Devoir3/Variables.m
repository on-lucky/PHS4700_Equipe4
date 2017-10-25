classdef Variables
    properties (Constant)
        
        %voiture A
        ma = 1540;
        La = 4.78;
        la = 1.82;
        ha = 1.8;
        
        raExterne = sqrt((Variables.La/2)^2 + (Variables.la/2)^2);
        
        %voiture B
        mb = 1010;
        Lb = 4.23;
        lb = 1.6;
        hb = 1.8;
        
        rbExterne = sqrt((Variables.Lb/2)^2 + (Variables.lb/2)^2);
        
        aGrav = 9.81;
        
        coefficientRes = 0.8;
        
        erreur = 0.01;
        vitesseMinimaleSimulation = 0.01;
        
        collIndetermine = -1;
        collReussie = 0;
        collRatee = 1;
        collProximite = 2;
        
        avecFrot = true;
    end
    
    methods (Static)   
        function coFrot = coefficientFrot(vitesse)
            if (norm(vitesse) < 50) 
                coFrot = 0.15 * (1 - (norm(vitesse) / 100));
            else
                coFrot = 0.075;
            end  
        end
    end
end