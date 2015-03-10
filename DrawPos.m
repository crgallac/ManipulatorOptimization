pos=[0 0 20]; 
a0=10; 
a1=10;
a2=10;
d0=0; 

[theta_up, theta_down]= InvKin1(pos, a0, a1, a2, d0); 
close all
ForKin(pos,theta_up, a0, a1, a2, d0, 1); 
ForKin(pos,theta_down, a0, a1, a2, d0, 0); 



