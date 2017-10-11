classdef Variables
    properties (Constant)
        coup0 = 0; %coup réussi
        coup1 = 1; %coup du mauvais côté de la table
        coup2 = 2; %coup dans le filet
        coup3 = 3; %coup au sol
        coupIntdetermine = -1; %coup en progression
        
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
    end
end