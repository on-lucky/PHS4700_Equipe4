classdef CM
    properties (Constant)
        cmCylindreNavette = CM.centreDeMasseCylindre(Variables.posCylindreNavette, Variables.h1n);
        cmConeNavette = CM.centreDeMasseCone(Variables.posConeNavette, Variables.h2n);
        cmCylindrePropulseurDroit = CM.centreDeMasseCylindre(Variables.posCylindrePropulseurDroit, Variables.h1p);
        cmConePropulseurDroit = CM.centreDeMasseCone(Variables.posConePropulseurDroit, Variables.h2p);
        cmCylindrePropulseurGauche = CM.centreDeMasseCylindre(Variables.posCylindrePropulseurGauche, Variables.h1p);
        cmConePropulseurGauche = CM.centreDeMasseCone(Variables.posConePropulseurGauche, Variables.h2p);
        cmCylindreReservoirBas = CM.centreDeMasseCylindre(Variables.posCylindreReservoirBas, Variables.hbasr);
        cmCylindreReservoirHaut = CM.centreDeMasseCylindre(Variables.posCylindreReservoirHaut, Variables.hhautr);
        cmConeReservoir = CM.centreDeMasseCone(Variables.posConeReservoir, Variables.h2r);

        pNavette = CM.masseVolumiqueConteneur(Variables.h1n, Variables.h2n, Variables.rn, Variables.mNavette);
        pPropulseur = CM.masseVolumiqueConteneur(Variables.h1p, Variables.h2p, Variables.rp, Variables.mPropulseur);
        pReservoirHaut = CM.masseVolumiqueConteneur(Variables.hhautr, Variables.h2r, Variables.rr, Variables.mReservoirHaut);

        mCylindreNavette = CM.masseCylindre(Variables.h1n, Variables.rn, CM.pNavette);
        mConeNavette = CM.masseCone(Variables.h2n, Variables.rn, CM.pNavette);
        mCylindrePropulseur = CM.masseCylindre(Variables.h1p, Variables.rp, CM.pPropulseur);
        mConePropulseur = CM.masseCone(Variables.h2p, Variables.rp, CM.pPropulseur);
        mCylindreReservoirBas = Variables.mReservoirBas;
        mCylindreReservoirHaut = CM.masseCylindre(Variables.hhautr, Variables.rr, CM.pReservoirHaut);
        mConeReservoir = CM.masseCone(Variables.h2r, Variables.rr, CM.pReservoirHaut);
        
        cmTotalLocal = CM.centreDeMasseNLLocal();
    end
    
    methods (Static)
		function cmGlobal = centreDeMasseGlobal(posNL, angRot)
			Rot = R.MatriceDeRotation(angRot);
			cmGlobal = posNL + Rot * CM.cmTotalLocal;
		end
		
        function cm = centreDeMasseNLLocal()
            mTotal = Variables.mNavette + Variables.mReservoirBas + Variables.mReservoirHaut + Variables.mPropulseur * 2;

            cm = (CM.cmCylindreNavette * CM.mCylindreNavette + CM.cmConeNavette * CM.mConeNavette + CM.cmCylindrePropulseurDroit * CM.mCylindrePropulseur ...
                    + CM.cmConePropulseurDroit * CM.mConePropulseur + CM.cmCylindrePropulseurGauche * CM.mCylindrePropulseur + CM.cmConePropulseurGauche * CM.mConePropulseur ...
                    + CM.cmCylindreReservoirBas * CM.mCylindreReservoirBas + CM.cmCylindreReservoirHaut * CM.mCylindreReservoirHaut + CM.cmConeReservoir * CM.mConeReservoir)/mTotal;
        end
        
        function rcm = centreDeMasseCylindre(pos, h)
            rcmx = pos(1);
            rcmy = pos(2);
            rcmz = pos(3) + h/2;

            rcm = [rcmx; rcmy; rcmz];
        end

        function rcm = centreDeMasseCone(pos, h)
            rcmx = pos(1);
            rcmy = pos(2);
            rcmz = pos(3) + h/4;

            rcm = [rcmx; rcmy; rcmz];
        end

        function p = masseVolumiqueConteneur(hCylindre, hCone, r, m)
            v = r^2 * pi * ((hCone / 3) + hCylindre);
            p = m / v;
        end

        function m = masseCylindre(h, r, mv)
            v = r^2 * pi * h;
            m = mv * v;
        end

        function m = masseCone(h, r, mv)
            v = r^2 * pi * h / 3;
            m = mv * v;
        end
    end
end

