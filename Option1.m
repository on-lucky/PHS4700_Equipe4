classdef Option1
    properties (Constant)
        mrot = [0 0 0;
                0 0 0;
                0 0 0];     
    end
    
    methods (Static)
        function [rbf, vbf, tf, coup] = option1(rbi, vbi, wbi, DeltaT)
            q0 = [vbi(1) vbi(2) vbi(3) ...
				  rbi(1) rbi(2) rbi(3) ...
				  wbi(1) wbi(2) wbi(3) ...
				  Option1.mrot(1, 1) Option1.mrot(1, 2) Option1.mrot(1, 3) ...
				  Option1.mrot(2, 1) Option1.mrot(2, 2) Option1.mrot(2, 3) ...
				  Option1.mrot(3, 1) Option1.mrot(3, 2) Option1.mrot(3, 3)];
            trajectoire = [];
			coup = Variables.coupIntdetermine;
            while (coup == Variables.coupIntdetermine) 
                qs = Option1.SEDRK4t0(q0, 0, DeltaT);
                trajectoire = [trajectoire; qs(4) qs(5) qs(6)];
                coup = Collisions.collision(qs(4), qs(5), qs(6), rbi(1));
            end
            tf = size(trajectoire) * DeltaT;
            vbf = [qs(1) qs(2) qs(3)];
            rbf = [qs(4) qs(5) qs(6)];
            Option1.genererGraph(trajectoire, size(trajectoire));
        end

        function genererGraph(trajectoire, size) 
            X = zeros(size, 1);
            Y = zeros(size, 1);
            Z = zeros(size, 1);
            for i = 1:size
                X(i) = trajectoire(i, 1);
                Y(i) = trajectoire(i, 2);
                Z(i) = trajectoire(i, 3);
            end
            plot3(X, Y, Z);
        end
        
        function res = g(q0, t0)
            % dvx(t)/dt = 0
            % dvy(t)/dt = 0
            % dvz(t)/dt = -9.81
			% acceleration angulaire = [0 0 0] car w constant
            res = [0 0 Variables.aGrav
				   q0(1) q0(2) q0(3)
				   0 0 0
				   (q0(8) * q0(16) - q0(9) * q0(13))
				   (q0(8) * q0(17) - q0(9) * q0(14))
				   (q0(8) * q0(18) - q0(9) * q0(15))
				   (q0(9) * q0(10) - q0(7) * q0(16))
				   (q0(9) * q0(11) - q0(7) * q0(17))
				   (q0(9) * q0(12) - q0(7) * q0(18))
				   (q0(7) * q0(13) - q0(7) * q0(10))
				   (q0(7) * q0(14) - q0(8) * q0(11))
				   (q0(7) * q0(15) - q0(8) * q0(12))];
        end
        
        function qs = SEDRK4t0(q0, t0, DeltaT)
			% Solution d'equations differentielles
			% par methode de RK4
			% Equation a resoudre : dq/dt = g(q ,t)
			% avec
			% qs : solution [q(t0 + DeltaT)]
			% q0 : conditions initiales [q(t0)]
			% DeltaT : intervalle de temps
			% g : membre de droite de ED.
			% C'est un m-file de matlab
			% qui retourne la valeur de g
			% au temps choisi
			k1 = feval(Option1.g, q0, t0);
			k2 = feval(Option1.g, q0 + k1 * DeltaT/2, t0 + DeltaT/2);
			k3 = feval(Option1.g, q0 + k2 * DeltaT/2, t0 + DeltaT/2);
			k4 = feval(Option1.g, q0 + k3 * DeltaT, t0 + DeltaT);
			qs = q0 + DeltaT * (k1 + 2 * k2 + 2 * k3 + k4)/6;
        end
    end
end