classdef Collision
    methods (Static)
        function [point, normale] = collision(poso, orientation)
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
            end
        end
    end
end