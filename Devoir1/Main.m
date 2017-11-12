angRot = 0;
vangulaire = [0; 0; 0];
forces = [11000000; 8750000; 8750000];
posNL = [0; 0; 0];

[cm, icm, ac] = Devoir1(angRot, vangulaire, forces, posNL)

angRot2 = -pi/3;
vangulaire2 = [-0.54; 0; 0];
forces2 = [11000000; 8750000; 0];
posNL2 = [0; -19.6075; 50];

[cm2, icm2, ac2] = Devoir1(angRot2, vangulaire2, forces2, posNL2)