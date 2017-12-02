classdef Outils
    methods (Static)
        function [xi, yi, zi, face] = simulation(nout, nin, poso)
            xi = [];
            yi = [];
            zi = [];
            face = [];
            pointPourGraphX = [];
            pointPourGraphY = [];
            pointPourGraphZ = [];
            
            nbRayonsRejetes = 0;
            
            rayons = Balayage.trouverRayons(poso);
            for i = 1:Variables.M
                for j = 1:Variables.N
                    orientation = [rayons(i, 3 * j - 2); rayons(i, 3 * j - 1); rayons(i, 3 * j)];
                    [point, normale, distanceRetournee, trouve] = Collision.collisionExterieure(poso, orientation);
                    if (trouve)
                        distance = distanceRetournee;

                        [rayonSortant, isReflexion] = Optique.trouverRayonSortant(orientation, normale, nout, nin);
                        if (~isReflexion)
                            nbCollisions = 0;
                            while nbCollisions < Variables.nMaxCollisions
                                nbCollisions = nbCollisions + 1;
                                [pointRetourne, normale, couleur, distanceRetournee] = Collision.collisionInterieure(point, rayonSortant);
                                if (couleur ~= Variables.notAlreadyCol)
                                    xi = [xi; pointRetourne(1)];
                                    yi = [yi; pointRetourne(2)];
                                    zi = [zi; pointRetourne(3)];
                                    face = [face; couleur];
                                    distance = distance + distanceRetournee;
                                    pointPourGraphX = [pointPourGraphX; distance*orientation(1)];
                                    pointPourGraphY = [pointPourGraphY; distance*orientation(2)];
                                    pointPourGraphZ = [pointPourGraphZ; distance*orientation(3)];
                                    break; % on break le while pcq on a frappé le cube
                                else
                                    [rayonSortant, isReflexion] = Optique.trouverRayonSortant(rayonSortant, normale, nout, nin);
                                    if (~isReflexion)
                                        break; % le rayon est mort
                                    end
                                end
                            end
                        end
                    else
                        nbRayonsRejetes = nbRayonsRejetes + 1;
                    end
                end
            end
            
            Outils.genererGraphe(pointPourGraphX, pointPourGraphY, pointPourGraphZ, face, poso);
        end
        
        function genererGraphe(xToutesCouls, yToutesCouls, zToutesCouls, face, poso)
            
            % dessiner le cylindre
            [X, Y, Z] = cylinder(Variables.Rcy);
            Z = Z * Variables.Hcy;
            surf(X + Variables.CMcy(1), Y + Variables.CMcy(2), Z + Variables.Hcyb, 'FaceColor', 'none');
            
            hold on
            
            % dessiner les points
            
            sizeVec = size(xToutesCouls);
            
            xRouge = [];
            yRouge = [];
            zRouge = [];
            
            xCyan = [];
            yCyan = [];
            zCyan = [];
            
            xVert = [];
            yVert = [];
            zVert = [];
            
            xJaune = [];
            yJaune = [];
            zJaune = [];
            
            xBleu = [];
            yBleu = [];
            zBleu = [];
            
            xMagenta = [];
            yMagenta = [];
            zMagenta = [];
            
            % séparer les points selon la couleur
            
            for i = 1:sizeVec
                if (face(i) == Variables.f1col)
                    xRouge = [xRouge; xToutesCouls(i)];
                    yRouge = [yRouge; yToutesCouls(i)];
                    zRouge = [zRouge; zToutesCouls(i)];
                elseif (face(i) == Variables.f2col)
                    xCyan = [xCyan; xToutesCouls(i)];
                    yCyan = [yCyan; yToutesCouls(i)];
                    zCyan = [zCyan; zToutesCouls(i)];
                elseif (face(i) == Variables.f3col)
                    xVert = [xVert; xToutesCouls(i)];
                    yVert = [yVert; yToutesCouls(i)];
                    zVert = [zVert; zToutesCouls(i)];
                elseif (face(i) == Variables.f4col)
                    xJaune = [xJaune; xToutesCouls(i)];
                    yJaune = [yJaune; yToutesCouls(i)];
                    zJaune = [zJaune; zToutesCouls(i)];
                elseif (face(i) == Variables.f5col)
                    xBleu = [xBleu; xToutesCouls(i)];
                    yBleu = [yBleu; yToutesCouls(i)];
                    zBleu = [zBleu; zToutesCouls(i)];
                elseif (face(i) == Variables.f6col)
                    xMagenta = [xMagenta; xToutesCouls(i)];
                    yMagenta = [yMagenta; yToutesCouls(i)];
                    zMagenta = [zMagenta; zToutesCouls(i)];
                end
            end
            
            % afficher les points
            
            plot3(xRouge, yRouge, zRouge, '.r'); hold on
            plot3(xCyan, yCyan, zCyan, '.c'); hold on
            plot3(xVert, yVert, zVert, '.g'); hold on
            plot3(xJaune, yJaune, zJaune, '.y'); hold on
            plot3(xBleu, yBleu, zBleu, '.b'); hold on
            plot3(xMagenta, yMagenta, zMagenta, '.m'); hold on
            
            % dessiner poso
            plot3(poso(1), poso(2), poso(3), '.'); 
            text(poso(1), poso(2), poso(3), 'poso');
            
            xlabel('x');
            ylabel('y');
            zlabel('z');
            
            strEssai = int2str(Variables.essai);
            title(strcat('Essai-', strEssai));
        end
    end
end