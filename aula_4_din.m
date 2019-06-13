%aula 
clear all
% r=90;
% h=120;
% Ir=240*h^3/3
% I1=1/8*pi*r^4
% I2=I1-( (pi*r^2/2) *(4*r/(3*pi))^2)
% I3=I2+ ( (pi*r^2/2)* (120 - 4*r/(3*pi) )^2)  
% 
% Ixx=Ir-I3

%Ix=(1/8*pi-8/(18*pi))*r^4+(120-4*r/(3*pi))^4*(pi*r^2/2)

%% Exercicio 2
% c=(40+50+60)*1e-3;
% a=(45+45)*1e-3;
% b=(15+15)*1e-3;
% V_para=a*b*c
% m_para=V_para*7850 %kg/m3
% 
% Ix_para=1/12*m_para*(b^2+c^2)
% 
% 
% %cilindro (furo)
% Vol_cili=pi*(38e-3)^2*b
% m_cili=Vol_cili*7850 %kg/m3
% Icilindro=1/2*m_cili*(38e-3)^2
% Icilindro_y_z=1/12*m_cili*(3*(38e-3)^2+b^2)
% 
% %meio cilindro
% V_meio_cili=pi*(45e-3)^2*40e-3/2
% m_meio_cili=V_meio_cili*7850



%% Exercicio 1
%chapa 1

V_Chap_1=120/1000*150/1000*2/1000
mchapa1=V_Chap_1*7850
Ixc_1=1/12*mchapa1*((120/1000)^2 )
Izc_1=1/12*mchapa1*(0.120^2+0.15^2)
Iyc_1=1/12*mchapa1*(0.15^2)

%chapa 2
Vchapa_2=150*2/1000*150*2/1000*2/1000
mchapa_2=Vchapa_2*7850

Ixc_2=1/12 *mchapa_2*(0.3^2)
Iyc_2=1/12*mchapa_2*(0.3^2+0.3^3)
Izc_2=1/12*mchapa_2

%I2x=1/12*mchapa_2*(

%chapa 3
Vchapa_3=120/1000*150/1000*2/1000
mchapa_3=Vchapa_3*7850


