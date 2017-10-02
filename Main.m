% % Essai #1
% 
% rbi_e1 = [0; 0.5; 1.1];
% vbi_e1 = [4; 0; 0.8];
% wbi_e1 = [0; -70; 0];
% 
% [coup_e1_1, tf_e1_1, rbf_e1_1, vbf_e1_1] = Devoir2(Variables.option1, rbi_e1, vbi_e1, wbi_e1)
% [coup_e1_2, tf_e1_2, rbf_e1_2, vbf_e1_2] = Devoir2(Variables.option2, rbi_e1, vbi_e1, wbi_e1)
% [coup_e1_3, tf_e1_3, rbf_e1_3, vbf_e1_3] = Devoir2(Variables.option3, rbi_e1, vbi_e1, wbi_e1)
% 
% % Essai #2
% 
% rbi_e2 = [0; 0.4; 1.14];
% vbi_e2 = [10; 1; 0.2];
% wbi_e2 = [0; 100; -50];
% 
% [coup_e2_1, tf_e2_1, rbf_e2_1, vbf_e2_1] = Devoir2(Variables.option1, rbi_e2, vbi_e2, wbi_e2)
% [coup_e2_2, tf_e2_2, rbf_e2_2, vbf_e2_2] = Devoir2(Variables.option2, rbi_e2, vbi_e2, wbi_e2)
% [coup_e2_3, tf_e2_3, rbf_e2_3, vbf_e2_3] = Devoir2(Variables.option3, rbi_e2, vbi_e2, wbi_e2)
% 
% % Essai #3
% 
% rbi_e3 = [2.74; 0.5; 1.14];
% vbi_e3 = [-5; 0; 0.2];
% wbi_e3 = [0; 100; 0];
% 
% [coup_e3_1, tf_e3_1, rbf_e3_1, vbf_e3_1] = Devoir2(Variables.option1, rbi_e3, vbi_e3, wbi_e3)
% [coup_e3_2, tf_e3_2, rbf_e3_2, vbf_e3_2] = Devoir2(Variables.option2, rbi_e3, vbi_e3, wbi_e3)
% [coup_e3_3, tf_e3_3, rbf_e3_3, vbf_e3_3] = Devoir2(Variables.option3, rbi_e3, vbi_e3, wbi_e3)
% 
% % Essai #4
% 
% rbi_e4 = [0; 0.3; 1];
% vbi_e4 = [10; -2; 0.2];
% wbi_e4 = [0; 10; -100];
% 
% [coup_e4_1, tf_e4_1, rbf_e4_1, vbf_e4_1] = Devoir2(Variables.option1, rbi_e4, vbi_e4, wbi_e4)
% [coup_e4_2, tf_e4_2, rbf_e4_2, vbf_e4_2] = Devoir2(Variables.option2, rbi_e4, vbi_e4, wbi_e4)
% [coup_e4_3, tf_e4_3, rbf_e4_3, vbf_e4_3] = Devoir2(Variables.option3, rbi_e4, vbi_e4, wbi_e4)



% Tests collisions
coup0 = Collisions.collision(1.7, 0.1, Variables.hTable + Variables.rb/2, 0)
coup1 = Collisions.collision(1, 0.1, Variables.hTable + Variables.rb/2, 0)
coup2 = Collisions.collision(Variables.longTable/2, 0.1, Variables.hTable + Variables.hFilet, 0)
coup3 = Collisions.collision(Variables.longTable/2, 0.1, Variables.rb/2, 0)