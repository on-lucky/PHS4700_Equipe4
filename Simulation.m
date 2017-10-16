classdef Simulation    
    methods (Static)
        function [rbf, vbf, tf, coup] = simulation(rbi, vbi, wbi, DeltaT, option, avecGraphe)
            q0 = [vbi(1) vbi(2) vbi(3) ...
				  rbi(1) rbi(2) rbi(3) ...
				  wbi(1) wbi(2) wbi(3)];
            trajectoire = [];
			coup = Variables.coupIntdetermine;
            t0 = -DeltaT;
            while (coup == Variables.coupIntdetermine) 
                t0 = t0 + DeltaT;
                q0 = Outils.SEDRK4t0(q0, DeltaT, option);
                trajectoire = [trajectoire; q0(4) q0(5) q0(6)];
                coup = Collisions.collision(q0(4), q0(5), q0(6), rbi(1));   
            end
            tf = t0;
            vbf = [q0(1) q0(2) q0(3)];
            rbf = [q0(4) q0(5) q0(6)];
            sizeTrajectoire = size(trajectoire);
            if(avecGraphe)
                Outils.genererGraphe(trajectoire, sizeTrajectoire(1), option);
            end
        end
    end
end