function [xi, yi, zi, face] = Devoir4(nout, nin, poso)
    % [xi, yi, zi, face] = Outils.avantCollision(nout, nin, poso);
    xi = 1;
    yi = 1;
    zi = 1;
    face = 1;
    [point1, normale1] = Collision.collisionExterieure([0; 0; 0], [1; 1; 1])
    [point2, normale2, couleur2] = Collision.collisionInterieure([3.5; 4; 18], [0; 0; 1])
end
