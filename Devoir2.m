function [coup, tf, rbf, vbf] = Devoir2(option, rbi, vbi, wbi)
    DeltaT = 0.0001;
    if (option == Variables.option1)
        [rbf, vbf, tf, coup] = Simulation.simulation(rbi, vbi, wbi, DeltaT, Variables.option1);
    elseif (option == Variables.option2)
        [rbf, vbf, tf, coup] = Simulation.simulation(rbi, vbi, wbi, DeltaT, Variables.option2);
    elseif (option == Variables.option3)
        [rbf, vbf, tf, coup] = Simulation.simulation(rbi, vbi, wbi, DeltaT, Variables.option3);
    end
end