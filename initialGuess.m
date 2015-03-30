%optimization



% a0=0; 
% a1=.1;
% a2=.1;
% d0=0; 
% d=d0; 
% Ro0=.005;
% Ri0=0.001;
% Ro1=0.005; 
% Ri1=0.001; 
% Ro2=.005;
% Ri2=0.001;
% [failureStress, rho] =MaterialProperties(1) ; %aluminum 2.7 g/cm^3 [this will be a set] 
% % Mmot1=.150;
% % Mmot2=.050; 
% Mgrip= .050; 
% [Mmot1, f1]=MotorCharacterization(1);
% [Mmot2, f2]=MotorCharacterization(1); 

A=[ 0 0 0 -1 1 0 0 0 0; 0 0 0 0 0 -1 1 0 0;  0 0 0 0 0 0 0 -1 1;]; 

num=7*4*4; 
xval=zeros([num, 9]); 
fvalue=zeros([num, 1]); 
configuration=zeros([num,3]); 
% size(A)

b= [0;0;0]; 

rmax=0.025;


lb=[0 .01 0.01 .001 0 0.001 0 0.001 0];
ub=[.4 .2 .2 rmax rmax rmax rmax rmax rmax]; 
iguess=[.2 .1 .15 rmax rmax-.01 rmax rmax-.01 rmax rmax-.01]; 

r=rand([1,9]).*ub; 

r1= randi(3,1); 
r2=randi(2,1); 
r3=randi(2,1); 

[failureStress, rho] =MaterialProperties(r1) ; %aluminum 2.7 g/cm^3 [this will be a set] 
[Mmot1, f1]=MotorCharacterization(r2);
[Mmot2, f2]=MotorCharacterization(r3); 

param(1:9)=iguess; 
param(10:16)= [rho Mmot1 Mmot2 Mgrip failureStress f1 f2];
        

% param=[a0 a1 a2 Ro0 Ri0 Ro1 Ri1 Ro2 Ri2 rho Mmot1 Mmot2 Mgrip failureStress f1 f2];


fval_old=inf; 
% for i=1:3 
%    for j=1:2
%        for k=1:2
           
i=3;
j=1;
k=1; 
           %assign values to the parameters
       [failureStress, rho] =MaterialProperties(i) ; %aluminum 2.7 g/cm^3 [this will be a set] 
       [Mmot1, f1]=MotorCharacterization(j);
        [Mmot2, f2]=MotorCharacterization(k); 
       
        
        x0=param(1:9);
        p=[rho Mmot1 Mmot2 Mgrip failureStress f1 f2]; 
        
        f=@(x)objFun(x,p); 
        nlCon=@(x)NonLinearConstraints(x,p); 
         
        
        
        
       options = optimoptions('fmincon','Algorithm','sqp','Display', 'iter', 'MaxFunEvals', 3000, 'MaxIter', 1000,'PlotFcns', @optimplotx, 'TypicalX', [.1 .1 .1 .05 .01 .05 .01 .05 .01],'DiffMinChange', .00001,'TolFun', 1e-3,'TolX', 1e-3);% 'TolFun', 1e-3, 'TolX', 1e-3 
        [x,fval]= fmincon(f,x0,A,b,[],[],lb,ub,[], options );  %'active-set' 'interior-point'
%                 [x,fval]= fmincon(f,x0,[],[],[],[],lb,[],[], options );  
