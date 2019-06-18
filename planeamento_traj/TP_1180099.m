% DINAV - MEEC-SA
% Ricardo Fernandes, 1180099@isep.ipp.pt 
%
% Objetivo do exercicio:   
%  
% * planear uma trajet�ria para o rob� se deslocar de ponto inicialde coordenadas (x1, y1, z1)
% * passando por ponto interm�diode coordenadas (x2, y2, z2)
% * at� ponto final de coordenadas (x3, y3, z3)
% 
% 
% Utilizador dever� introduzir valores de:
%         L1, L2 e h - comprimento do elos
%         x1, y1, z1 � coordenadas iniciais da trajet�ria
%         x2, y2, z2 � coordenadas interm�dias da trajet�ria
%         x3, y3, z3 � coordenadas finais da trajet�ria
%         tf1,tf2 � intervalo de tempo para rob� percorrer as trajet�rias
%         entre as coordenadas inicias at� � interm�dia (tf1) e entre a
%         coordenada interm�dia e a final.
%    
%
%  rob� dever� ser representado num gr�fico 3D, com os
%  limites dos eixos escolhidos de forma adequada e
%  corretamente legendados


%Registo de altera��es:
%   Data        Programador             Descri��o da altera��o
%   ====        =========               =====================
% 15/06/2019    R. F. Fernandes         Original
%

clc, close all, clear all;
format short %
%% Introduzir par�metros iniciais
prompt = {'Introduza h (m)','Introduza L1 (m)','Introduza L2 (m)','Introduza x1 inicial (m)','Introduza y1 inicial (m)','Introduza z1 inicial(m)','Introduza x2 interm�dio (m)','Introduza y2 interm�dio (m)','Introduza z2 interm�dio(m)','Introduza x3 final (m)','Introduza y3 final (m)','Introduza z3 final(m)','tf1 (s) - intervalo de tempo para percorrer a traject�ria 1','tf2 (s)- intervalo de tempo para percorrer a traject�ria 2'};
dlgtitle = 'Input';
dims = [1 50];
definput = {'1.6','1.5','1.5','0.5','1.1','0.6','1.1','1.35','1.63','-1.85','-1.42','1.95','10','15'};
answer = inputdlg(prompt,dlgtitle,dims,definput);
%%
 %define global functions   
 global h, global L1, global L2; 
 global n     
 n=40; %numero de pontos para a descretizacao da trajetoria

%% Defini��o das variaveis:
h = str2num(answer{1});   %-- altura desde a base do manipulador at� � junta 1
L1= str2num(answer{2});   %-- comprimento do elo 1 
L2= str2num(answer{3});   %-- comprimento do elo 2
x(1)=str2num(answer{4});  %-- coordenada x inicial da trajet�ria 
y(1)=str2num(answer{5});  %-- coordenada y inicial da trajet�ria
z(1)=str2num(answer{6});  %-- coordenada z inicial da trajet�ria
x(2)=str2num(answer{7});  %-- coordenada x interm�dia da trajet�ria
y(2)=str2num(answer{8});  %-- coordenada y interm�dia da trajet�ria
z(2)=str2num(answer{9});  %-- coordenada z interm�dia da trajet�ria
x(3)=str2num(answer{10}); %-- coordenada x final da trajet�ria
y(3)=str2num(answer{11}); %-- coordenada y final da trajet�ria
z(3)=str2num(answer{12}); %-- coordenada z final da trajet�ria
tf(1)=str2num(answer{13});%-- intervalo de tempo para rob� percorrer a trajet�ria entre as coordenadas iniciais e interm�dias
tf(2)=str2num(answer{14});%-- intervalo de tempo para rob� percorrer a trajet�ria entre as coordenadas interm�dias e finais
%%
%logical tests
maxlength=L1+L2; %raio que define o volume de trabalho
minlength=L1-L2; %Dexterous Workspace
r=sqrt( (x-0).^2+(y-0).^2+(z-h).^2 ); %calculo do raio do volume de trabalho na junta 1

if h<=0||L1<=0||L2<=0 f=msgbox('Introduza apenas valores positivos de h, L1 eL2 ', 'Error','error');
elseif L1<L2 f=msgbox('Intoduza L1 maior ou igual a L2 (para minimizar "constrains" nas juntas)', 'Error','error');
elseif z<0 f=msgbox('Introduza apenas valores positivos de Z ', 'Error','error');
elseif tf(1)<= 0 ||tf(2)<=0 f=msgbox('Introduza apenas valores positivos de t ', 'Error','error');
    %elseif r>maxlength || r<minlength f=msgbox('coordenadas finais XYZ fora do volume de trabalho do manipulador', 'Error','error')
    %elseif x==0 && y==0 &&r<maxlength f=msgbox('D� origem a uma singularidade', 'Error','error')
