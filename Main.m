% if (Variables.essai == 1) % Essai 1
%     nout_1 = 1;
%     nin_1 = 1;
%     poso_1 = [0; 0; 5];
% 
%     [xi_1, yi_1, zi_1, face_1] = Devoir4(nout_1, nin_1, poso_1)
% 
% elseif (Variables.essai == 2) % Essai 2
%     nout_2 = 1;
%     nin_2 = 1.5;
%     poso_2 = [0; 0; 5];
% 
%     [xi_2, yi_2, zi_2, face_2] = Devoir4(nout_2, nin_2, poso_2)
% 
% elseif (Variables.essai == 3) % Essai 3
%     nout_3 = 1;
%     nin_3 = 1.5;
%     poso_3 = [0; 0; 0];
% 
%     [xi_3, yi_3, zi_3, face_3] = Devoir4(nout_3, nin_3, poso_3)
% 
% elseif (Variables.essai == 4) % Essai 4
%     nout_4 = 1.2;
%     nin_4 = 1;
%     poso_4 = [0; 0; 5];
% 
%     [xi_4, yi_4, zi_4, face_4] = Devoir4(nout_4, nin_4, poso_4)
% end
robs = [0; 0; 5];
rayons = Balayage.trouverRayons(robs)