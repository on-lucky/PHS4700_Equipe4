classdef Collision
    methods (Static)
        function [point, normale] = collisionExterieure(poso, orientation)
            trouve = false;
            
            if (poso(3) < Variables.Hcyb)
                x = orientation(1)*(Variables.Hcyb - poso(3))/orientation(3) + poso(1);
                y = orientation(2)*(Variables.Hcyb - poso(3))/orientation(3) + poso(2);
                r = sqrt((x - Variables.CMcy(1))^2 + (y - Variables.CMcy(2))^2);
                if (r <= Variables.Rcy)
                    point = [x; y; Variables.Hcyb];
                    normale = [0; 0; -1];
                    trouve = true;
                end
            end
            
            if (poso(3) > Variables.Hcyh)
                x = orientation(1)*(Variables.Hcyh - poso(3))/orientation(3) + poso(1);
                y = orientation(2)*(Variables.Hcyh - poso(3))/orientation(3) + poso(2);
                r = sqrt((x - Variables.CMcy(1))^2 + (y - Variables.CMcy(2))^2);
                if (r <= Variables.Rcy)
                    point = [x; y; Variables.Hcyh];
                    normale = [0; 0; 1];
                    trouve = true;
                end
            end
            
            if (~trouve)
                directionXY = [orientation(1); orientation(2)];
                directionXY = directionXY / norm(directionXY);
                
                b0 = poso(2) - (directionXY(2) / directionXY(1)) * poso(1);
                c0 = Variables.CMcy(2) + (directionXY(1) / directionXY(2)) * Variables.CMcy(1);
                
                intersX = (c0 - b0) / (directionXY(2) / directionXY(1) + directionXY(1) / directionXY(2));
                intersY = directionXY(2) / directionXY(1) * intersX + b0;
                
                dIntersCercle = sqrt((intersX - Variables.CMcy(1))^2 + (intersY - Variables.CMcy(2))^2);
                
                if (dIntersCercle > Variables.Rcy)
                    erreur = 'probleme de distance plus grande que le rayon du cylindre'
                end
                
                dPointInters = sqrt(Variables.Rcy^2 - dIntersCercle^2);
                
                pointIntersX = -dPointInters * directionXY(1) + intersX;
                pointIntersY = -dPointInters * directionXY(2) + intersY;
                
                z = orientation(3) * pointIntersX / orientation(2) - orientation(3) * poso(2) / orientation(2) + poso(3);
                
                if (z < Variables.Hcyb || z > Variables.Hcyh)
                    erreur = 'probleme de z non situe sur le cylindre'
                end
                
                point = [pointIntersX; pointIntersY; z];
                normale = point - Variables.CMcy;
                normale = normale / norm(normale);
            end
        end
        
        function [point, normale] = collisionInterieure(pointCollision, orientation)
            trouve = false;
            
            % Rendu ici
            
            if (pointCollision(3) < Variables.Hcyb)
                x = orientation(1)*(Variables.Hcyb - pointCollision(3))/orientation(3) + pointCollision(1);
                y = orientation(2)*(Variables.Hcyb - pointCollision(3))/orientation(3) + pointCollision(2);
                r = sqrt((x - Variables.CMcy(1))^2 + (y - Variables.CMcy(2))^2);
                if (r <= Variables.Rcy)
                    point = [x; y; Variables.Hcyb];
                    normale = [0; 0; -1];
                    trouve = true;
                end
            end
            
            if (pointCollision(3) > Variables.Hcyh)
                x = orientation(1)*(Variables.Hcyh - pointCollision(3))/orientation(3) + pointCollision(1);
                y = orientation(2)*(Variables.Hcyh - pointCollision(3))/orientation(3) + pointCollision(2);
                r = sqrt((x - Variables.CMcy(1))^2 + (y - Variables.CMcy(2))^2);
                if (r <= Variables.Rcy)
                    point = [x; y; Variables.Hcyh];
                    normale = [0; 0; 1];
                    trouve = true;
                end
            end
            
            if (~trouve)
                directionXY = [orientation(1); orientation(2)];
                directionXY = directionXY / norm(directionXY);
                
                b0 = pointCollision(2) - (directionXY(2) / directionXY(1)) * pointCollision(1);
                c0 = Variables.CMcy(2) + (directionXY(1) / directionXY(2)) * Variables.CMcy(1);
                
                intersX = (c0 - b0) / (directionXY(2) / directionXY(1) + directionXY(1) / directionXY(2));
                intersY = directionXY(2) / directionXY(1) * intersX + b0;
                
                dIntersCercle = sqrt((intersX - Variables.CMcy(1))^2 + (intersY - Variables.CMcy(2))^2);
                
                if (dIntersCercle > Variables.Rcy)
                    erreur = 'probleme de distance plus grande que le rayon du cylindre'
                end
                
                dPointInters = sqrt(Variables.Rcy^2 - dIntersCercle^2);
                
                pointIntersX = -dPointInters * directionXY(1) + intersX;
                pointIntersY = -dPointInters * directionXY(2) + intersY;
                
                z = orientation(3) * pointIntersX / orientation(2) - orientation(3) * pointCollision(2) / orientation(2) + pointCollision(3);
                
                if (z < Variables.Hcyb || z > Variables.Hcyh)
                    erreur = 'probleme de z non situe sur le cylindre'
                end
                
                point = [pointIntersX; pointIntersY; z];
                normale = point - Variables.CMcy;
                normale = normale / norm(normale);
            end
        end
    end
end