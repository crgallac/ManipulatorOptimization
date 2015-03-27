function [ totalMass] = netMass( param)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% param=[paramVars, param1];

%param=[a0 a1 a2 Ro0 Ri0 Ro1 Ri1 Ro2 Ri2 rho Mmot1 Mmot2 Mgrip]

a0=param(1); 
a1=param(2);
a2=param(3); 
Ro0=param(4);
Ri0=param(5);
Ro1=param(6);
Ri1=param(7);
Ro2=param(8);
Ri2=param(9);
rho=param(10);
Mmot1=param(11);
Mmot2=param(12); 
Mgrip=param(13); 
failureStress= param(14); 
f1=param(15);
f2=param(16);

 m0=rho*pi*(Ro0^2-Ri0^2)*a0; 
m1=rho*pi*(Ro1^2-Ri1^2)*a1; 
m2=rho*pi*(Ro2^2-Ri2^2)*a2;

totalMass=m0+m1+m2+Mgrip+Mmot1+Mmot2; 




end

