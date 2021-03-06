classdef Camera
    methods (Static)
        function [distanceMoins, distancePlus] = trouverDistancesTheta (distance, hauteurMoinsTheta, hauteurPlusTheta)
            if (hauteurMoinsTheta < 0)
                distanceMoins = distance + Variables.Rcy;
                distancePlus = distance - Variables.Rcy;
            elseif(hauteurPlusTheta > 0)
                distanceMoins = distance - Variables.Rcy;
                distancePlus = distance + Variables.Rcy;
            else 
                distanceMoins = distance - Variables.Rcy;
                distancePlus = distance - Variables.Rcy;
            end
        end

        function [hauteurMoinsTheta, hauteurPlusTheta] = trouverHauteurTheta (robs)
            hauteurMoinsTheta = Variables.Hcyh - robs(3);
            hauteurPlusTheta = Variables.Hcyb - robs(3);  
        end

        function distance = trouverDistancesPhi(robs)
            distance= sqrt((Variables.CMcy(1)- robs(1))^2 + (Variables.CMcy(2)-robs(2))^2);
        end

        function [hauteurMoins, hauteurPlus] = trouverHauteurPhi ()
            hauteurMoins = Variables.Rcy;
            hauteurPlus = -Variables.Rcy;
        end

        function [angleMoins, anglePlus] = calculerAnglesTheta(distanceMoins, distancePlus, hauteurMoins, hauteurPlus)
            if(hauteurMoins > 0)
                angleMoins = atan(distanceMoins / hauteurMoins);
            else
                angleMoins = (pi / 2) + atan(abs(hauteurMoins) / distanceMoins);
            end
            if(hauteurPlus < 0)
                 anglePlus = (pi / 2) + atan(abs(hauteurPlus) / distancePlus);
            else
                anglePlus = atan( distancePlus / hauteurPlus);
            end
        end
        
        function [angleMoins, anglePlus] = calculerAnglesPhi(distance, hauteurMoins, hauteurPlus, robs)
            phiMoins = asin(hauteurMoins / distance);
            phiPlus = asin(hauteurPlus / distance);
            angleInit = atan((robs(2)- Variables.CMcy(2)) / (robs(1)- Variables.CMcy(1)));
            angleMoins = phiMoins + angleInit;
            anglePlus = phiPlus + angleInit;
        end

        function [thetaMoins, thetaPlus, phiMoins, phiPlus] = trouverAngles (robs)
            [hauteurMoinsTheta, hauteurPlusTheta] = Camera.trouverHauteurTheta(robs);
            [hauteurMoinsPhi, hauteurPlusPhi] = Camera.trouverHauteurPhi ();

            distance = Camera.trouverDistancesPhi(robs);
            [distanceMoins, distancePlus] = Camera.trouverDistancesTheta(distance, hauteurMoinsTheta, hauteurPlusTheta);

            [thetaMoins, thetaPlus] = Camera.calculerAnglesTheta(distanceMoins, distancePlus, hauteurMoinsTheta, hauteurPlusTheta);
            [phiMoins, phiPlus] = Camera.calculerAnglesPhi(distance, hauteurMoinsPhi, hauteurPlusPhi, robs);
        end
    end
end