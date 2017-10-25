classdef Outils
    methods (Static)
        function genererGraphe(trajectoire, size, option) 
            
            %dessiner la table
            ptsTable = [Variables.pointTable1; Variables.pointTable2; Variables.pointTable3; Variables.pointTable4; Variables.pointTable1];
            ligneTable = plot3(ptsTable(:,1), ptsTable(:,2), ptsTable(:,3))
            ligneTable.Color = 'blue';
            
            hold on
            
            %dessiner le filet
            ptsFilet = [Variables.pointFilet1; Variables.pointFilet2; Variables.pointFilet3; Variables.pointFilet4; Variables.pointFilet1];
            ligneFilet = plot3(ptsFilet(:,1), ptsFilet(:,2), ptsFilet(:,3))
            ligneFilet.Color = 'red';
            
            hold on
            
            X = zeros(size, 1);
            Y = zeros(size, 1);
            Z = zeros(size, 1);
            for i = 1:size
                X(i) = trajectoire(i, 1);
                Y(i) = trajectoire(i, 2);
                Z(i) = trajectoire(i, 3);
            end
            plot3(X, Y, Z); hold on
            text(X(size), Y(size), Z(size), strcat('Option ', num2str(option)));
            xlabel('x');
            ylabel('y');
            zlabel('z');
            title('Essai 1');
            % title('Essai 2');
            % title('Essai 3');
            % title('Essai 4');
        end
        
        function qs = SEDRK4t0(q0, DeltaT, option)
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
            gOpt = strcat('Outils.gOption', num2str(option));
			k1 = feval(gOpt, q0); % param t0 de la fonction gOpt n'est pas utilise, donc on l'a envele, mais sinon, on aurait mis t0 comme 3e param à feval
			k2 = feval(gOpt, q0 + k1 * DeltaT/2); % param t0 de la fonction gOpt n'est pas utilise, donc on l'a envele, mais sinon, on aurait mis t0 + DeltaT/2 comme 3e param à feval
			k3 = feval(gOpt, q0 + k2 * DeltaT/2); % param t0 de la fonction gOpt n'est pas utilise, donc on l'a envele, mais sinon, on aurait mis t0 + DeltaT/2 comme 3e param à feval
			k4 = feval(gOpt, q0 + k3 * DeltaT); % param t0 de la fonction gOpt n'est pas utilise, donc on l'a envele, mais sinon, on aurait mis t0 + DeltaT comme 3e param à feval
			qs = q0 + DeltaT * (k1 + 2 * k2 + 2 * k3 + k4)/6;
        end
        
        function g = gOption1(q0)
            % dvx(t)/dt = 0
            % dvy(t)/dt = 0
            % dvz(t)/dt = -9.81
			% acceleration angulaire = [0 0 0] car w constant
            g = [0 0 Variables.aGrav ...
			     q0(1) q0(2) q0(3) ...
			     0 0 0];
        end
        
        function g = gOption2(q0)
            % dv(t)/dt = (-p*Cv*A*|v|*v)/(2*mb) + [0 0 -9.81]
			% acceleration angulaire = [0 0 0] car w constant
            v = [q0(1) q0(2) q0(3)];
            acceleration = (-Variables.p) * Variables.Cv * Variables.A * norm(v) * v / (2 * Variables.mb) + [0 0 Variables.aGrav];
            g = [acceleration(1) acceleration(2) acceleration(3) ...
			     q0(1) q0(2) q0(3) ...
			     0 0 0];
        end
        
        function g = gOption3(q0)
            % dv(t)/dt = 4*pi*Cm*p*Rb^3*(w x v)/mb + (-p*Cv*A*|v|*v)/(2*mb) + [0 0 -9.81]
			% acceleration angulaire = [0 0 0] car w constant
            v = [q0(1) q0(2) q0(3)];
            w = [q0(7) q0(8) q0(9)];
            acceleration = 4 * pi * Variables.Cm * Variables.p * Variables.rb^3 * (cross(w, v))/Variables.mb ...
                           + (-Variables.p) * Variables.Cv * Variables.A * norm(v) * v / (2 * Variables.mb)...
                           + [0 0 Variables.aGrav];
            g = [acceleration(1) acceleration(2) acceleration(3) ...
			     q0(1) q0(2) q0(3) ...
			     0 0 0];
        end
    end
end