function [xi, yi, zi, face] = Devoir4(nout, nin, poso)
    %[xi, yi, zi, face] = Outils.avantCollision(nout, nin, poso);
    ut = Optique.refraction([1; -1; 0], [0; 1; 0], 1, 1.33)
    xi = 0;
    yi = 0;
    zi = 0;
    face = 0;
end
