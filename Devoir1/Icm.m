classdef Icm
    properties (Constant)
        icmTotalLocal = Icm.momentInertieLocal();
    end
    
    methods (Static)
		function icmGlobal = momentInertieGlobal(angRot)
			Rot = R.MatriceDeRotation(angRot);
			icmGlobal = Rot * Icm.icmTotalLocal * inv(Rot);
		end
		
        function icmTotalLocal = momentInertieLocal()
            iCylindreNavette = Icm.momentInertieCylindre(CM.mCylindreNavette, Variables.rn, Variables.h1n);
            iConeNavette = Icm.momentInertieCone(CM.mConeNavette, Variables.rn, Variables.h2n);
            iCylindrePropulseur = Icm.momentInertieCylindre(CM.mCylindrePropulseur, Variables.rp, Variables.h1p);
            iConePropulseur = Icm.momentInertieCone(CM.mConePropulseur, Variables.rp, Variables.h2p);
            iCylindreReservoirBas = Icm.momentInertieCylindre(CM.mCylindreReservoirBas, Variables.rr, Variables.hbasr);
            iCylindreReservoirHaut = Icm.momentInertieCylindre(CM.mCylindreReservoirHaut, Variables.rr, Variables.hhautr);
            iConeReservoir = Icm.momentInertieCone(CM.mConeReservoir, Variables.rr, Variables.h2r);

            iCylindreNavetteNL = Icm.Huygens(CM.cmCylindreNavette, CM.mCylindreNavette, iCylindreNavette);
            iConeNavetteNL = Icm.Huygens(CM.cmConeNavette, CM.mConeNavette, iConeNavette);
            iCylindrePropulseurDroitNL = Icm.Huygens(CM.cmCylindrePropulseurDroit, CM.mCylindrePropulseur, iCylindrePropulseur);
            iConePropulseurDroitNL = Icm.Huygens(CM.cmConePropulseurDroit, CM.mConePropulseur, iConePropulseur);
            iCylindrePropulseurGaucheNL = Icm.Huygens(CM.cmCylindrePropulseurGauche, CM.mCylindrePropulseur, iCylindrePropulseur);
            iConePropulseurGaucheNL = Icm.Huygens(CM.cmConePropulseurGauche, CM.mConePropulseur, iConePropulseur);
            iCylindreReservoirBasNL = Icm.Huygens(CM.cmCylindreReservoirBas, CM.mCylindreReservoirBas, iCylindreReservoirBas);
            iCylindreReservoirHautNL = Icm.Huygens(CM.cmCylindreReservoirHaut, CM.mCylindreReservoirHaut, iCylindreReservoirHaut);
            iConeReservoirNL = Icm.Huygens(CM.cmConeReservoir, CM.mConeReservoir, iConeReservoir);

            icmTotalLocal = iCylindreNavetteNL + iConeNavetteNL + iCylindrePropulseurDroitNL + iConePropulseurDroitNL + iCylindrePropulseurGaucheNL ...
                     + iConePropulseurGaucheNL + iCylindreReservoirBasNL + iCylindreReservoirHautNL + iConeReservoirNL;             
        end

        function micy = momentInertieCylindre(m, r, h)
            ixy = (m / 12) * ((3 * (r^2)) + (h^2));
            iz = (m * (r^2)) / 2 ;
            micy = [ixy 0 0;
                    0 ixy 0;
                    0 0 iz];
        end

        function mico = momentInertieCone(m, r, h)
            ixy = (m / 80) * ((12 * (r^2)) + (3 * (h^2)));
            iz = (m * 3 *(r^2)) / 10 ;
            mico = [ixy 0 0;
                    0 ixy 0;
                    0 0 iz];
        end

        function miS = Huygens(cmS, m, I)
            d = CM.cmTotalLocal - cmS;
            HI = [(d(2)^2 + d(3)^2) (-d(2) * d(1)) (-d(1) * d(3));
                (-d(2) * d(1)) (d(1)^2 + d(3)^2) (-d(2) * d(3));
                (-d(3) * d(1)) (-d(3) * d(2)) (d(1)^2 + d(2)^2)];
            miS = I + m * HI;
        end
    end
end



