function [coup, tf, rbf, vbf] = Devoir2(option, rbi, vbi, wbi)
    DeltaT = 0.01;
    erreur = 1; %chiffre arbitraire 
    rbf1 = [0, 0, 0];

    while(erreur > 0.001)
        DeltaT = DeltaT / 2;
        rbf = Simulation.simulation(rbi, vbi, wbi, DeltaT, option, false);
        estPareil = comparerVecteurs(rbf1, [0, 0, 0]);
        if(~estPareil)
            erreur = norm(rbf - rbf1);
        end
        rbf1 = rbf;
    end
    [rbf, vbf, tf, coup] = Simulation.simulation(rbi, vbi, wbi, DeltaT, option, true);
end

function estPareil = comparerVecteurs(vecteur1, vecteur2)
    if(vecteur1(1) == vecteur2(1) && vecteur1(2) == vecteur2(2) && vecteur1(3) == vecteur2(3))
        estPareil = true;
    else
        estPareil = false;
    end
end