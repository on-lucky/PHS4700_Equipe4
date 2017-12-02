classdef Optique
    methods (Static)
        function [rayonSortant, isReflexion] = trouverRayonSortant(ui, i, ni, nt)
            %normale unitaire
            i = i/norm(i);
            
            %ui rayon entrant unitaire
            ui = ui/norm(ui);
            
            j = cross(ui, i);
            j = j/norm(j);
            
            k = cross(i, j);
            k = k/norm(k);
            
            sinTheta2 = ni/nt*dot(ui, k);
            
            
            if (abs(sinTheta2) < 1)
                rayonSortant = Optique.refraction(i, k, sinTheta2);
                isReflexion = false;
            else
                %C'est impossible que |sin(theta2)| = 1, puisque le
                %rayon entrant serait parallèle à la surface de collision
                rayonSortant = Optique.reflexion(ui, i);
                isReflexion = true;
            end
        end
        
        function ur = reflexion(ui, i)
            %ur rayon sortant réfléchi unitaire
            ur = ui - 2*i*(dot(ui, i));
            ur = ur/norm(ur);
        end
        
        function ut = refraction(i, k, sinThetaT)
            thetaT = asin(sinThetaT);
            
            %ut rayon sortant réfracté unitaire
            ut = - i * cos(thetaT) + k * sinThetaT;
            ut = ut/norm(ut);
        end
    end
end