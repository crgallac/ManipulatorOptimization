function [ M ] = MassMatrix( theta, param )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
phi=theta;

%param=[a0 a1 a2 Ro0 Ri0 Ro1 Ri1 Ro2 Ri2 rho Mmot1 Mmot2 Mgrip]
g=9.8; 
a=2; 

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

m0=rho*pi*(Ro0^2-Ri0^2)*a0; 
m1=rho*pi*(Ro1^2-Ri1^2)*a1; 
m2=rho*pi*(Ro2^2-Ri2^2)*a2;

IG0=1/2*m0*(Ro0^2+Ri0^2); 
IG1=1/12*m1*a1^2;
IG2=1/12*m2*a2^2; 

%2D with mass of motors and grippers added !!!Works well
% M= [m1 * a1 ^ 2 / 0.4e1 + Mmot2 * a1 ^ 2 + IG1 + m2 * (0.2e1 * a1 ^ 2 + a2 ^ 2 / 0.2e1 + 0.2e1 * a1 * a2 * cos(phi(2))) / 0.2e1 + Mgrip * (0.2e1 * a1 ^ 2 + 0.2e1 * a2 ^ 2 + 0.4e1 * a1 * a2 * cos(phi(2))) / 0.2e1 + IG2 m2 * (a2 ^ 2 / 0.2e1 + a1 * a2 * cos(phi(2))) / 0.2e1 + Mgrip * (0.2e1 * a2 ^ 2 + 0.2e1 * a1 * a2 * cos(phi(2))) / 0.2e1 + IG2; m2 * (a2 ^ 2 / 0.2e1 + a1 * a2 * cos(phi(2))) / 0.2e1 + Mgrip * (0.2e1 * a2 ^ 2 + 0.2e1 * a1 * a2 * cos(phi(2))) / 0.2e1 + IG2 m2 * a2 ^ 2 / 0.4e1 + Mgrip * a2 ^ 2 + IG2;];

%3D from derivation using jacobian 1 from jacobian
M = [m1 * cos(phi(1)) ^ 2 * a1 ^ 2 / 0.4e1 + IG0 + IG1 + m2 * cos(phi(1)) * cos(phi(1) + phi(2)) * a1 * a2 + m2 * cos(phi(1)) ^ 2 * a1 ^ 2 + m2 * cos(phi(1) + phi(2)) ^ 2 * a2 ^ 2 / 0.4e1 + Mgrip * cos(phi(1)) ^ 2 * a1 ^ 2 + Mmot2 * cos(phi(1)) ^ 2 * a1 ^ 2 + 0.2e1 * Mgrip * cos(phi(1)) * cos(phi(1) + phi(2)) * a1 * a2 + Mgrip * cos(phi(1) + phi(2)) ^ 2 * a2 ^ 2 + IG2 0 0; 0 Mgrip * a2 ^ 2 + m1 * a1 ^ 2 / 0.4e1 + Mgrip * a1 ^ 2 - IG1 * cos(phi(3)) ^ 2 + IG2 * cos(phi(3)) ^ 2 + Mmot2 * a1 ^ 2 + IG1 * cos(phi(3)) ^ 2 - IG2 * cos(phi(3)) ^ 2 + IG1 + IG2 + m2 * sin(phi(1)) * sin(phi(1) + phi(2)) * a1 * a2 + m2 * cos(phi(1)) * cos(phi(1) + phi(2)) * a1 * a2 + 0.2e1 * Mgrip * cos(phi(1)) * cos(phi(1) + phi(2)) * a1 * a2 + 0.2e1 * Mgrip * sin(phi(1)) * sin(phi(1) + phi(2)) * a1 * a2 + m2 * a1 ^ 2 + m2 * a2 ^ 2 / 0.4e1 IG2 + m2 * a2 ^ 2 / 0.4e1 + m2 * a1 ^ 2 + m2 * sin(phi(1)) * sin(phi(1) + phi(2)) * a1 * a2 + m2 * cos(phi(1)) * cos(phi(1) + phi(2)) * a1 * a2 + 0.2e1 * Mgrip * cos(phi(1)) * cos(phi(1) + phi(2)) * a1 * a2 + 0.2e1 * Mgrip * sin(phi(1)) * sin(phi(1) + phi(2)) * a1 * a2 + Mgrip * a2 ^ 2 - IG2 * cos(phi(3)) ^ 2 + Mgrip * a1 ^ 2 + IG2 * cos(phi(3)) ^ 2; 0 IG2 + m2 * a2 ^ 2 / 0.4e1 + m2 * a1 ^ 2 + m2 * sin(phi(1)) * sin(phi(1) + phi(2)) * a1 * a2 + m2 * cos(phi(1)) * cos(phi(1) + phi(2)) * a1 * a2 + 0.2e1 * Mgrip * cos(phi(1)) * cos(phi(1) + phi(2)) * a1 * a2 + 0.2e1 * Mgrip * sin(phi(1)) * sin(phi(1) + phi(2)) * a1 * a2 + Mgrip * a2 ^ 2 - IG2 * cos(phi(3)) ^ 2 + Mgrip * a1 ^ 2 + IG2 * cos(phi(3)) ^ 2 IG2 + m2 * a2 ^ 2 / 0.4e1 + m2 * a1 ^ 2 + m2 * sin(phi(1)) * sin(phi(1) + phi(2)) * a1 * a2 + m2 * cos(phi(1)) * cos(phi(1) + phi(2)) * a1 * a2 + 0.2e1 * Mgrip * cos(phi(1)) * cos(phi(1) + phi(2)) * a1 * a2 + 0.2e1 * Mgrip * sin(phi(1)) * sin(phi(1) + phi(2)) * a1 * a2 + Mgrip * a2 ^ 2 - IG2 * cos(phi(3)) ^ 2 + Mgrip * a1 ^ 2 + IG2 * cos(phi(3)) ^ 2;];

