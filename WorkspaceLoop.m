
a0=.09; 
a1=.179;
a2=.18;
d0=0; 
d=d0; 
Ro0=.0117;
Ri0=.0067;
Ro1=0.025; 
Ri1=.001; 
Ro2=.023;
Ri2=.0046;
[failureStress, rho] =MaterialProperties(1) ; %aluminum 2.7 g/cm^3 [this will be a set] 
% Mmot1=.150;
% Mmot2=.050; 
Mgrip= .050; 
[Mmot1, f1]=MotorCharacterization(1);
[Mmot2, f2]=MotorCharacterization(4); 



param=[a0 a1 a2 Ro0 Ri0 Ro1 Ri1 Ro2 Ri2 rho Mmot1 Mmot2 Mgrip failureStress f1 f2];

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

Lmax=1.05*(a0+a1+a2); 
n=ceil(100*Lmax); 
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
         hold off
          ForKin([X(j,i,k),Y(j,i,k),Z(j,i,k)],theta_up, a0, a1, a2, d0, 1); 
         hold on
          ForKin([X(j,i,k),Y(j,i,k),Z(j,i,k)],theta_down, a0, a1, a2, d0, 0); 
          pause(.01); 
     waitforbuttonpress
%%
    else
   
      LogicMap(j,i,k)=0; 
    
    end
        end
    end
end


X1=squeeze(X); Y1=squeeze(Y); Z1=squeeze(Z); LogicMap1=squeeze(LogicMap); KAPPAM1=squeeze(KAPPAM);  KAPPAD1=squeeze(KAPPAD); 

% %%Plot Workspace
% %  h=slice(X1,Y1,Z1,LogicMap1, x,y,z) %3D representation if not planar
% %  h=contourf(Y1,Z1,LogicMap1) %2D representation if check is only done in
% %  plane
% %  set(h,'EdgeColor','none','LineStyle','none');
% %  colormap hsv
% %  set(h, 'gridlines', 'off'); 
%% Cost Function Processing

volume= Volume( LogicMap1, distance );
len= Length(param);
GDMI= GlobalDynManInd(KAPPAD1, volume);
GKMI= GlobalKinManInd(KAPPAM1, volume) ;

mi=min(min(KAPPAD1));
mi1=max(max(KAPPAM1)); 

%colormap threshold 
sf=3; 

KAPPAD1(KAPPAD1>sf*mi)=sf*mi; 
KAPPAD1(KAPPAM1<mi1/sf)=mi1/sf; 

contourf(Y1,Z1,KAPPAD1);
waitforbuttonpress
contourf(Y1,Z1,KAPPAM1);
%

f=volume/20027+len/0.1732+GDMI/28.76+GKMI/0.484; 
