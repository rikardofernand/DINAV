% DINAV - MEEC-SA
%Ricardo Fernandes, 1180099@isep.ipp.pt 
%
% Objetivo do exercicio:   
%  o utilizador definir os valores de L1, L2 e h
%  utilizador deverá introduzir valores finais de x, y, z, 
% As soluções finais dos angulos theta1, theta2 e theta 3 são calculadas
%  e exibidas numa tabela 
% As quatro soluções do manipulador 3R são representadas graficamente  
%
%  O robô deverá ser representado na posição definida
%  deverão ser indicadas as coordenadas x, y e z da
%  extremidade do robô
%  robô deverá ser representado num gráfico 3D, com os
%  limites dos eixos escolhidos de forma adequada e
%  corretamente legendados


%Registo de alterações:
%   Data        Programmador             Descrição da alteração
%   ====        =========               ====================
% 16/05/2019    R. F. Fernandes         Original
%
% Definição das variaveis:
%   h          -- altura desde a base do manipulador até à junta 1
%   L1         -- comprimento do elo 1 
%   L2         -- comprimento do elo 2
%   x          -- posição posição final x da extremidade do manipulador  
%   y          -- posição posição final y da extremidade do manipulador
%   z          -- posição posição final z da extremidade do manipulador

%%
clc, close all, clear all;
format short %
% Introduzir parâmetros iniciais
prompt = {'Introduza h (m)','Introduza L1 (m)','Introduza L2 (m)','Introduza x final (m)','Introduza y final (m)','Introduza z final(m)'};
dlgtitle = 'Input';
dims = [1 50];
definput = {'1.6','1.5','1.5','0.9','1.2','1.5'};
answer = inputdlg(prompt,dlgtitle,dims,definput);

%converter string to number
h = str2num(answer{1});
L1= str2num(answer{2});
L2= str2num(answer{3});
x=str2num(answer{4});
y=str2num(answer{5});
z=str2num(answer{6});

maxlength=L1+L2; %raio que define o volume de trabalho
minlength=L1-L2; %Dexterous Workspace
r=sqrt( (x-0)^2+(y-0)^2+(z-h)^2 ); %calculo do raio do volume de trabalho na junta 1

%logical tests
if h<=0||L1<=0||L2<=0 f=msgbox('Introduza apenas valores positivos de h, L1 eL2 ', 'Error','error');
elseif L1<L2 f=msgbox('Intoduza L1 maior ou igual a L2 (para minimizar "constrains" nas juntas)', 'Error','error');
elseif z<0 f=msgbox('Introduza apenas valores positivos de Z ', 'Error','error');
elseif r>maxlength || r<minlength f=msgbox('coordenadas finais XYZ fora do volume de trabalho do manipulador', 'Error','error')
elseif x==0 && y==0 &&r<maxlength f=msgbox('Dá origem a uma singularidade', 'Error','error')
else
  k=1;
  w=1;
    for n=0:pi:pi
        theta1=n+atan2(y,x);
        if n==pi ;
            w=-1 ; %parametro que altera o theta2 quando o braço está em modo "backing" 
        end
            
            
        for i=-1:2:1
            
            g=(x^2+y^2+(z-h)^2-L1^2-L2^2)/(2*L1*L2);
            
            theta3=atan2((i)*sqrt(1-g^2),g);
            
            theta2=atan2((z-h),w*sqrt(x^2+y^2))-atan2(L2*sin(theta3),L1+L2*cos(theta3));
                       
                    
            %convert deg2rad
            pose(k,1)= theta1 *180/pi;
            pose(k,2)= theta2  *180/pi;
            pose(k,3)= theta3 *180/pi;
             
            %calculo das coordenadas x1, y1, z1 para a junta 2
            x1=L1*cos(theta2)*cos(theta1);
            y1=L1*cos(theta2)*sin(theta1);
            z1=h+L1*sin(theta2);
            
            %calculo das coordenadas x, y e z da  extremidade do
            %manipulador
            x2=(L1*cos(theta2)+ L2*(cos(theta2+theta3))) *cos(theta1);
            y2=(L1*cos(theta2)+ L2*(cos(theta2+theta3))) *sin(theta1);
            z2= h + L1*sin(theta2) + L2*sin(theta2+theta3);
            
            pose(k,4)=x2;
            pose(k,5)=y2;
            pose(k,6)=z2;
            k=k+1;
           
          
            %Gráfico do robô manipulador
            figure(1)
            plot3([0 0],[0 0],[0 h],'LineWidth',8);
            hold on
            plot3([0 x1],[0 y1],[h z1],'LineWidth',8);
            plot3([x1 x2],[y1 y2],[z1 z2],'LineWidth',8);
            title('manipulador robótico')
            xlabel('x (m)','FontSize',12);
            ylabel('y (m)','FontSize',12);
            zlabel('z (m)','FontSize',12);
            % axis
            big_ax=(h+L1+L2)*1.2;
            axis([-big_ax big_ax,-big_ax big_ax,0 big_ax]) %'square');
            grid on;
            %pbaspect([1 1 1])
            %pause(1);
        end
    end
        
    %display dos ângulos e da posição final para cada uma das soluções 
    f = figure;
    t = uitable('ColumnName', {'theta 1', 'theta 2', 'theta 3', 'xfinal','yfinal','zfinal'});
    drawnow;
    set(t, 'Data', pose)
      
end