function [xi, yi, zi, face] = Devoir4(nout, nin, poso)
    % [xi, yi, zi, face] = Outils.avantCollision(nout, nin, poso);
    xi = 1;
    yi = 1;
    zi = 1;
    face = 1;
    [point, normale] = Collision.collisionExterieure([0; 0; 0], [1; 1; 1])
end