%3D from derivation using jacobian 2 from jacobian
% M=[Mgrip * a1 ^ 2 + Mgrip * a2 ^ 2 - IG1 * cos(phi(3)) ^ 2 - IG2 * cos(phi(3)) ^ 2 + IG1 * cos(phi(3)) ^ 2 + Mmot2 * a1 ^ 2 + m2 * a2 ^ 2 / 0.4e1 + m1 * a1 ^ 2 / 0.4e1 + m2 * a1 ^ 2 + IG2 * cos(phi(3)) ^ 2 + 0.2e1 * Mgrip * sin(phi(1)) * sin(phi(1) + phi(2)) * a1 * a2 + m2 * sin(phi(1)) * sin(phi(1) + phi(2)) * a1 * a2 + 0.2e1 * Mgrip * cos(phi(1)) * cos(phi(1) + phi(2)) * a1 * a2 + m2 * cos(phi(1)) * cos(phi(1) + phi(2)) * a1 * a2 + IG1 + IG2 IG2 + 0.2e1 * Mgrip * sin(phi(1)) * sin(phi(1) + phi(2)) * a1 * a2 + m2 * sin(phi(1)) * sin(phi(1) + phi(2)) * a1 * a2 + m2 * cos(phi(1)) * cos(phi(1) + phi(2)) * a1 * a2 + 0.2e1 * Mgrip * cos(phi(1)) * cos(phi(1) + phi(2)) * a1 * a2 - IG2 * cos(phi(3)) ^ 2 + Mgrip * a1 ^ 2 + Mgrip * a2 ^ 2 + m2 * a1 ^ 2 + m2 * a2 ^ 2 / 0.4e1 + IG2 * cos(phi(3)) ^ 2 0; IG2 + 0.2e1 * Mgrip * sin(phi(1)) * sin(phi(1) + phi(2)) * a1 * a2 + m2 * sin(phi(1)) * sin(phi(1) + phi(2)) * a1 * a2 + m2 * cos(phi(1)) * cos(phi(1) + phi(2)) * a1 * a2 + 0.2e1 * Mgrip * cos(phi(1)) * cos(phi(1) + phi(2)) * a1 * a2 - IG2 * cos(phi(3)) ^ 2 + Mgrip * a1 ^ 2 + Mgrip * a2 ^ 2 + m2 * a1 ^ 2 + m2 * a2 ^ 2 / 0.4e1 + IG2 * cos(phi(3)) ^ 2 IG2 + 0.2e1 * Mgrip * sin(phi(1)) * sin(phi(1) + phi(2)) * a1 * a2 + m2 * sin(phi(1)) * sin(phi(1) + phi(2)) * a1 * a2 + m2 * cos(phi(1)) * cos(phi(1) + phi(2)) * a1 * a2 + 0.2e1 * Mgrip * cos(phi(1)) * cos(phi(1) + phi(2)) * a1 * a2 - IG2 * cos(phi(3)) ^ 2 + Mgrip * a1 ^ 2 + Mgrip * a2 ^ 2 + m2 * a1 ^ 2 + m2 * a2 ^ 2 / 0.4e1 + IG2 * cos(phi(3)) ^ 2 0; 0 0 m1 * cos(phi(1)) ^ 2 * a1 ^ 2 / 0.4e1 + IG0 + IG1 + m2 * cos(phi(1)) ^ 2 * a1 ^ 2 + Mmot2 * cos(phi(1)) ^ 2 * a1 ^ 2 + Mgrip * cos(phi(1) + phi(2)) ^ 2 * a2 ^ 2 + Mgrip * cos(phi(1)) ^ 2 * a1 ^ 2 + m2 * cos(phi(1) + phi(2)) ^ 2 * a2 ^ 2 / 0.4e1 + 0.2e1 * Mgrip * cos(phi(1)) * cos(phi(1) + phi(2)) * a1 * a2 + m2 * cos(phi(1)) * cos(phi(1) + phi(2)) * a1 * a2 + IG2;];


%%
%2D from Jozsef's notes
% M=[m1*(a1/2)^2+IG1+m2*(a1^2+(a2/2)^2+2*a1*a2/2*cos(theta(2)))+IG2 m2*((a2/2)^2+a1*a2/2*cos(theta(2)))+IG2; m2*((a2/2)^2+a1*a2/2*cos(theta(2)))+IG2 m2*(a2/2)^2+IG2;];
% % 
J= Jacobian(theta,param);
% % 
[m,n]=size(J);
Minv=M\eye(m,n); 
% % 
% % % %%% (J*M^-1*J')^-1
Meff=(J*Minv*J')/eye(m,n);
M=Meff;
% % waitforbuttonpress
%  M=inv(J)'*M*inv(J);

end

