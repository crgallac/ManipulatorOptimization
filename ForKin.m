function ForKin( pos, theta, a0, a1, a2, d0 )
%FORKIN Summary of this function goes here
%   Detailed explanation goes here

Xo=0;
Yo=0;
Zo=a0; 
theta(3)=theta(3); 
X1=-sin(theta(3))*(a1*cos(theta(1)));
Y1=cos(theta(3))*(a1*cos(theta(1))); 
Z1=a0+a1*sin(theta(1)); 


Xe= -sin(theta(3))*(a1*cos(theta(1))+a2*cos(theta(1)+theta(2))); 
Ye= cos(theta(3))*(a1*cos(theta(1))+a2*cos(theta(1)+theta(2))); 
Ze= a0+a1*sin(theta(1))+a2*sin(theta(1)+theta(2));


ManipX=[0 Xo X1 Xe]; 
ManipY=[0 Yo Y1 Ye]; 
ManipZ=[0 Zo Z1 Ze]; 

hold off
h=plot3(ManipX,ManipY,ManipZ,'r--o', Xe,Ye,Ze,'b--x', pos(1), pos(2), pos(3), 'g--+'); 
hold on
plot3( 0, 0, 0, 'k^','MarkerFaceColor',[.49 1 .63],'MarkerSize',10)
daspect([1 1 1]);
axis('square')
axis([0 30 0 30 0 30])
grid on
end

