function [T1,T2,T3] = dinamica_inversa(theta1,theta2,theta3,theta1p,theta2p,theta3p,theta1pp,theta2pp,theta3pp)
%funcao utilizada para calcular a cinem�tica inversa baseada no m�todo de
%Lagrange
%   

global m2; global m3; global L1 ; global L2 ;  

m23=0;
m34=0;
% x2 = 0.5*L2*cos(theta2)*cos(theta1);
% y2 = 0.5*L2*cos(theta2)*sen(theta1);
% z2 = 0.5*L2*cos(theta2);
% 
% x23 = L2*cos(theta2)*cos(theta1);
% y23 = L2*cos(theta2)*sen(theta1);
% z23 = L2*sen(theta2);
% 
% x3 = (L2*cos(theta2)+0.5*L3*cos(theta2+theta3))*cos(theta1);
% y3 = (L2*cos(theta2)+0.5*L3*cos(theta2+theta3))*sen(theta1);
% z3 = L2*sen(theta2)+0.5*L3*sen(theta2+theta3);
% 
% x34 = (L2*cos(theta2)+L3cos(theta2+theta3))*cos(theta1);
% y34 = (L2*cos(theta2)+L3*cos(theta2+theta3))*sen(theta1);
% z34 = L2*sen(theta2)+L3*sen(theta2+theta3);

g=9.8;

Ma=0.5*m2+ m23 + m3 +m34;
Mb=m3+2*m34;
Ia=(0.25*m2 + m23 +m3 + m34)*L1^2;
Ib=(m3+2*m34+m3)*L1*L2;
Ic=(m3+4*m34)*L2^2;

for i=1:length(theta1)
    T1(i)=(Ia*(cos(theta2(i)))^2 + Ib* cos(theta2(i))*(cos(theta2(i)+theta3(i))) + 0.25*Ic*(cos(theta2(i)+theta3(i)))^2)*theta1pp(i)...
        -(Ia*sin(2*theta2(i))+Ib*sin(2*theta3(i)+theta3(i))+0.25*Ic*sin(2*theta2(i)+2*theta3(i)))*theta1p(i)*theta2p(i)...
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

