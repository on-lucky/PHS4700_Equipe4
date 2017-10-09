function [coup, tf, rbf, vbf] = Devoir2(option, rbi, vbi, wbi)
    DeltaT = 0.01;
    if (option == Variables.option1)
        [rbf, vbf, tf, coup] = Simulation.simulation(rbi, vbi, wbi, DeltaT, 'gOption1');
    elseif (option == Variables.option2)
        [rbf, vbf, tf, coup] = Simulation.simulation(rbi, vbi, wbi, DeltaT, 'gOption2');
    elseif (option == Variables.option3)
        [rbf, vbf, tf, coup] = Simulation.simulation(rbi, vbi, wbi, DeltaT, 'gOption3');
    end
end