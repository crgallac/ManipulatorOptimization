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
fvalParam=fvalParam0;



rmax=0.025;


lb=[0 .01 0.01 .001 0 0.001 0 0.001 0];
ub=[.2 .15/2 .15/2 rmax rmax-rmax rmax rmax-rmax rmax rmax-rmax];

% r=ub/2; 

r1= 2; 
r2=2; 
r3=2; 



[failureStress, rho] =MaterialProperties(r1) ; %aluminum 2.7 g/cm^3 [this will be a set] 
[Mmot1, f1]=MotorCharacterization(r2);
[Mmot2, f2]=MotorCharacterization(r3); 

% s=4
% while (s<10)
%     for t=1:t0; 
    

param(1:9)=ub; 
param(10:16)= [rho Mmot1 Mmot2 .05 failureStress f1 f2];
        
% param(1,s)= t*1/t0*ub(1,s); 

% param=[a0 a1 a2 Ro0 Ri0 Ro1 Ri1 Ro2 Ri2 rho Mmot1 Mmot2 .05 failureStress f1 f2];


d=0;
d0=0;

a0=param(1); 
a1=param(2);
a2=param(3); 
Ro0=param(4);
Ri0=param(5);
Ro1=param(6);
Ri1=param(7);
Ro2=param(8);
Ri2=param(9);
% rho=param(10);
% Mmot1=param(11);
% Mmot2=param(12); 
% Mgrip=param(13); 
% failureStress= param(14); 
% f1=param(15);
% f2=param(16);



n=200; 

Lmax=1.05*(a0+a1+a2); 

distance=Lmax/n;

x=linspace(Lmax/n,Lmax+Lmax/n,n); 
y=linspace(Lmax/n,Lmax+Lmax/n,n);
z=linspace(Lmax/n,Lmax+Lmax/n,n); 



[X,Y,Z]=meshgrid(0,y,z); 

  


[m,n,o]=size(X); 

LogicMap=ones(m,n,o);

KAPPAD=nan(m,n,o);
KAPPAM=nan(m,n,o); 



for i=1:n
    for j=1:m
        for k=1:o
            
         D=(X(j,i,k)^2+Y(j,i,k)^2-d^2+(Z(j,i,k)-a0)^2-a1^2-a2^2)/(2*a1*a2);%cos(theta2)
    if(abs(D)<=1)
         [theta_up, theta_down]= InvKin1([X(j,i,k),Y(j,i,k),Z(j,i,k)], a0, a1, a2, d0);
   
 
         
  % %Kinematic Manipulability and Dynamic Manipulability for given point
         
         
         %since trying to minimize the dynamic manipulability we take the
         %largest value at any given location
                  
        %since trying to maximize the kinematic manipulability we take the
        %smallest value for KappaM at a given location in the workspace
           
       
        %returns the jacobian for the up configuration
        J_up= Jacobian(theta_up, param);
        KappaM_up=KinematicManip(J_up); 
        
        %returns the mass matrix for up configuration
         M_up=MassMatrix(theta_up,param);

%          KappaD_up=KappaM_up/abs(det(M_up));
            KappaD_up=DynamicManip(M_up); 
%             KappaD_up=KappaM_up/KappaD_up;
        
        %returns the jacobian for the down configuration
        J_down= Jacobian(theta_down, param);
        KappaM_down=KinematicManip(J_down); 
        
        %returns the mass matrix for down configuration
         M_down=MassMatrix(theta_down,param);
      
%          KappaD_down=KappaM_down/abs(det(M_down)); 
          KappaD_down=DynamicManip(M_down); 
%          KappaD_down=KappaM_up/KappaD_down;

         if(KappaM_up<KappaM_down) KappaM=KappaM_up; 
         else KappaM=KappaM_down;
         end
         
          if(KappaD_up>KappaD_down) KappaD=KappaD_up; 
         else KappaD=KappaD_down;
         end
        
            KAPPAM(j,i,k)=KappaM;      
            KAPPAD(j,i,k)=KappaD; 
            
           
            
%          %% Draws the manipulator configuration
%          hold off
%           ForKin([X(j,i,k),Y(j,i,k),Z(j,i,k)],theta_up, a0, a1, a2, d0, 1); 
%          hold on
%           ForKin([X(j,i,k),Y(j,i,k),Z(j,i,k)],theta_down, a0, a1, a2, d0, 0); 
%           pause(.01); 
% % %      waitforbuttonpress
% %%
    else
   
      LogicMap(j,i,k)=0; 
    
    end
        end
    end
end


X1=squeeze(X); Y1=squeeze(Y); Z1=squeeze(Z); LogicMap1=squeeze(LogicMap); KAPPAM1=squeeze(KAPPAM);  KAPPAD1=squeeze(KAPPAD); 

%%Plot Workspace
%  h=slice(X1,Y1,Z1,LogicMap1, x,y,z) %3D representation if not planar
%  h=contourf(Y1,Z1,LogicMap1) %2D representation if check is only done in
%  plane
%  set(h,'EdgeColor','none','LineStyle','none');
%  colormap hsv
%  set(h, 'gridlines', 'off'); 
%% Cost Function Processing

volume= Volume( LogicMap1 , distance);
len= Length(param);
GDMI= log(GlobalDynManInd(KAPPAD1, volume));
GKMI= log(GlobalKinManInd(KAPPAM1, volume)) ;
totalMass=netMass(param); 

mi=min(min(KAPPAD1));
mi1=max(max(KAPPAM1)); 

% colormap threshold 
sf=3; 

KAPPAD1(KAPPAD1>sf*mi)=sf*mi; 
KAPPAD1(KAPPAM1<mi1/sf)=mi1/sf; 
% 
contourf(Y1,Z1,KAPPAD1);
figure
contourf(Y1,Z1,KAPPAM1);
%

% fval=-volume+len+GDMI-GKMI; 
% fval=-volume/0.76+len/0.78+GDMI/18681381;
fvalParam0(t,s)=-volume/0.0057;
fvalParam1(t,s)=len/.47;
fvalParam2(t,s)=GDMI/14.03;
fvalParam3(t,s)=totalMass/1.21;
fvalParam4(t,s)=-GKMI/18.02;


% +len/0.776+GDMI/48017576+totalMass/0.94;%-GKMI/20297.16


% 
%     end
%     s=s+2; 
% end

% 
% fvalParam=fvalParam0+fvalParam1+fvalParam2+fvalParam3+fvalParam4; 
% figure
% plot(xaxis,fvalParam0(:,4),'r', xaxis,fvalParam0(:,6),'b', xaxis, fvalParam0(:,8),'g')
% figure
% plot(xaxis,fvalParam1(:,4),'r', xaxis,fvalParam1(:,6),'b', xaxis, fvalParam1(:,8),'g')
% figure
% plot(xaxis,fvalParam2(:,4),'r', xaxis,fvalParam2(:,6),'b', xaxis, fvalParam2(:,8),'g')
% figure
% plot(xaxis,fvalParam3(:,4),'r', xaxis,fvalParam3(:,6),'b', xaxis, fvalParam3(:,8),'g')
% figure
% plot(xaxis,fvalParam4(:,4),'r', xaxis,fvalParam4(:,6),'b', xaxis, fvalParam4(:,8),'g')
% figure
% plot(xaxis,fvalParam(:,4),'r', xaxis,fvalParam(:,6),'b', xaxis, fvalParam(:,8),'g')
