function [coup, tf, rbf, vbf] = Devoir2(option, rbi, vbi, wbi)
    DeltaT = 0.01;
    if (option == Variables.option1)
        [rbf, vbf, tf, coup] = Option1.option1(rbi, vbi, wbi, DeltaT);
    elseif (option == Variables.option2)
        [rbf, vbf, tf, coup] = Option1.option1(rbi, vbi, wbi, DeltaT);
    elseif (option == Variables.option3)
        [rbf, vbf, tf, coup] = Option1.option1(rbi, vbi, wbi, DeltaT);
    end
end