classdef Variables
    properties (Constant)
        coup0 = 0; %coup réussi
        coup1 = 1; %coup du mauvais côté de la table
        coup2 = 2; %coup dans le filet
        coup3 = 3; %coup au sol
        coupIntdetermine = -1; %coup en progression
        
        % points dessinant la table
        pointTable1 = [0, 0, Variables.hTable];
        pointTable2 = [0, Variables.largTable, Variables.hTable];
        pointTable3 = [Variables.longTable, Variables.largTable, Variables.hTable];
        pointTable4 = [Variables.longTable, 0, Variables.hTable];
        
         % points dessinant le filet
         
        pointFilet1 = [Variables.longTable/2, -Variables.debordementFilet, Variables.hTable];
        pointFilet2 = [Variables.longTable/2, -Variables.debordementFilet, Variables.hTable + Variables.hFilet];
        pointFilet3 = [Variables.longTable/2, Variables.largTable + Variables.debordementFilet, Variables.hTable + Variables.hFilet];
        pointFilet4 = [Variables.longTable/2, Variables.largTable + Variables.debordementFilet, Variables.hTable];
        
        option1 = 1;
        option2 = 2;
        option3 = 3;
        
        rb = 0.0199;
        mb = 0.00274;
        
        hTable = 0.76;
        longTable = 2.74;
        largTable = 1.525;
        
        hFilet = 0.1525;
        largFilet = 1.83;
        debordementFilet = 0.1525;
        
        aGrav = -9.81;
        
        p = 1.2;
        Cv = 0.5;
        A = pi * Variables.rb^2;
        Cm = 0.29;
        
        erreur = 0.001;
    end
end