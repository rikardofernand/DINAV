function [theta,thetap, thetapp , t] = interpolacao_cubica(thetaini, thetaf,tf)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
global n
a0=thetaini; %tetha inicial  
a1=0 ;
a2=3/tf^2*(thetaf-thetaini);
a3=-2/tf^3 *(thetaf-thetaini);

t=0:tf/n:tf;
k=1;

for w=1:n+1
    theta(k)=a0+a1*t(w)+a2*t(w).^2+a3*t(w).^3;
    thetap(k)=2*a2*t(w)+3*a3*t(w).^2;
    thetapp(k)=2*a2+6*a3*t(w);
       k=k+1;
end




end

