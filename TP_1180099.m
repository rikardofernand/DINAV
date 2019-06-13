% DINAV - MEEC-SA
% Ricardo Fernandes, 1180099@isep.ipp.pt 
%
% Objetivo do exercicio:   
%  o utilizador definir os valores de L1, L2 e h
%  utilizador dever� introduzir valores finais de x, y, z, 
% As solu��es finais dos angulos theta1, theta2 e theta 3 s�o calculadas
%  e exibidas numa tabela 
% As quatro solu��es do manipulador 3R s�o representadas graficamente  
%
%  O rob� dever� ser representado na posi��o definida
%  dever�o ser indicadas as coordenadas x, y e z da
%  extremidade do rob�
%  rob� dever� ser representado num gr�fico 3D, com os
%  limites dos eixos escolhidos de forma adequada e
%  corretamente legendados


%Registo de altera��es:
%   Data        Programmador             Descri��o da altera��o
%   ====        =========               ====================
% 16/05/2019    R. F. Fernandes         Original
%
% Defini��o das variaveis:
%   h          -- altura desde a base do manipulador at� � junta 1
%   L1         -- comprimento do elo 1 
%   L2         -- comprimento do elo 2
%   x          -- posi��o posi��o final x da extremidade do manipulador  
%   y          -- posi��o posi��o final y da extremidade do manipulador
%   z          -- posi��o posi��o final z da extremidade do manipulador

%%
clc, close all, clear all;
format short %
% Introduzir par�metros iniciais
prompt = {'Introduza h (m)','Introduza L1 (m)','Introduza L2 (m)','Introduza x1 inicial (m)','Introduza y1 inicial (m)','Introduza z1 inicial(m)','Introduza x2 interm�dio (m)','Introduza y2 interm�dio (m)','Introduza z2 interm�dio(m)','Introduza x3 final (m)','Introduza y3 final (m)','Introduza z3 final(m)','intervalo de tempo para percorrer a traject�ria 1 (tf1 / s)','intervalo de tempo para percorrer a traject�ria 2 (tf2 / s)'};
dlgtitle = 'Input';
dims = [1 50];
definput = {'1.6','1.5','1.5','0.5','1.1','0.6','1.1','1.35','1.63','-1.85','-1.42','1.95','10','15'};
answer = inputdlg(prompt,dlgtitle,dims,definput);

%converter string to number
h = str2num(answer{1});
L1= str2num(answer{2});
L2= str2num(answer{3});
x(1)=str2num(answer{4});
y(1)=str2num(answer{5});
z(1)=str2num(answer{6});
x(2)=str2num(answer{7});
y(2)=str2num(answer{8});
z(2)=str2num(answer{9});
x(3)=str2num(answer{10});
y(3)=str2num(answer{11});
z(3)=str2num(answer{12});
tf(1)=str2num(answer{13});
tf(2)=str2num(answer{14});
maxlength=L1+L2; %raio que define o volume de trabalho
minlength=L1-L2; %Dexterous Workspace
r=sqrt( (x-0).^2+(y-0).^2+(z-h).^2 ); %calculo do raio do volume de trabalho na junta 1

%logical tests
if h<=0||L1<=0||L2<=0 f=msgbox('Introduza apenas valores positivos de h, L1 eL2 ', 'Error','error');
elseif L1<L2 f=msgbox('Intoduza L1 maior ou igual a L2 (para minimizar "constrains" nas juntas)', 'Error','error');
elseif z<0 f=msgbox('Introduza apenas valores positivos de Z ', 'Error','error');
    %elseif r>maxlength || r<minlength f=msgbox('coordenadas finais XYZ fora do volume de trabalho do manipulador', 'Error','error')
    %elseif x==0 && y==0 &&r<maxlength f=msgbox('D� origem a uma singularidade', 'Error','error')
