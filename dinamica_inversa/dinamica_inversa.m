function [T1,T2,T3] = dinamica_inversa(theta1,theta2,theta3,theta1p,theta2p,theta3p,theta1pp,theta2pp,theta3pp)
%funcao utilizada para calcular a cinemática inversa baseada no método de
%Lagrange
%   

global m2; global m3; global L1 ; global L2 ;
global d1, global d2, global d3;

m23=0;
m34=0;
g=9.8;

Ma=0.5*m2+ m23 + m3 +m34;
Mb=m3+2*m34;
Ia=(0.25*m2 + m23 +m3 + m34)*L1^2;
Ib=(m3+2*m34+m3)*L1*L2;
Ic=(m3+4*m34)*L2^2;
% Ia=Ia+;
% Ib=Ib;
% Ic=Ic;

for i=1:length(theta1)
    T1(i)=(Ia*(cos(theta2(i)))^2 + Ib* cos(theta2(i))*(cos(theta2(i)+theta3(i))) + 0.25*Ic*(cos(theta2(i)+theta3(i)))^2)*theta1pp(i)...
        -(Ia*sin(2*theta2(i))+Ib*sin(2*theta2(i)+theta3(i))+0.25*Ic*sin(2*theta2(i)+2*theta3(i)))*theta1p(i)*theta2p(i)...
        -(Ib*cos(theta2(i))*sin(theta2(i)+theta3(i))+0.25*Ic*sin(2*theta2(i)+2*theta3(i)))*theta1p(i)*theta3p(i);
    
    T2(i)=(Ma*L1*cos(theta2(i))+0.5*Mb*L2*cos(theta2(i)+theta3(i)))*g...
        +(Ia+0.25*Ic+Ib*cos(theta3(i)))*theta2pp(i) + (0.25*Ic+0.5*Ib*cos(theta3(i)))*theta3pp(i) ...
        +(0.5*Ia*sin(2*theta2(i))+0.125*Ic*sin(2*theta2(i)+2*theta3(i))+0.5*Ib*sin(2*theta2(i)+theta3(i)))*(theta1p(i))^2 ...
        -(0.5*Ib*sin(theta3(i)))*(theta3p(i))^2 - (Ib*sin(theta3(i)))*theta2p(i)*theta3p(i);
    
    
    T3(i)=(0.5 * Mb*L2*cos(theta2(i)+theta3(i)))*g ...
        +(0.25*Ic+0.5*Ib*cos(theta3(i)))*theta2pp(i) + (0.25*Ic)*theta3pp(i) ...
        +( (0.5*Ib*cos(theta2(i)) +0.25*Ic*cos(theta2(i)+theta3(i)))*sin(theta2(i)+theta3(i))  )*(theta1p(i))^2 ...
        + (0.5*Ib*sin(theta3(i)))*(theta2p(i))^2;
end

end

