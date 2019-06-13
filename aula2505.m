% DINAV  15/05/19
% Paulo Guterres 1180097

clear;clc;close all

%% parametros definidos pelo utilizador

h = input('altura do solo (base do manipulador) à junta 1: ');
L1 = input('Comprimento do elo 1: ');
L2 = input('Comprimento do elo 2: ');
global n



%% grafico 3d

%Gráfico do robô 
figure
plot3([0,0],[0,0],[0,0]);
hold on
xlabel('x (m)','FontSize',12); 
ylabel('y (m)','FontSize',12);
zlabel('z (m)','FontSize',12);
grid on
cores = 'rgb';
pos = zeros(3,4);
pos(3,2) = h;
ang = zeros(3);
angi = [1 1 1]; %iniciais dos angulos
angx = 0:1:360; %angulos de 1 a 360
ax = abs(L1+L2+h);
axis([-ax ax -ax ax 0 ax]);
    

for j=1:length(angx)
    ang = angi.*angx(j)*pi/180;
    pos(1,3) = cos(ang(2))*L1*cos(ang(1));
    pos(2,3) = L1*cos(ang(2))*sin(ang(1));
    pos(3,3) = h+L1*sin(ang(2));

    pos(1,4) = (L1*cos(ang(2))+L2*cos(ang(2)+ang(3)))*cos(ang(1));
    pos(2,4) = (L1*cos(ang(2))+L2*cos(ang(2)+ang(3)))*sin(ang(1));
    pos(3,4) = h + L1*sin(ang(2))+L2*sin(ang(2)+ang(3));

   
    for i=2:length(pos)
        graph(i-1)= plot3([pos(1, i-1), pos(1, i)],[pos(2, i-1), pos(2, i)], [pos(3, i-1),pos(3, i)], cores(i-1),'linewidth', 6);   
    end
    
        legend(graph, ['h: ' num2str(h) ', ang 1: ' num2str(rad2deg(ang(1)))],...
        ['L1: ' num2str(L1) ', ang 2: ' num2str(rad2deg(ang(2)))],...
        ['L2: ' num2str(L2) ', ang 3: ' num2str(rad2deg(ang(3)))]);
   
    
    if(j<length(angx))
        
        pause(0.1);
        delete(graph);
    end
end


