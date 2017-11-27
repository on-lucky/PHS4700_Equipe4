classdef Outils
    methods (Static)
        function genererGraphe(xToutesCouls, yToutesCouls, zToutesCouls, face)
            
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
            plot3(xMagenta, yMagenta, zMagenta, '.m');
            
            xlabel('x');
            ylabel('y');
            zlabel('z');
            title(strcat('Essai ', Variables.essai));
        end
    end
end