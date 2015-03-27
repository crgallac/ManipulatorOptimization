function [ nonLinConIneq, nonLinConEq ] = NonLinearConstraints( paramVars, param1 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

param=[paramVars, param1];

%param=[a0 a1 a2 Ro0 Ri0 Ro1 Ri1 Ro2 Ri2 rho Mmot1 Mmot2 Mgrip]
g=9.8; 
a=2; 
sf=1/2; 

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

% m0=rho*pi*(Ro^2-Ri^2)*a0; 
m1=rho*pi*(Ro1^2-Ri1^2)*a1; 
m2=rho*pi*(Ro2^2-Ri2^2)*a2;



V1max=-(m1+m2+Mmot2+Mgrip)*(g+a);
M1max=-((m1/2+Mmot2)*a1+m2*(a1+a2/2)+Mgrip*(a1+a2))*(g+a); 

V2max=-(m2+Mgrip)*(a+g);
M2max=-(m2/2+Mgrip)*(a+g)*a2; 

s0=SigmaMax(M1max,Ro0,Ri0);
s1=SigmaMax(M1max,Ro1,Ri1);
s2=SigmaMax(M2max, Ro2,Ri2);

t1=TauMax(V1max,Ro1,Ri1);
t2=TauMax(V2max,Ro2,Ri2);


nonLinConIneqStresses=[s0 s1 s2 t1 t2]; %stresses 
nonLinConIneqTorques=[M1max M2max]; %torques

failureStress;
f1;
f2;

nonLinConIneqStresses=abs(nonLinConIneqStresses)-sf*failureStress;
nonLinConIneqTorques=abs(nonLinConIneqTorques)-[f1 f2];

nonLinConIneq= [nonLinConIneqStresses, nonLinConIneqTorques];
nonLinConEq=[]; 

%constraint 1

% waitforbuttonpress

end

   function [sigma]= SigmaMax(M, Ro, Ri)
        
        Z=0.785*(Ro^4-Ri^4)/Ro;
       sigma=M/Z; 
        
   end
    
   
    function [tau]= TauMax(V, Ro, Ri)
        
        A=pi*(Ro^2-Ri^2);
       tau=2*V/A; 
        
    end
