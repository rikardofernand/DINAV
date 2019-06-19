function [x1,y1,z1,x2,y2,z2] = cinematica_direta(theta1,theta2,theta3)
%Esta funcao calcula a cinemática direta para um robô RRR. Calcula a posicao das duas
%juntas

 global h, global L1, global L2; 



for i=1:length(theta1)
    %calculo das coordenadas x1, y1, z1 para a junta 2
    x1(i)=L1*cos(theta2(i))*cos(theta1(i));
    y1(i)=L1*cos(theta2(i))*sin(theta1(i));
    z1(i)=h+L1*sin(theta2(i));
    
    
    %calculo das coordenadas x, y e z da  extremidade do manipulador
    x2(i)=(L1*cos(theta2(i))+ L2*(cos(theta2(i)+theta3(i)))) *cos(theta1(i));
    y2(i)=(L1*cos(theta2(i))+ L2*(cos(theta2(i)+theta3(i)))) *sin(theta1(i));
    z2(i)= h + L1*sin(theta2(i)) + L2*sin(theta2(i)+theta3(i));
    
    
end


end

