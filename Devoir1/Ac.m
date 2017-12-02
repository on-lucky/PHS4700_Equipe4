classdef Ac    
    methods (Static)
        function ac = AccelerationAngulaire(Fz, w, I)
            mfNavette = Ac.MomentdeForce(Variables.posCylindreNavette, Fz(1));
            mfPropulseurGauche = Ac.MomentdeForce(Variables.posCylindrePropulseurGauche, Fz(2));
            mfPropulseurDroit = Ac.MomentdeForce(Variables.posCylindrePropulseurDroit, Fz(3));
			sommeMf = mfNavette + mfPropulseurGauche + mfPropulseurDroit;
            ac = inv(I) * (sommeMf + cross(I * w, w));
        end
        
        function mf = MomentdeForce(posForce, Fz)
			% La position en z n'est pas importante puisque le moment de force ne tient compte que de la 
			% distance perpendiculaire entre l’axe de rotation et la ligne d’action de la force
            r = [posForce(1) - CM.cmTotalLocal(1); posForce(2) - CM.cmTotalLocal(2); 0];
			F = [0; 0; Fz];
            mf = cross(r, F);
        end
    end
end