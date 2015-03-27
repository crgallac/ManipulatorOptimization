%optimization

function [x p]= params() 

a0=.1; 
a1=.1;
a2=.1;
d0=0; 
d=d0; 
Ro0=.010;
Ri0=.005;
Ro1=0.010; 
Ri1=.005; 
Ro2=.010;
Ri2=.005;
[failureStress, rho] =MaterialProperties(i) ; %aluminum 2.7 g/cm^3 [this will be a set] 
% Mmot1=.150;
% Mmot2=.050; 
Mgrip= .050; 
[Mmot1, f1]=MotorCharacterization(1);
[Mmot2, f2]=MotorCharacterization(1); 


param=[a0 a1 a2 Ro0 Ri0 Ro1 Ri1 Ro2 Ri2 rho Mmot1 Mmot2 Mgrip failureStress f1 f2];


