classdef Collisions
    properties (Constant)
            
        limiteFilet1 = [Variables.longTable/2;
                        -Variables.debordementFilet;
                        Variables.hTable];
                   
        limiteFilet2 = [Variables.longTable/2;
                        Variables.largTable + Variables.debordementFilet;
                        Variables.hTable + Variables.hFilet];
                    
        limiteTable1 = [0;
                        0;
                        Variables.hTable];
                   
        limiteTable2 = [Variables.longTable;
                        Variables.largTable;
                        Variables.hTable];
        
    end
    
    methods (Static)
        function coup = collision(rx, ry, rz, rxInit)
            coup = Collisions.collisionTable([rx; ry; rz], rxInit);
            if (coup == Variables.coupIntdetermine)
                coup = Collisions.collisionFilet([rx; ry; rz]);
                if (coup == Variables.coupIntdetermine)
                    coup = Collisions.collisionSol([rx; ry; rz]);
                end
            end
        end
        
        function coup = collisionTable(pos, rxInit)                   
            d = Collisions.trouverDistance(pos, Collisions.limiteTable1, Collisions.limiteTable2);
            
            if (d <= Variables.rb)
                if ((rxInit < Variables.longTable/2 && pos(1) <= Variables.longTable/2) ...
                        || (rxInit > Variables.longTable/2 && pos(1) >= Variables.longTable/2))
                    coup = Variables.coup1;
                else
                    coup = Variables.coup0;
                end
            else
                coup = Variables.coupIntdetermine;
            end
        end
        
        function coup = collisionFilet(pos)                   
            d = Collisions.trouverDistance(pos, Collisions.limiteFilet1, Collisions.limiteFilet2);
            
            if (d <= Variables.rb)
                coup = Variables.coup2;
            else
                coup = Variables.coupIntdetermine;
            end
        end
        
        function coup = collisionSol(pos)
            if (pos(3) <= Variables.rb)
                coup = Variables.coup3;
            else
                coup = Variables.coupIntdetermine;
            end
        end
        
        function normeDist = trouverDistance(pos, limite1, limite2)
            d = [0; 0; 0];
            for i=1:3
                if (limite1(i) > limite2(i))
                    temp = limite1(i);
                    limite1(i) = limite2(i);
                    limite2(i) = temp;
                end
                
                if (pos(i) < limite1(i))
                    d(i) = limite1(i) - pos(i);
                elseif (pos(i) > limite2(i))
                    d(i) = pos(i) - limite2(i);
                else
                    d(i) = 0;
                end
            end
            normeDist = norm(d);
        end
    end
end