else
    
 global n     
 n=20; %numero de pontos para a descretizacao da trajetoria
 
 %calculo do angulos dos angulos correspondenes � pos inicial, interm�dia e final
 
    for i=1:3  %3 posicoes 
        theta1(i)=atan2(y(i),x(i));
        g=(x(i)^2+y(i)^2+(z(i)-h)^2-L1^2-L2^2)/(2*L1*L2);
        theta3(i)=atan2(-sqrt(1-g^2),g);
        theta2(i)=atan2((z(i)-h),sqrt(x(i)^2+y(i)^2))-atan2(L2*sin(theta3(i)),L1+L2*cos(theta3(i)));
    end
    
    
    
    %calculo da trajet�ria
    
    for k=1:2  
        
        [theta1_int(k,:),theta1p_int(k,:),theta1pp_int(k,:),t(k,:)]=interpolacao_cubica(theta1(k),theta1(k+1),tf(k));
        [theta2_int(k,:),theta2p_int(k,:),theta2pp_int(k,:),t(k,:)]=interpolacao_cubica(theta2(k),theta2(k+1),tf(k));
        [theta3_int(k,:),theta3p_int(k,:),theta3pp_int(k,:),t(k,:)]=interpolacao_cubica(theta3(k),theta3(k+1),tf(k));
        
      if k>1 %para somar o tempo na segunda linha
      t(k,:)=t(k,:)+t(k-1,length(t));    
      end
        
        %subplot(3,1,1),
        figure(10);
        hold on
        plot(t(k,:),rad2deg(theta1_int(k,:)), 'DisplayName','posi��o junta 1')
        plot(t(k,:),rad2deg(theta2_int(k,:)), 'DisplayName','posi��o junta 2')
        plot(t(k,:),rad2deg(theta3_int(k,:)), 'DisplayName','posi��o junta 3')
        title('Posi��o theta')
        xlabel('{\it t} (s)','FontSize',12);
        ylabel('\theta ( � ) ','FontSize',14);
        lgd = legend;
        lgd.NumColumns = 2;
        
        %subplot(3,1,2),
        figure(20);
        hold on
        title('Velocidade angular')
        plot(t(k,:),theta1p_int(k,:)*180/pi,'DisplayName','velocidade junta 1')
        plot(t(k,:),theta2p_int(k,:)*180/pi,'DisplayName','velocidade junta 2')
        plot(t(k,:),theta3p_int(k,:)*180/pi,'DisplayName','velocidade junta 3')
        xlabel('{\it t} (s)','FontSize',12);
        ylabel('$\stackrel{.}{\theta }(^o/s)$','interpreter','latex','FontSize',14);
        lgd = legend;
        lgd.NumColumns = 2;
        
        %subplot(3,1,3),
        figure(30);
        hold on
        title('acelera��o angular')
        plot(t(k,:),theta1pp_int(k,:)*180/pi,'DisplayName','acelera��o junta 1')
        plot(t(k,:),theta2pp_int(k,:)*180/pi,'DisplayName','acelera��o junta 2')
        plot(t(k,:),theta3pp_int(k,:)*180/pi,'DisplayName','acelera��o junta 3')
        xlabel('{\it t} (s)','FontSize',12);
        ylabel('$\stackrel{..}{\theta }(^o/s^2)$','interpreter','latex','FontSize',14);
        lgd = legend;
        lgd.NumColumns = 2;        
        hold off
          
        
        
    end
    
    jk=1;
    
    for q=1:2
    for p=1:length(theta1_int)
    %calculo das coordenadas x1, y1, z1 para a junta 2
    x1=L1*cos(theta2_int(q,p))*cos(theta1_int(q,p));
    y1=L1*cos(theta2_int(q,p))*sin(theta1_int(q,p));
    z1=h+L1*sin(theta2_int(q,p));
    
         
    %calculo das coordenadas x, y e z da  extremidade do
    %manipulador
    x2=(L1*cos(theta2_int(q,p))+ L2*(cos(theta2_int(q,p)+theta3_int(q,p)))) *cos(theta1_int(q,p));
    y2=(L1*cos(theta2_int(q,p))+ L2*(cos(theta2_int(q,p)+theta3_int(q,p)))) *sin(theta1_int(q,p));
    z2= h + L1*sin(theta2_int(q,p)) + L2*sin(theta2_int(q,p)+theta3_int(q,p));
             
    xlinha(jk)=x2;
    ylinha(jk)=y2;
    zlinha(jk)=z2;
    
    
    
    %Gr�fico do rob� manipulador
    %figure(2)
    
    figure(1)
    view(127,33)
    trajetoria=plot3([0 0],[0 0],[0 h],'LineWidth',8,'Color',[0,0.45,0.74]);
    hold on
    trajetoria=plot3([0 x1],[0 y1],[h z1],'LineWidth',8,'Color',[0.85 0.3 0.10]);
    trajetoria=plot3([x1 x2],[y1 y2],[z1 z2],'LineWidth',8,'Color',[0.93 0.69 0.13]);
    trajetoria=plot3(xlinha,ylinha,zlinha,'r','LineWidth',3);
    title('manipulador rob�tico')
    xlabel('x (m)','FontSize',12);
    ylabel('y (m)','FontSize',12);
    zlabel('z (m)','FontSize',12);
    %axis
   
    big_ax=(h+L1+L2)*1.2;
    axis([-big_ax big_ax,-big_ax big_ax,0 big_ax]); %'square');
    grid on;
    %pbaspect([1 1 1])
    %pause(1);
    if(p<length(theta1_int))
        w=tf(q)/n;
        pause(w);
        cla%(trajetoria) ;
        %delete(trajetoria);
    end
    jk=jk+1;
    end
    end 
    delete(figure(2))
    %display dos �ngulos e da posi��o final para cada uma das solu��es
%     f = figure;
%     t = uitable('ColumnName', {'theta 1', 'theta 2', 'theta 3', 'xfinal','yfinal','zfinal'});
%     drawnow;
%     set(t, 'Data', pose)
  
end