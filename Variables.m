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
        
        hTable = 0.76;
        longTable = 2.74;
        largTable = 1.525;
        
        hFilet = 0.1525;
        largFilet = 1.83;
        debordementFilet = 0.1525;
        
        aGrav = -9.81;
    end
    
    methods (Static)
    end
end