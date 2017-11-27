classdef Balayage
    methods(Static)
        function rayons = trouverRayons(robs)
            
            [thetaMoins, thetaPlus, phiMoins, phiPlus] = Camera.trouverAngles(robs);
            
            [thetas, phis] = trouverAngles(thetaMoins, thetaPlus, phiMoins, phiPlus);
            
            rayons = zeros(Variables.N, Variables.M);
            for(n = 1:Variables.N)
                for(m = 1:Variables.M)
                    rayons(n,m) = [ (sin(thetas(n)) * cos(phis(m))), (sin(thetas(n)) * sin(phis(m))), (cos(thetas(n)))];
                end
            end
        end
        
         function [thetas, phis] = trouverAngles(thetaMoins, thetaPlus, phiMoins, phiPlus)
            thetas = zeros(1, Variables.N);
            for(n = 1:Variables.N)
                thetas(n) = thetaMoins + ((thetaPlus - thetaMoins) / (2 * Variables.N)) * ((2 * n) - 1);
            end
            phis = zeros(1, Variables.M)
            for(m = 1:Variables.M)
                phis(m) = phiMoins + ((phiPlus - phiMoins) / (2 * Variables.M)) * ((2 * m) - 1);
            end
        end
    end
end