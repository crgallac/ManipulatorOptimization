function [volume, len, GDMI, GKMI, totalMass]= objFun2(paramVars, param1)

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

param=[paramVars, param1];
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
rho=param(10);
Mmot1=param(11);
Mmot2=param(12); 
Mgrip=param(13); 
failureStress= param(14); 
f1=param(15);
f2=param(16);

n=30; 
Lmax=1.05*(a0+a1+a2); 

x=linspace(Lmax/n,Lmax+Lmax/n,n); 
y=linspace(Lmax/n,Lmax+Lmax/n,n);
z=linspace(Lmax/n,Lmax+Lmax/n,n); 

distance=x(2)-x(1); 

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

%colormap threshold 
sf=3; 

% KAPPAD1(KAPPAD1>sf*mi)=sf*mi; 
% KAPPAD1(KAPPAM1<mi1/sf)=mi1/sf; 
% % 
% contourf(Y1,Z1,KAPPAD1);
% waitforbuttonpress
% contourf(Y1,Z1,KAPPAM1);
%%

% fval=-volume+len+GDMI-GKMI; 
% fval=-volume+ len;
% fval=-volume+len+GDMI-GKMI; 
