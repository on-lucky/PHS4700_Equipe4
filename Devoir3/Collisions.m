classdef Collisions
    properties
        a = 0;
        b = 0;
        voitureN = 0;
    end
    methods (Static)
        
        function estProche = verifierProximite(posa, posb)
            vecDist = posa - posb;
            distance = norm(vecDist);

            if(distance <= Variables.raExterne + Variables.rbExterne)
                estProche = Variables.collProximite;
            else
                estProche = Variables.collIndetermine;
            end
        end

        function estColle = verifierCollision(posa, posb)
        vecDist = posa - posb;
            distance = norm(vecDist);

            if(distance <= Variables.raInterne + Variables.rbInterne)
                estColle = Variables.collReussie;
            else
                estColle = Variables.collIndetermine;
            end
        end

        % cherche une collision avec la méthode du plan de division
        function [collision, normaleRet, p] = planDivision(posa, posb, angleRotA, angleRotB)
            [pointsA, pointsB] = Collisions.trouverCoins(posa, posb, angleRotA, angleRotB);

            % On assume qu'il y a une collision. Si on trouve un plan de division, on prouve qu'il n'y en a pas.
            coll = Variables.collReussie;
            
            normaleRet = [0 0];
            
            % teste les 4 plans de division de la voiture A
            for i = 1:4
                secondIndex = mod(i, 4) + 1;
                normale = Collisions.trouverNormale(pointsA(i,:), pointsA(secondIndex,:));
                if(~Collisions.collisionPlanDivision(normale, pointsA(i,:), pointsB))
                    coll = Variables.collIndetermine;
                    normaleRet = normale;
                    Collisions.voitureN = 1;
                    Collisions.a = (pointsA(secondIndex,2) - pointsA(i,2))/(pointsA(secondIndex,1) - pointsA(i,1));
                    Collisions.b = pointsA(i,2) - (Collisions.a * pointsA(i,1));
                    break;
                end
            end

            % teste les 4 plans de division de la voiture B
            for i = 1:4
                secondIndex = mod(i, 4) + 1;
                normale = Collisions.trouverNormale(pointsB(i,:), pointsB(secondIndex,:));
                if(~Collisions.collisionPlanDivision(normale, pointsB(i,:), pointsA))
                    coll = Variables.collIndetermine;
                    normaleRet = normale;
                    Collisions.voitureN = 2;
                    Collisions.a = (pointsB(secondIndex,2) - pointsB(i,2))/(pointsB(secondIndex,1) - pointsB(i,1));
                    Collisions.b = pointsB(i,2) - (Collisions.a * pointsB(i,1));
                    break;
                end
            end
            
            if(normaleRet(1) == 0 && normaleRet(2) == 0)
                if(Collisions.voitureN == 1)
                    p = trouverPtCollision(pointsB);
                else
                    p = trouverPtCollision(pointsA);
                end
            end  
            collision = coll;
        end
        
        function p = trouverPtCollision(points)
            distances = [0 0 0 0];
           for i = 1:4
                distances(i) = abs((a*pointsB(i,1) + b) - pointsB(i,2))
           end
           distance = 100;
           indexChoisi = 1;
           for i = 1:4
                if(distances(i) < distance)
                    distance = distances(i);
                    indexChoisi = i;
                end
           end
           p = pointsB(indexChoisi,:);
        end

        % Trouve toutes les positions des points des deux rectangles
        function [pointsA, pointsB] = trouverCoins(posa, posb, angleRotA, angleRotB)

            matriceRotationA = [cos(angleRotA) -sin(angleRotA); sin(angleRotA) cos(angleRotA)];
            matriceRotationB = [cos(angleRotB) -sin(angleRotB); sin(angleRotB) cos(angleRotB)];

            pointA1 = posa + matriceRotationA * [Variables.La/2; Variables.la/2];
            pointA2 = posa + matriceRotationA * [Variables.La/2; - Variables.la/2];
            pointA3 = posa + matriceRotationA * [- Variables.La/2; - Variables.la/2];
            pointA4 = posa + matriceRotationA * [- Variables.La/2; Variables.la/2];

            pointsA = [pointA1 pointA2 pointA3 pointA4];
            pointsA = pointsA.';

            pointB1 = posb + matriceRotationB * [Variables.Lb/2; Variables.lb/2];
            pointB2 = posb + matriceRotationB * [Variables.Lb/2; - Variables.lb/2];
            pointB3 = posb + matriceRotationB * [- Variables.Lb/2; - Variables.lb/2];
            pointB4 = posb + matriceRotationB * [- Variables.Lb/2; Variables.lb/2];

            pointsB = [pointB1 pointB2 pointB3 pointB4];
            pointsB = pointsB.';
        end

        %trouve la normale associé au plan formé par les points point1 et point2
        function normale = trouverNormale(point1, point2)
            arrete = point2 - point1;
            matriceRotation = [cos(pi/2) -sin(pi/2); sin(pi/2) cos(pi/2)];
            normale = matriceRotation * arrete.';
            normale = normale/norm(normale);
        end

        %Trouve toutes les distances entre les points pointsSolide et le plan de division
        function distances = calculerDistances(normale, pointPlan, pointsSolide)
            distances = [0 0 0 0];
            for i = 1:4
                distances(i) = normale.' * (pointsSolide(i,:) - pointPlan).';
            end
        end

        %Verifie si il y a un pt pointsSolide qui a une distance au plan de division d < 0
        function collision = collisionPlanDivision(normale, pointPlan, pointsSolide)
            collision = false;
            distances = Collisions.calculerDistances(normale, pointPlan, pointsSolide);
            for i = 1:4
                if(distances(i) <= 0)
                    collision = true;
                end
            end
        end
        function trouverPentePts(pt1, pt2)
            Collisions.a = (pt1(2) - pt2(2))/(pt1(1) - pt2(1));
            Collisions.b = pt1(2) - (Collisions.a * pt1(1));
        end
    end
end