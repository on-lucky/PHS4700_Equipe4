classdef Outils
    methods (Static)
        function [Coll, tf, raf, vaf, rbf, vbf] = avantCollision(rai, vai, rbi, vbi, tb)
            q0a = [vai(1) vai(2) ...
				  rai(1) rai(2)];
            q0b = [vbi(1) vbi(2) ...
				  rbi(1) rbi(2)];
            trajectoirea = [];
            trajectoireb = [];
            DeltaT  = Variables.erreur / Outils.vitessePlusVite([vai(1) vai(2)], [vbi(1) vbi(2)]);
            t0 = 0;
            coll = Variables.collIndetermine;
            while (coll == Variables.collIndetermine)
                t0 = t0 + DeltaT;
                q0a = Outils.SEDRK4t0(q0a, DeltaT, Variables.avecFrot);
                if (t0 >= tb)
                    q0b = Outils.SEDRK4t0(q0b, DeltaT, Variables.avecFrot);
                else
                    q0b = Outils.SEDRK4t0(q0b, DeltaT, ~Variables.avecFrot);
                end
                trajectoirea = [trajectoirea; q0a(3) q0a(4)];
                trajectoireb = [trajectoireb; q0b(3) q0b(4)];
                
                %coll = Collision.verifierProximite([q0a(3) q0a(4)], [q0b(3) q0b(4)]);
                
                vitessePlusVite = Outils.vitessePlusVite([q0a(1) q0a(2)], [q0b(1) q0b(2)]);
                if (vitessePlusVite < Variables.vitesseMinimaleSimulation)
                    coll = Variables.collRatee;
                end
                
                DeltaT  = Variables.erreur / vitessePlusVite;
            end
            tf = t0;
            Coll = coll;
            vaf = [q0a(1) q0a(2) vai(3)];
            raf = [q0a(3) q0a(4)];
            vbf = [q0b(1) q0b(2) vbi(3)];
            rbf = [q0b(3) q0b(4)];
            sizeTrajectoire = size(trajectoirea);
            Outils.genererGraphe(trajectoirea, trajectoireb, sizeTrajectoire(1));
        end
        
        function v = vitessePlusVite(va, vb)
            if (norm(va) < norm(vb))
                v = norm(vb);
            else
                v = norm(va);
            end
        end
        
        function qs = SEDRK4t0(q0, DeltaT, avecFrot)
			% Solution d'equations differentielles
			% par methode de RK4
			% Equation a resoudre : dq/dt = g(q ,t)
			% avec
			% qs : solution [q(t0 + DeltaT)]
			% q0 : conditions initiales [q(t0)]
			% DeltaT : intervalle de temps
            if (avecFrot)
                gOpt = 'Outils.gAvecFrot';
            else
                gOpt = 'Outils.gSansFrot';
            end
            
			k1 = feval(gOpt, q0); % param t0 de la fonction gOpt n'est pas utilise, donc on l'a envele, mais sinon, on aurait mis t0 comme 3e param à feval
			k2 = feval(gOpt, q0 + k1 * DeltaT/2); % param t0 de la fonction gOpt n'est pas utilise, donc on l'a envele, mais sinon, on aurait mis t0 + DeltaT/2 comme 3e param à feval
			k3 = feval(gOpt, q0 + k2 * DeltaT/2); % param t0 de la fonction gOpt n'est pas utilise, donc on l'a envele, mais sinon, on aurait mis t0 + DeltaT/2 comme 3e param à feval
			k4 = feval(gOpt, q0 + k3 * DeltaT); % param t0 de la fonction gOpt n'est pas utilise, donc on l'a envele, mais sinon, on aurait mis t0 + DeltaT comme 3e param à feval
			qs = q0 + DeltaT * (k1 + 2 * k2 + 2 * k3 + k4)/6;
        end
        
        function g = gAvecFrot(q0)
            % dv(t)/dt = -u(v) * g * v/|v|
            
            v = [q0(1) q0(2)];
            acceleration = - Variables.coefficientFrot(v) * Variables.aGrav * v / norm(v);
            
            g = [acceleration(1) acceleration(2) ...
			     q0(1) q0(2)];
        end
        
        function g = gSansFrot(q0)
            % dv(t)/dt = [0 0] car vitesse constante vu qu'il n'y a pas de
            % force appliquée sur la voiture
            
            g = [0 0 ...
			     q0(1) q0(2)];
        end
        
        function genererGraphe(trajectoirea, trajectoireb, size) 
            
            %dessiner la table
%             ptsTable = [Variables.pointTable1; Variables.pointTable2; Variables.pointTable3; Variables.pointTable4; Variables.pointTable1];
%             ligneTable = plot3(ptsTable(:,1), ptsTable(:,2), ptsTable(:,3))
%             ligneTable.Color = 'blue';
%             
%             hold on
            
            X = zeros(size, 1);
            Y = zeros(size, 1);
            for i = 1:size
                X(i) = trajectoirea(i, 1);
                Y(i) = trajectoirea(i, 2);
            end
            plot(X, Y);
            text(X(size), Y(size), 'Voiture a');
            
            hold on
            
            X = zeros(size, 1);
            Y = zeros(size, 1);
            for i = 1:size
                X(i) = trajectoireb(i, 1);
                Y(i) = trajectoireb(i, 2);
            end
            plot(X, Y);
            text(X(size), Y(size), 'Voiture b');
            
            xlabel('x');
            ylabel('y');
            title('Essai 1');
            % title('Essai 2');
            % title('Essai 3');
            % title('Essai 4');
            % title('Essai 5');
            % title('Essai 6');
        end
    end
end