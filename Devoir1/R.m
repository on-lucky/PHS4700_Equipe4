classdef R
    methods (Static)
        function matriceRot = MatriceDeRotation(angRot)
			matriceRot = [1 0 0;
						  0 cos(angRot) -sin(angRot);
						  0 sin(angRot) cos(angRot)];
        end
    end
end