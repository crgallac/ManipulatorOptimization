%Latin Hypercupe

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
[failureStress, rho] =MaterialProperties(1) ; %aluminum 2.7 g/cm^3 [this will be a set] 
% Mmot1=.150;
% Mmot2=.050; 
Mgrip= .20; 
[Mmot1, f1]=MotorCharacterization(1);
[Mmot2, f2]=MotorCharacterization(1); 


% size(A)
lb=[0 .01 .01 .001 0 0.001 0 0.001 0];
ub=[1 1 1 .05 .049 .05 .049 .05 .049]; 


param=[a0 a1 a2 Ro0 Ri0 Ro1 Ri1 Ro2 Ri2 rho Mmot1 Mmot2 Mgrip failureStress f1 f2];
volume=zeros([1,1000]); 
len=volume;
GDMI=volume;
GKMI=volume;
totalMass=volume; 

for i=1:1000

r=rand([1,9]).*ub; 
if(r(2)==0)
    r(2)=.00001; 
end 
if(r(3)==0)
    r(3)=.00001; 
end

r1= randi(7,1); 
r2=randi(4,1); 
r3=randi(4,1); 


[failureStress, rho] =MaterialProperties(r1) ; %aluminum 2.7 g/cm^3 [this will be a set] 
[Mmot1, f1]=MotorCharacterization(r2);
[Mmot2, f2]=MotorCharacterization(r3); 

param(1:9)=r; 
param(10:16)= [rho Mmot1 Mmot2 Mgrip failureStress f1 f2];
        
        x=param(1:9);
        p=[rho Mmot1 Mmot2 Mgrip failureStress f1 f2]; 
        
   [volume(i), len(i), GDMI(i), GKMI(i), totalMass(i)]=objFun2(x,p); 
  
  
   
end
       
