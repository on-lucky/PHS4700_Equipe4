function [cm, icm, ac] = Devoir1(angRot, vangulaire, forces, posNL)
    cm = CM.centreDeMasseGlobal(posNL, angRot);
    icm = Icm.momentInertieGlobal(angRot);
    ac = Ac.AccelerationAngulaire(forces, vangulaire, icm);
end