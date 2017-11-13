classdef CondInit
    methods (Static)
        function [vaf, vbf] = conditionsInitiales(va, vb, ra, rb, normale, wa, wb, voitureN, p)
            vrMoins = dot(normale, (va - vb));
            
            rap = ra - p;
            rbp = rb - p;
            
            Iaz = (Variables.ma / 12) * (Variables.La^2 + Variables.la^2);
            Iay = (Variables.ma / 12) * (Variables.ha^2 + Variables.la^2);
            Iax = (Variables.ma / 12) * (Variables.La^2 + Variables.ha^2);
            
            Ia = [Iax 0 0;...
                  0 Iay 0;...
                  0 0 Iaz];
            
            Ibz = (Variables.mb / 12) * (Variables.Lb^2 + Variables.lb^2);
            Iby = (Variables.ma / 12) * (Variables.hb^2 + Variables.lb^2);
            Ibx = (Variables.ma / 12) * (Variables.Lb^2 + Variables.hb^2);
            
            Ib = [Ibx 0 0;...
                  0 Iby 0;...
                  0 0 Ibz];
              
            normale3D = [normale(1); normale(2); 0];
            ra3D = [rap(1); rap(2); 0];
            rb3D = [rbp(1); rbp(2); 0];
            
            vecteurTempA = inv(Ia) * cross(ra3D, normale3D);
            vecteurTempB = inv(Ib) * cross(rb3D, normale3D);
            
            yoa = cross(vecteurTempA, ra3D);
            yob = cross(vecteurTempB, rb3D);
            
            Ga = dot(normale3D, yoa);
            Gb = dot(normale3D, yob);
            
            j = -(1 + Variables.coefficientRes) * vrMoins/(1/Variables.ma + 1/Variables.mb + Ga + Gb);
            
            if(voitureN == 2)
                vaf2D = va.' - normale * j / Variables.ma;
                vbf2D = vb.' + normale * j / Variables.mb;
                waf = wa - j * vecteurTempA(3);
                wbf = wb + j * vecteurTempB(3);
            else
                vaf2D = va.' + normale * j / Variables.ma;
                vbf2D = vb.' - normale * j / Variables.mb;
                waf = wa + j * vecteurTempA(3);
                wbf = wb - j * vecteurTempB(3);
            end
            
            vaf = [vaf2D(1) vaf2D(2) waf];
            vbf = [vbf2D(1) vbf2D(2) wbf];
        end
    end
end