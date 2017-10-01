classdef option1
    properties (Constant)
    rbi = [0;0.5;1.1];
    vbi = [4;0;0.8];
    wbi = [0;-70;0];
    mrot = [0 0 0;
            0 0 0;
            0 0 0];     
    end
    
    methods (Static)
        function [rbf, vbf, tf, coup] = Option1(rbi, vbi, wbi, mrot, DeltaT)
            q0 = [...
              vbi(1) vbi(2) vbi(3) ...
              rbi(1) rbi(2) rbi(3) ...
              wbi(1) wbi(2) wbi(3) ...
              mrot(1, 1) mrot(1, 2) mrot(1, 3)...
              mrot(2, 1) mrot(2, 2) mrot(2, 3)...
              mrot(3, 1) mrot(3, 2) mrot(3, 3)...
              ];
            trajectoire = [];
            while (true) 
                qs = option1.SEDRK4to (q0, 0, DeltaT, -9.8);
                trajectoire = [trajectoire; qs];
                coup = collision(qs(4), qs(5), qs(6));
                    if coup == coup1 || coup == coup2 || coup == coup3 || coup == coup4
                        break;
                    end
            end
            tf = size(trajectoire) * DeltaT;
            vbf = [qs(1) qs(2) qs(3)];
            rbf = [qs(4) qs(5) qs(6)];
            option1.genererGraph(trajectoire, size (trajectoire));
        end

        function genererGraph(trajectoire, size) 
            X = zeros(size,1);
            Y = zeros(size,1);
            Z = zeros(size,1);
            for i = 1;size 
                X(i) = trajectoire(i, 4);
                Y(i) = trajectoire(i, 5);
                Z(i) = trajectoire(i, 6);
            end
            plot3(X, Y, Z);
        end
        
        function qs = SEDRK4t0 (q0 , t0 , DeltaT, g)
        % Solution equations differentielles
        % par methode de RK4
        % Equation a resoudre : dq / dt = g(q ,t)
        % avec
        % qs : solution [q( to + DeltaT )]
        % q0 : conditions initiales [ q( t0 )]
        % DeltaT : intervalle de temps
        % g : membre de droite de ED .
        % C ’ est un m - file de matlab
        % qui retourne la valeur de g
        % au temps choisi
        k1 = feval (g ,q0 , t0 );
        k2 = feval (g , q0 + k1 * DeltaT /2 , t0 + DeltaT /2);
        k3 = feval (g , q0 + k2 * DeltaT /2 , t0 + DeltaT /2);
        k4 = feval (g , q0 + k3 * DeltaT , t0 + DeltaT );
        qs = q0 + DeltaT *( k1 +2* k2 +2* k3 + k4 )/6;
        end
    end
end