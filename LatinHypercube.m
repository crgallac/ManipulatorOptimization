%Latin Hypercupe

a0=.05; 
a1=.015;
a2=.05;
d0=0; 
d=d0; 
Ro0=.01;
Ri0=0.005;
Ro1=0.01; 
Ri1=0.005; 
Ro2=.01;
Ri2=0.005;
[failureStress, rho] =MaterialProperties(1) ; %aluminum 2.7 g/cm^3 [this will be a set] 
% Mmot1=.150;
% Mmot2=.050; 
Mgrip= .050; 
[Mmot1, f1]=MotorCharacterization(1);
[Mmot2, f2]=MotorCharacterization(1); 



% size(A)
lb=[0 .05 0.05 0 0 0 0 0 0];
ub=[.4 .2 .2 rmax rmax rmax rmax rmax rmax]; 


param=[a0 a1 a2 Ro0 Ri0 Ro1 Ri1 Ro2 Ri2 rho Mmot1 Mmot2 Mgrip failureStress f1 f2];
volume=zeros([1,1000]); 
len=volume;
GDMI=volume;
GKMI=volume;
totalMass=volume; 

for i=1:1000

r=rand([1,9]).*ub; 
 %ensures the physical reality of the system. 
for j=1:9
   if (r(j)<lb(j) || r(j)<0)
       r(j)=lb(j);
       
   end
   
   %ensures the physical reality of the system. 
   if(r(4)<r(5))
      r(5)=r(4)+rmax/10;
   end
     if(r(6)<r(7))
      r(6)=r(7)+rmax/10;
     end 
    if(r(8)<r(9))
      r(8)=r(9)+rmax/10;
   end 
   
   
end

r1= randi(3,1); 
r2=randi(2,1); 
r3=randi(2,1); 


[failureStress, rho] =MaterialProperties(r1) ; %aluminum 2.7 g/cm^3 [this will be a set] 
[Mmot1, f1]=MotorCharacterization(r2);
[Mmot2, f2]=MotorCharacterization(r3); 

param(1:9)=r; 
param(10:16)= [rho Mmot1 Mmot2 Mgrip failureStress f1 f2];
        
        x=param(1:9);
        p=[rho Mmot1 Mmot2 Mgrip failureStress f1 f2]; 
        
   [volume(i), len(i), GDMI(i), GKMI(i), totalMass(i)]=objFun2(x,p); 
  
  
   
   
end
       
