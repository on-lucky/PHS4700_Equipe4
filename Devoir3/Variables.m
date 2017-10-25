classdef Variables
    properties (Constant)
        
        %voiture A
        ma = 1540;
        La = 4.78;
        la = 1.82;
        ha = 1.8;
        
        %voiture B
        mb = 1010;
        Lb = 4.23;
        lb = 1.6;
        hb = 1.8;
        
        aGrav = 9.81;
        
        coefficientRes = 0.8;
        
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