

%Planeamento da trajetoria

close all, clear all;

theta0=15%deg2rad(15); %graus
thetaf=75%deg2rad(75); %graus
t=3; %segundos
tf=3;
%theta0=a




a0=theta0
a1=0
a2=3/tf^2*(thetaf-theta0)
a3=-2/tf^3*(thetaf-theta0)
n=20
t=0:3/n:3;
k=1
for i=1:n+1
    theta(k)=a0+a1*t(i)+a2*t(i).^2+a3*t(i).^3
    thetap(k)=2*a2*t(i)+3*a3*t(i).^2
    thetapp(k)=2*a2+6*a3*t(i)
   
    k=k+1;
end


figure(1)
plot(t,theta)
title('theta')
figure(2)
hold on
title('thetap')
plot(t,thetap)
figure(3)
hold on
title('thetapp')
plot(t,thetapp)