%optimization



a0=0.3; 
a1=.1;
a2=.18;
d0=0; 
d=d0; 
Ro0=.018;
Ri0=0.016;
Ro1=0.02; 
Ri1=0.015; 
Ro2=.015;
Ri2=0.01;
[failureStress, rho] =MaterialProperties(1) ; %aluminum 2.7 g/cm^3 [this will be a set] 
% Mmot1=.150;
% Mmot2=.050; 
Mgrip= .010; 
[Mmot1, f1]=MotorCharacterization(1);
[Mmot2, f2]=MotorCharacterization(1); 

A=[ 0 0 0 -1 1 0 0 0 0; 0 0 0 0 0 -1 1 0 0;  0 0 0 0 0 0 0 -1 1;]; 

num=7*4*4; 
xval=zeros([num, 9]); 
fvalue=zeros([num, 1]); 
configuration=zeros([num,3]); 
% size(A)



rmax=0.03;
t=.002; 

b= -t*[1;1;1]; 

lb=[0 0.1 0.1 .01 0 0.01 0 0.01 0];
ub=[.3 .2 .2 rmax rmax rmax rmax rmax rmax]; 


%for different guesses

% r=rand([1,9]).*ub; 

% r1= randi(3,1); 
% r2=randi(2,1); 
% r3=randi(2,1); 

% [failureStress, rho] =MaterialProperties(r1) ; %aluminum 2.7 g/cm^3 [this will be a set] 
% [Mmot1, f1]=MotorCharacterization(r2);
% [Mmot2, f2]=MotorCharacterization(r3); 

% param(1:9)=r; 
% param(10:16)= [rho Mmot1 Mmot2 Mgrip failureStress f1 f2];
%         



n=1; 
fval_old=inf; 
for i=1
   for j=1
       for k=2
        
           
% i=1;
% j=1;
% k=2; 
% %            assign values to the parameters
       [failureStress, rho] =MaterialProperties(i) ; %aluminum 2.7 g/cm^3 [this will be a set] 
       [Mmot1, f1]=MotorCharacterization(j);
        [Mmot2, f2]=MotorCharacterization(k);
       
        param=[a0 a1 a2 Ro0 Ri0 Ro1 Ri1 Ro2 Ri2 rho Mmot1 Mmot2 Mgrip failureStress f1 f2];
%         x0=param(1:9);
x0=param(1:9); 
        p=[rho Mmot1 Mmot2 Mgrip failureStress f1 f2];
        
        f=@(x)objFun(x,p); 
        nlCon=@(x)NonLinearConstraints(x,p);
         
        
        
       options = optimoptions('fmincon','Algorithm','sqp','Display', 'iter', 'MaxFunEvals', 3000, 'MaxIter', 1000,'PlotFcns', @optimplotx,'DiffMinChange', .00001, 'TolFun', 1e-3, 'TolCon', 1e-3,'TolX', 1e-3) ;
        [x,fval, exitflag, output, lambda] = fmincon(f,x0,A,b,[],[],lb,ub,nlCon, options );  %'active-set' 'interior-point'
%                 [x,fval]= fmincon(f,x0,[],[],[],[],lb,[],[], options );  

oput{n}={x,fval,exitflag,output,lambda}; 

xval(i,:)=x; 
fvalue(i,1)=fval; 
configuration(i,:)=[i,j,k]; 

% type(output)
size(output)
% type(lambda)
size(lambda)

if(fval<fval_old && oput{n}{3}==2)
    
    fval_old=fval;
    config=[i,j,k]; 
end

n=n+1; 
       end
   end   
end