else

 
 %calculo dos �ngulos correspondenes � pos inicial, interm�dia e final
 
    for i=1:3  %3 posicoes (inicial, intermd�dia e final) (uso da cinem�tica inversa)
        theta1(i)=atan2(y(i),x(i));
        g=(x(i)^2+y(i)^2+(z(i)-h)^2-L1^2-L2^2)/(2*L1*L2);
        theta3(i)=atan2(-sqrt(1-g^2),g);
        theta2(i)=atan2((z(i)-h),sqrt(x(i)^2+y(i)^2))-atan2(L2*sin(theta3(i)),L1+L2*cos(theta3(i)));
    end
   
       
    %calculo da trajet�ria utilizando a funcao de interpolacao
    
    for k=1:2  
        
        [theta1_aux(k,:),theta1p_aux(k,:),theta1pp_aux(k,:),t(k,:)]=interpolacao_cubica(theta1(k),theta1(k+1),tf(k));
        [theta2_aux(k,:),theta2p_aux(k,:),theta2pp_aux(k,:),t(k,:)]=interpolacao_cubica(theta2(k),theta2(k+1),tf(k));
        [theta3_aux(k,:),theta3p_aux(k,:),theta3pp_aux(k,:),t(k,:)]=interpolacao_cubica(theta3(k),theta3(k+1),tf(k));
        
      if k>1 %para somar o tempo na segunda linha
      t(k,:)=t(k,:)+t(k-1,length(t));    
      end
    end
    
    
   
    
    %cinematica direta a partir dos angulos obtidos acima
    for k=1:2 %tf1 trajetoria 1 e tf1 trajetoria 2
        
        [x1(k,:),y1(k,:),z1(k,:),x2(k,:),y2(k,:),z2(k,:)]=cinematica_direta(theta1_aux(k,:),theta2_aux(k,:),theta3_aux(k,:));
        
    end
    
        for k=1:2
        %calculo da velocidade no espa�o operacional
         %t_dot=diff(t(k,:)
         vx2(k,length(x2))=zeros,vy2(k,length(x2))=zeros,vz2(k,length(x2))=zeros;
         vx2(k,2:length(x2))=diff(x2(k,:)),vy2(k,2:length(y2))=diff(y2(k,:)),vz2(k,2:length(z2))=diff(z2(k,:));
         % calculo da aceleracao
         ax2(k,length(vx2))=zeros,ay2(k,length(vy2))=zeros,az2(k,length(vz2))=zeros;
         ax2(k,2:length(vx2))=diff(vx2(k,:)),ay2(k,2:length(vy2))=diff(vy2(k,:)),az2(k,2:length(vz2))=diff(vz2(k,:));
         
        
        end 
    
    
   
   
    
    %plot(vx2,t)
    %graficos
   
    %% plot das posicoes, velocidades e aceleracoes das juntas
    for j=1:2   
     figure(2)
        subplot(3,3,1),
        %figure(10); %posicao angular das 3 juntas
        hold on
        plot(t(j,:),rad2deg(theta1_aux(j,:)),'r', 'DisplayName','posi��o junta t1 e t2')
        plot(t(j,:),rad2deg(theta2_aux(j,:)),'b', 'DisplayName','posi��o junta 2')
        plot(t(j,:),rad2deg(theta3_aux(j,:)),'g', 'DisplayName','posi��o junta 3')
        title('Posi��o theta')
        xlabel('{\it t} (s)','FontSize',12);
        ylabel('\theta ( � ) ','FontSize',14);
        legend('posi��o junta para t1 e t2','cos(2x)','posi��o junta 3')
        lgd.NumColumns = 2;
        
        figure(2)
        subplot(3,3,3); %velocidade angular das 3 juntas
        hold on
        title('Velocidade angular')
        plot(t(j,:),theta1p_aux(j,:)*180/pi,'r','DisplayName','velocidade junta 1')
        plot(t(j,:),theta2p_aux(j,:)*180/pi,'b','DisplayName','velocidade junta 2')
        plot(t(j,:),theta3p_aux(j,:)*180/pi,'g','DisplayName','velocidade junta 3')
        xlabel('{\it t} (s)','FontSize',12);
        ylabel('$\stackrel{.}{\theta }(^o/s)$','interpreter','latex','FontSize',14);
        lgd = legend;
        lgd.NumColumns = 2;
        
        figure(2); %aceleracao angular das 3 juntas
        subplot(3,3,5)
        hold on
        title('acelera��o angular')
        plot(t(j,:),theta1pp_aux(j,:)*180/pi,'DisplayName','acelera��o junta 1')
        plot(t(j,:),theta2pp_aux(j,:)*180/pi,'DisplayName','acelera��o junta 2')
        plot(t(j,:),theta3pp_aux(j,:)*180/pi,'DisplayName','acelera��o junta 3')
        xlabel('{\it t} (s)','FontSize',12);
        ylabel('$\stackrel{..}{\theta }(^o/s^2)$','interpreter','latex','FontSize',14);
        lgd = legend;
        lgd.NumColumns = 2;        
       
       
        %posicao no espaco operacional
        figure(2); %posicao nos 3 eixos cartesianos 
        subplot(3,3,2)
        hold on
        title('posi��o no espa�o operacional')
        plot(t(j,:),x2(j,:),'DisplayName','posicao x na no manipulador')
        plot(t(j,:),y2(j,:),'DisplayName','posicao y no manipulador')
        plot(t(j,:),z2(j,:),'DisplayName','posicao z no manipulador')
        xlabel('{\it t} (s)','FontSize',12);
        ylabel('Posi��o (m)','FontSize',14','FontSize',14);
        lgd = legend;
        lgd.NumColumns = 2;
        
        %velocidade no espaco operacional
        figure(2); %velocidade nos 3 eixos cartesianos
        subplot(3,3,4)
        hold on
        title('velocidade no espa�o operacional')
        plot(t(j,:),vx2(j,:),'DisplayName','velocidade x  no manipulador')
        plot(t(j,:),vy2(j,:),'DisplayName','velocidade y no manipulador')
        plot(t(j,:),vz2(j,:),'DisplayName','velocidade z no manipulador')
        xlabel('{\it t} (s)','FontSize',12);
        ylabel('v (m/s)','FontSize',14','FontSize',14);
        lgd = legend;
        lgd.NumColumns = 2;
        
         %aceleracao no espaco operacional
        figure(2); %velocidade nos 3 eixos cartesianos
        subplot(3,3,6)
        hold on
        title('acelera��o espa�o operacional')
        plot(t(j,:),ax2(j,:),'DisplayName',' x ')
        plot(t(j,:),ay2(j,:),'DisplayName','acelera��o y no manipulador')
        plot(t(j,:),az2(j,:),'DisplayName','acelera��o z no manipulador')
        xlabel('{\it t} (s)','FontSize',12);
        ylabel('a (m/s^2)','FontSize',14','FontSize',14);
        if j==2 
            lgd = legend, 
            lgd.NumColumns = 2; 
        end;
        
        
    end
    
    
    
    
    %Gr�fico do rob� manipulador
 for j=1:2
          
    for i=1:length(x1)
    figure(3)
    %subplot(3,2,[2 4 6])
    view(127,33)
    trajetoria=plot3([0 0],[0 0],[0 h],'LineWidth',8,'Color',[0,0.45,0.74]);
    hold on
    trajetoria=plot3([0 x1(j,i)],[0 y1(j,i)],[h z1(j,i)],'LineWidth',8,'Color',[0.85 0.3 0.10]);
    trajetoria=plot3([x1(j,i) x2(j,i)],[y1(j,i) y2(j,i)],[z1(j,i) z2(j,i)],'LineWidth',8,'Color',[0.93 0.69 0.13]);
    
    
    title('manipulador rob�tico')
    xlabel('x (m)','FontSize',12);
    ylabel('y (m)','FontSize',12);
    zlabel('z (m)','FontSize',12);
    %axis
    
    %impress�o da linha da trajectoria na extremidade do manipulador (s�
    %s� aplicavel para dois intervalos
    if j==1 %
        xlinha(j,i)=x2(j,i);
        ylinha(j,i)=y2(j,i);
        zlinha(j,i)=z2(j,i);        
    else
        xlinha(j-1,i+length(x1))=x2(j,i);
        ylinha(j-1,i+length(x1))=y2(j,i);
        zlinha(j-1,i+length(x1))=z2(j,i);                
    end
    trajetoria=plot3(xlinha,ylinha,zlinha,'r','LineWidth',3);
    
    big_ax=(h+L1+L2)*1.2;
    axis([-big_ax big_ax,-big_ax big_ax,0 big_ax]); %'square');
    grid on;
    
    %pbaspect([1 1 1])
    %pause(1);
     
    
    if(i<length(theta1_aux))
            w=tf(j)/n;
            pause(w);
            cla%(trajetoria) ;
            %delete(trajetoria);
        end
    end
 
 end     
     
          
        
    
   
    %delete(figure(2))
    %display dos �ngulos e da posi��o final para cada uma das solu��es
%     f = figure;
%     t = uitable('ColumnName', {'theta 1', 'theta 2', 'theta 3', 'xfinal','yfinal','zfinal'});
%     drawnow;
%     set(t, 'Data', pose)
  
end