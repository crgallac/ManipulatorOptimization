function [Phi_up, Phi_down]=InvKin1(E,a0,a1,a2,d0)

d=d0;

[Phi_up, Phi_down]= calculatePhi(E);


% 
% phi1_est=Phi_est(1:3); 


function [phi_up, phi_down]= calculatePhi(S)

pos=[S(1) S(2) S(3)];
% 
D=(pos(1)^2+pos(2)^2-d^2+(pos(3)-a0)^2-a1^2-a2^2)/(2*a1*a2);%cos(theta2)

% if(abs(D)<=1)

theta3=pi+pi/2+atan2(pos(2),pos(1));

% sqrt(1-D^2)%sin(theta2)

theta2_1=atan2(sqrt(1-D^2),D);%elbow up
theta2_2=atan2(-sqrt(1-D^2),D);%elbow down

theta2=theta2_1; 

theta1_1=atan((pos(3)-a0)/(sqrt(pos(1)^2+pos(2)^2-d^2)))-atan(a2*sin(theta2)/(a1+a2*cos(theta2))); 

theta2=theta2_2; 
theta1_2=atan((pos(3)-a0)/(sqrt(pos(1)^2+pos(2)^2-d^2)))-atan(a2*sin(theta2)/(a1+a2*cos(theta2))); 

phi_up=[theta1_1,theta2_1,theta3]; 
phi_down=[theta1_2,theta2_2,theta3]; 


% else
%    
%     phi_up=[nan, nan, nan]; 
%      phi_down=[nan, nan, nan]; 
% end

end



end