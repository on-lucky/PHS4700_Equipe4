classdef Simulation
    properties (Constant)
        mrot = [1 0 0;
                0 1 0;
                0 0 1];     
    end
    
    methods (Static)
        function [rbf, vbf, tf, coup] = simulation(rbi, vbi, wbi, DeltaT, gOpt)
            q0 = [vbi(1) vbi(2) vbi(3) ...
				  rbi(1) rbi(2) rbi(3) ...
				  wbi(1) wbi(2) wbi(3) ...
				  Option1.mrot(1, 1) Option1.mrot(1, 2) Option1.mrot(1, 3) ...
				  Option1.mrot(2, 1) Option1.mrot(2, 2) Option1.mrot(2, 3) ...
				  Option1.mrot(3, 1) Option1.mrot(3, 2) Option1.mrot(3, 3)];
            trajectoire = [];
			coup = Variables.coupIntdetermine;
            while (coup == Variables.coupIntdetermine) 
                qs = Outils.SEDRK4t0(q0, 0, DeltaT, gOpt);
                trajectoire = [trajectoire; qs(4) qs(5) qs(6)];
                coup = Collisions.collision(qs(4), qs(5), qs(6), rbi(1));
            end
            tf = size(trajectoire) * DeltaT;
            vbf = [qs(1) qs(2) qs(3)];
            rbf = [qs(4) qs(5) qs(6)];
            Outils.genererGraph(trajectoire, size(trajectoire));
        end
    end
end