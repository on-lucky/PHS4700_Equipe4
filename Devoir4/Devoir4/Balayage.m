classdef Balayage
    methods(Static)
        function rayons = trouverRayons(robs)
            
            [thetaMoins, thetaPlus, phiMoins, phiPlus] = Camera.trouverAngles(robs);
            
            [thetas, phis] = Balayage.trouverAngles(thetaMoins, thetaPlus, phiMoins, phiPlus);
            
            rayons = zeros([Variables.M, Variables.N*3]);
            for n = 1:(Variables.N*3)
                for m = 1:Variables.M
                    if(mod(n,3) == 1)
                        rayons(m,n) = sin(thetas(ceil(n/3))) * cos(phis(m));
                    elseif(mod(n,3) ==2)
                        rayons(m,n) = sin(thetas(ceil(n/3))) * sin(phis(m));
                    else
                        rayons(m,n) = cos(thetas(ceil(n/3)));
                    end
                end
            end
        end
        
         function [thetas, phis] = trouverAngles(thetaMoins, thetaPlus, phiMoins, phiPlus)
            thetas = zeros(1, Variables.N);
            for n = 1:Variables.N
                thetas(n) = thetaMoins + ((thetaPlus - thetaMoins) / (2 * Variables.N)) * ((2 * n) - 1);
            end
            phis = zeros(1, Variables.M);
            for m = 1:Variables.M
                phis(m) = phiMoins + ((phiPlus - phiMoins) / (2 * Variables.M)) * ((2 * m) - 1);
            end
        end
    end
end