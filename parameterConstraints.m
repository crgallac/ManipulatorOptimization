%parameter study

%%
% pos=[0 .15 .05]; 
% % 
%          [theta_up, theta_down]= InvKin1(pos, a0, a1, a2, d0);
%         hold off
%           ForKin(pos,theta_up, a0, a1, a2, d0, 1); 
%          hold on
%           ForKin(pos,theta_down, a0, a1, a2, d-2, 0); 
% waitforbuttonpress
%

s0=3;
t0=50;

xaxis=linspace(0,1,t0);

fvalParam0=zeros([t0,s0]);
fvalParam1=fvalParam0;
fvalParam2=fvalParam0;
fvalParam3=fvalParam0;
fvalParam4=fvalParam0;
fvalParam5=fvalParam0;
fvalParam6=fvalParam0;



rmax=0.025;


lb=[0 .01 0.01 .001 0 0.001 0 0.001 0];
ub=[.4 .2 .2 rmax rmax-rmax/10 rmax rmax-rmax/10 rmax rmax-rmax/10];

r=ub/2; 

r1= 2; 
r2=2; 
r3=2; 



[failureStress, rho] =MaterialProperties(r1) ; %aluminum 2.7 g/cm^3 [this will be a set] 
[Mmot1, f1]=MotorCharacterization(r2);
[Mmot2, f2]=MotorCharacterization(r3); 

s=5; 
while (s<10)
    
    for t=1:t0; 
    

param(1:9)=ub; 
param(10:16)= [rho Mmot1 Mmot2 .05 failureStress f1 f2];
        
param(1,s)= t*1/t0*ub(1,s);

% waitforbuttonpress

% param=[a0 a1 a2 Ro0 Ri0 Ro1 Ri1 Ro2 Ri2 rho Mmot1 Mmot2 .05 failureStress f1 f2];


d=0;
d0=0;


[nonLinConIneq, nonLinConeq]= NonLinearConstraints(param(1:9),param(10:16));
% waitforbuttonpress

fvalParam0(t,s)= nonLinConIneq(1);
% waitforbuttonpress
fvalParam1(t,s)=nonLinConIneq(2); 
fvalParam2(t,s)=nonLinConIneq(3); 
fvalParam3(t,s)=nonLinConIneq(4); 
fvalParam4(t,s)=nonLinConIneq(5); 
fvalParam5(t,s)=nonLinConIneq(6); 
fvalParam6(t,s)=nonLinConIneq(7); 


% +len/0.776+GDMI/48017576+totalMass/0.94;%-GKMI/20297.16



    end
    s=s+2; 
end

figure
% fvalParam=fvalParam0+fvalParam1+fvalParam2+fvalParam3+fvalParam4; 
subplot(1,3,1)
plot(xaxis,fvalParam0(:,5),'r', xaxis,fvalParam0(:,7),'b', xaxis, fvalParam0(:,9),'g')
subplot(1,3,2)
plot(xaxis,fvalParam1(:,5),'r', xaxis,fvalParam1(:,7),'b', xaxis, fvalParam1(:,9),'g')
subplot(1,3,3)
plot(xaxis,fvalParam2(:,5),'r', xaxis,fvalParam2(:,7),'b', xaxis, fvalParam2(:,9),'g')

figure
subplot(1,2,1)
plot(xaxis,fvalParam3(:,5),'r', xaxis,fvalParam3(:,7),'b', xaxis, fvalParam3(:,9),'g')
subplot(1,2,2)
plot(xaxis,fvalParam4(:,5),'r', xaxis,fvalParam4(:,7),'b', xaxis, fvalParam4(:,9),'g')

figure
subplot(1,2,1)
plot(xaxis,fvalParam5(:,5),'r', xaxis,fvalParam5(:,7),'b', xaxis, fvalParam5(:,9),'g')
subplot(1,2,2)
plot(xaxis,fvalParam6(:,5),'r', xaxis,fvalParam6(:,7),'b', xaxis, fvalParam6(:,9),'g')

% figure
% 
% plot(xaxis,fvalParam0(:,2))
