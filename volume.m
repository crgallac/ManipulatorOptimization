a0=10; 
a1=10;
a2=10;
d0=0; 
d=d0; 
%%
% pos=[0 6 1]; 
% % 
%          [theta_up, theta_down]= InvKin1(pos, a0, a1, a2, d0);
%         hold off
%           ForKin(pos,theta_up, a0, a1, a2, d0, 1); 
%          hold on
%           ForKin(pos,theta_down, a0, a1, a2, d0, 0); 

%%
n=32; 

x=linspace(0,35,n); 
y=linspace(0,35,n);
z=linspace(0,35,n); 

[X,Y,Z]=meshgrid(x,y,z); 

  


[m,n,o]=size(X); 

LogicMap=ones(m,n,o);


for i=1:n
    for j=1:m
        for k=1:o
            
         D=(X(j,i,k)^2+Y(j,i,k)^2-d^2+(Z(j,i,k)-a0)^2-a1^2-a2^2)/(2*a1*a2);%cos(theta2)
    if(abs(D)<=1)
         [theta_up, theta_down]= InvKin1([X(j,i,k),Y(j,i,k),Z(j,i,k)], a0, a1, a2, d0);
        
         
         %% Draws the manipulator configuration
%          hold off
%           ForKin([X(j,i,k),Y(j,i,k),Z(j,i,k)],theta_up, a0, a1, a2, d0, 1); 
%          hold on
%           ForKin([X(j,i,k),Y(j,i,k),Z(j,i,k)],theta_down, a0, a1, a2, d0, 0); 
% %           pause(.01)
% % %      waitforbuttonpress
%%
    else
 
      LogicMap(j,i,k)=0; 
    
    end
        end
    end
end


X1=squeeze(X); Y1=squeeze(Y); Z1=squeeze(Z); LogicMap1=squeeze(LogicMap); 
 h=slice(X1,Y1,Z1,LogicMap1, x,y,z)
 set(h,'EdgeColor','none','LineStyle','none');
%  colormap hsv
%  set(h, 'gridlines', 'off'); 