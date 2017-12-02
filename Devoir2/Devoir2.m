function [coup, tf, rbf, vbf] = Devoir2(option, rbi, vbi, wbi)
    [rbf, vbf, tf, coup] = Simulation.simulation(rbi, vbi, wbi, option);
end
