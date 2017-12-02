classdef Collision
    methods (Static)
        function [point, normale, distance, trouve] = collisionExterieure(poso, orientation)
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
                trouve = true;
                directionXY = [orientation(1); orientation(2)];
                directionXY = directionXY / norm(directionXY);
                
                b0 = poso(2) - (directionXY(2) / directionXY(1)) * poso(1);
                c0 = Variables.CMcy(2) + (directionXY(1) / directionXY(2)) * Variables.CMcy(1); %%% ERREUR ICI C0 < 4 fonction balayage le probleme, une des deux directions est négative
                
                intersX = (c0 - b0) / (directionXY(2) / directionXY(1) + directionXY(1) / directionXY(2));
                intersY = directionXY(2) / directionXY(1) * intersX + b0;
                
                dIntersCercle = sqrt((intersX - Variables.CMcy(1))^2 + (intersY - Variables.CMcy(2))^2);
                
                if (dIntersCercle > Variables.Rcy)
                    erreur = 'collisionExterieure : probleme de distance plus grande que le rayon du cylindre';
                    trouve = false;
                end
                
                dPointInters = sqrt(Variables.Rcy^2 - dIntersCercle^2);
                
                pointIntersXMoins = -dPointInters * directionXY(1) + intersX;
                pointIntersYMoins = -dPointInters * directionXY(2) + intersY;
                
                pointIntersXPlus = dPointInters * directionXY(1) + intersX;
                pointIntersYPlus = dPointInters * directionXY(2) + intersY;
                
                if (norm([pointIntersXMoins, pointIntersYMoins] - [poso(1), poso(2)]) < norm([pointIntersXPlus, pointIntersYPlus] - [poso(1), poso(2)]))
                    pointIntersX = pointIntersXMoins;
                    pointIntersY = pointIntersYMoins;
                else
                    pointIntersX = pointIntersXPlus;
                    pointIntersY = pointIntersYPlus;
                end
                
                z = (orientation(3) / orientation(2)) * (pointIntersY - poso(2)) + poso(3);
                
                if (z < Variables.Hcyb || z > Variables.Hcyh)
                    erreur = 'collisionExterieure : probleme de z non situe sur le cylindre';
                    trouve = false;
                end
                
                point = [pointIntersX; pointIntersY; z];
                normale = point - [Variables.CMcy(1); Variables.CMcy(2); point(3)];
                normale = normale / norm(normale);
            end
            
            distance = norm(point - poso);
        end
        
        function [point, normale, couleur, distance] = collisionInterieure(pointCollisionAvant, orientation)
            trouve = false;
            distance = -1;
            normale = [0; 0; 0];
            
            % Vérifier une collision avec la face 1 du cube qui est dans le
            % plan yz de la gauche du cube
            y = orientation(2)*(Variables.plan1 - pointCollisionAvant(1))/orientation(1) + pointCollisionAvant(2);
            z = orientation(3)*(Variables.plan1 - pointCollisionAvant(1))/orientation(1) + pointCollisionAvant(3);
            if (y >= Variables.CMb(2) - Variables.yb / 2 && y <= Variables.CMb(2) + Variables.yb / 2 && z >= Variables.CMb(3) - Variables.zb / 2 && z <= Variables.CMb(3) + Variables.zb / 2)
                trouve = true;
                pointTemp = [Variables.plan1; y; z];
                distanceTemp = norm(pointTemp - pointCollisionAvant);
                if (distance == -1 || distanceTemp < distance)
                    point = pointTemp;
                    couleur = Variables.f1col;
                    distance = distanceTemp;
                end
            end
            
            % Vérifier une collision avec la face 2 du cube qui est dans le
            % plan yz de la droite du cube
            y = orientation(2)*(Variables.plan2 - pointCollisionAvant(1))/orientation(1) + pointCollisionAvant(2);
            z = orientation(3)*(Variables.plan2 - pointCollisionAvant(1))/orientation(1) + pointCollisionAvant(3);
            if (y >= Variables.CMb(2) - Variables.yb / 2 && y <= Variables.CMb(2) + Variables.yb / 2 && z >= Variables.CMb(3) - Variables.zb / 2 && z <= Variables.CMb(3) + Variables.zb / 2)
                trouve = true;
                pointTemp = [Variables.plan2; y; z];
                distanceTemp = norm(pointTemp - pointCollisionAvant);
                if (distance == -1 || distanceTemp < distance)
                    point = pointTemp;
                    couleur = Variables.f2col;
                    distance = distanceTemp;
                end
            end
            
            % Vérifier une collision avec la face 3 du cube qui est dans le
            % plan xz de la gauche du cube
            x = orientation(1)*(Variables.plan3 - pointCollisionAvant(2))/orientation(2) + pointCollisionAvant(1);
            z = orientation(3)*(Variables.plan3 - pointCollisionAvant(2))/orientation(2) + pointCollisionAvant(3);
            if (x >= Variables.CMb(1) - Variables.xb / 2 && x <= Variables.CMb(1) + Variables.xb / 2 && z >= Variables.CMb(3) - Variables.zb / 2 && z <= Variables.CMb(3) + Variables.zb / 2)
                trouve = true;
                pointTemp = [x; Variables.plan3; z];
                distanceTemp = norm(pointTemp - pointCollisionAvant);
                if (distance == -1 || distanceTemp < distance)
                    point = pointTemp;
                    couleur = Variables.f3col;
                    distance = distanceTemp;
                end
            end
            
            % Vérifier une collision avec la face 4 du cube qui est dans le
            % plan xz de la droite du cube
            x = orientation(1)*(Variables.plan4 - pointCollisionAvant(2))/orientation(2) + pointCollisionAvant(1);
            z = orientation(3)*(Variables.plan4 - pointCollisionAvant(2))/orientation(2) + pointCollisionAvant(3);
            if (x >= Variables.CMb(1) - Variables.xb / 2 && x <= Variables.CMb(1) + Variables.xb / 2 && z >= Variables.CMb(3) - Variables.zb / 2 && z <= Variables.CMb(3) + Variables.zb / 2)
                trouve = true;
                pointTemp = [x; Variables.plan4; z];
                distanceTemp = norm(pointTemp - pointCollisionAvant);
                if (distance == -1 || distanceTemp < distance)
                    point = pointTemp;
                    couleur = Variables.f4col;
                    distance = distanceTemp;
                end
            end
            
            % Vérifier une collision avec la face 5 du cube qui est dans le
            % plan xy du bas du cube
            x = orientation(1)*(Variables.plan5 - pointCollisionAvant(3))/orientation(3) + pointCollisionAvant(1);
            y = orientation(2)*(Variables.plan5 - pointCollisionAvant(3))/orientation(3) + pointCollisionAvant(2);
            if (x >= Variables.CMb(1) - Variables.xb / 2 && x <= Variables.CMb(1) + Variables.xb / 2 && y >= Variables.CMb(2) - Variables.yb / 2 && y <= Variables.CMb(2) + Variables.yb / 2)
                trouve = true;
                pointTemp = [x; y; Variables.plan5];
                distanceTemp = norm(pointTemp - pointCollisionAvant);
                if (distance == -1 || distanceTemp < distance)
                    point = pointTemp;
                    couleur = Variables.f5col;
                    distance = distanceTemp;
                end
            end
            
            % Vérifier une collision avec la face 6 du cube qui est dans le
            % plan xy du haut du cube
            x = orientation(1)*(Variables.plan6 - pointCollisionAvant(3))/orientation(3) + pointCollisionAvant(1);
            y = orientation(2)*(Variables.plan6 - pointCollisionAvant(3))/orientation(3) + pointCollisionAvant(2);
            if (x >= Variables.CMb(1) - Variables.xb / 2 && x <= Variables.CMb(1) + Variables.xb / 2 && y >= Variables.CMb(2) - Variables.yb / 2 && y <= Variables.CMb(2) + Variables.yb / 2)
                trouve = true;
                pointTemp = [x; y; Variables.plan6];
                distanceTemp = norm(pointTemp - pointCollisionAvant);
                if (distance == -1 || distanceTemp < distance)
                    point = pointTemp;
                    couleur = Variables.f6col;
                end
            end
            
            % Vérifier une collision avec la base du cylindre
            if (~trouve && pointCollisionAvant(3) ~= Variables.Hcyb)
                x = orientation(1)*(Variables.Hcyb - pointCollisionAvant(3))/orientation(3) + pointCollisionAvant(1);
                y = orientation(2)*(Variables.Hcyb - pointCollisionAvant(3))/orientation(3) + pointCollisionAvant(2);
                r = sqrt((x - Variables.CMcy(1))^2 + (y - Variables.CMcy(2))^2);
                if (r <= Variables.Rcy)
                    point = [x; y; Variables.Hcyb];
                    normale = [0; 0; 1];
                    trouve = true;
                    couleur = Variables.notAlreadyCol;
                end
            end
            
            % Vérifier une collision avec le haut du cylindre
            if (~trouve && pointCollisionAvant(3) ~= Variables.Hcyh)
                x = orientation(1)*(Variables.Hcyh - pointCollisionAvant(3))/orientation(3) + pointCollisionAvant(1);
                y = orientation(2)*(Variables.Hcyh - pointCollisionAvant(3))/orientation(3) + pointCollisionAvant(2);
                r = sqrt((x - Variables.CMcy(1))^2 + (y - Variables.CMcy(2))^2);
                if (r <= Variables.Rcy)
                    point = [x; y; Variables.Hcyh];
                    normale = [0; 0; -1];
                    trouve = true;
                    couleur = Variables.notAlreadyCol;
                end
            end
            
            % Vérifier une collision avec le plan courbe du cylindre
            if (~trouve)
                directionXY = [orientation(1); orientation(2)];
                directionXY = directionXY / norm(directionXY);
                
                b0 = pointCollisionAvant(2) - (directionXY(2) / directionXY(1)) * pointCollisionAvant(1);
                c0 = Variables.CMcy(2) + (directionXY(1) / directionXY(2)) * Variables.CMcy(1);
                
                intersX = (c0 - b0) / (directionXY(2) / directionXY(1) + directionXY(1) / directionXY(2));
                intersY = directionXY(2) / directionXY(1) * intersX + b0;
                
                dIntersCercle = sqrt((intersX - Variables.CMcy(1))^2 + (intersY - Variables.CMcy(2))^2);
                
                if (dIntersCercle > Variables.Rcy)
                    erreur = 'collisionInterieure : probleme de distance plus grande que le rayon du cylindre';
                end
                
                dPointInters = sqrt(Variables.Rcy^2 - dIntersCercle^2);
                
                pointIntersXMoins = -dPointInters * directionXY(1) + intersX;
                pointIntersYMoins = -dPointInters * directionXY(2) + intersY;
                
                pointIntersXPlus = dPointInters * directionXY(1) + intersX;
                pointIntersYPlus = dPointInters * directionXY(2) + intersY;
                
                %on part de la base ou du haut du cylindre
                if(pointCollisionAvant(3) == Variables.Hcyb || pointCollisionAvant(3) == Variables.Hcyh)
                    z = orientation(3) * pointIntersXPlus / orientation(2) - orientation(3) * pointCollisionAvant(2) / orientation(2) + pointCollisionAvant(3);
                    if (z > Variables.Hcyb && z < Variables.Hcyh)
                        pointIntersX = pointIntersXPlus;
                        pointIntersY = pointIntersYPlus;
                    else
                        pointIntersX = pointIntersXMoins;
                        pointIntersY = pointIntersYMoins;
                    end
                    
                %on part de la face courbe du cylindre    
                elseif (norm([pointIntersXMoins, pointIntersYMoins] - [pointCollisionAvant(1), pointCollisionAvant(2)]) > norm([pointIntersXPlus, pointIntersYPlus] - [pointCollisionAvant(1), pointCollisionAvant(2)]))
                    pointIntersX = pointIntersXMoins;
                    pointIntersY = pointIntersYMoins;
                else
                    pointIntersX = pointIntersXPlus;
                    pointIntersY = pointIntersYPlus;
                end
                
                z = orientation(3) * pointIntersX / orientation(2) - orientation(3) * pointCollisionAvant(2) / orientation(2) + pointCollisionAvant(3);
                
                if (z < Variables.Hcyb || z > Variables.Hcyh)
                    erreur = 'collisionInterieure : probleme de z non situe sur le cylindre';
                end
                
                point = [pointIntersX; pointIntersY; z];
                normale = point - Variables.CMcy;
                normale = normale / norm(normale);
                couleur = Variables.notAlreadyCol;
            end
            
            distance = norm(point - pointCollisionAvant);
        end
    end
end

% function [point, couleur, distance] = verifierFaceCube()
%  x = orientation(1)*(Variables.plan6 - pointCollisionAvant(3))/orientation(3) + pointCollisionAvant(1);
%             y = orientation(2)*(Variables.plan6 - pointCollisionAvant(3))/orientation(3) + pointCollisionAvant(2);
%             if (x >= Variables.CMb(1) - Variables.xb / 2 && x <= Variables.CMb(1) + Variables.xb / 2 && y >= Variables.CMb(2) - Variables.yb / 2 && y <= Variables.CMb(2) + Variables.yb / 2)
%                 trouve = true;
%                 pointTemp = [x; y; Variables.plan6];
%                 distanceTemp = norm(pointTemp - pointCollisionAvant);
%                 if (distance == -1 || distanceTemp < distance)
%                     point = pointTemp;
%                     couleur = Variables.f6col;
%                 end
%             end
% end