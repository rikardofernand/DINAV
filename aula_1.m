% AULA 1 de DINAV - MEEC-SA
%Ricardo Fernandes, 1180099@isep.ipp.pt 
%
% Objetivo do exercicio:   
%  o utilizador definir os valores de L1, L2 e h
%  utilizador deverá introduzir valores de tehta 1, tetha 2 e tetha 3
%  
%  O robô deverá ser representado na posição definida
%  deverão ser indicadas as coordenadas x, y e z da
%  extremidade do robô
%  robô deverá ser representado num gráfico 3D, com os
%  limites dos eixos escolhidos de forma adequada e
%  corretamente legendados


%Registo de alterações:
%   Data        Programmador             Descrição da mudança
%   ====        =========               ====================
% 16/05/2019    R. F. Fernandes         Original
%
% Definição das variaveis:
%   h          -- altura desde a base do manipulador até à junta 1
%   L1         -- comprimento do elo 1 
%   L2         -- comprimento do elo 2
%   Theta1     -- posição angular da junta 1  
%   Theta2     -- posição angular da junta 2
%   Theta3     -- posição angular da junta 2



%%
clc, close all, clear all; 
%
% Introduzir parâmetros iniciais
prompt = {'Introduza h (m)','Introduza L1 (m)','Introduza L2 (m)','Introduza theta1 (graus)','Introduza theta2 (graus)','Introduza theta3 (graus)'};
dlgtitle = 'Input';
dims = [1 50];
definput = {'2','1','0.5','0','0','0'};
answer = inputdlg(prompt,dlgtitle,dims,definput);

%converter string to number
h = str2num(answer{1});
L1= str2num(answer{2});
L2= str2num(answer{3});
theta1=str2num(answer{4});
theta2=str2num(answer{5});
theta3=str2num(answer{6});
 
%convert deg2rad
theta1= theta1 *pi/180; 
theta2= theta2  *pi/180;
theta3= theta3 *pi/180;

%calculo das coordenadas x1, y1, z1 para a junta 2 
x1=L1*cos(theta2)*cos(theta1);
y1=L1*cos(theta2)*sin(theta1);
z1=h+L1*sin(theta2);

%calculo das coordenadas x, y e z da  extremidade do robô
x=(L1*cos(theta2)+ L2*(cos(theta2+theta3))) *cos(theta1);
y=(L1*cos(theta2)+ L2*(cos(theta2+theta3))) *sin(theta1);
z= h + L1*sin(theta2) + L2*sin(theta2+theta3);

format short
%Display data on command window
Parametros=('parâmetros iniciais: h L1 L2 theta1 theta2 theta 3');
Init=[h L1 L2 theta1 theta2 theta3];
disp(Parametros)
disp(Init)

head=('extremidade do robô X   Y   Z ');
Tabvar = [   x    y     z];
disp(head)
disp(Tabvar)

%Gráfico do robô 
plot3([0 0],[0 0],[0 h],'LineWidth',8);
hold on
plot3([0 x1],[0 y1],[h z1],'LineWidth',8);
plot3([x1 x],[y1 y],[z1 z],'LineWidth',8);
xlabel('x (m)','FontSize',12); 
ylabel('y (m)','FontSize',12);
zlabel('z (m)','FontSize',12);
% axis
size=[x y z];
big_ax=max(size); big_ax=big_ax*1.2;
axis([-big_ax big_ax,-big_ax big_ax,0 big_ax]) %'square');
grid on;
%pbaspect([1 1 1])
