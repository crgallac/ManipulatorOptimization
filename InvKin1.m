function [Phi_est]=InvKin1(E,a0,a1,a2,d0)

d=d0;

Phi_est(1:3)= calculatePhi(E); 


% 
% phi1_est=Phi_est(1:3); 


function phi= calculatePhi(S)

pos=[S(1) S(2) S(3)];

D=(pos(1)^2+pos(2)^2-d^2+(pos(3)-a0)^2-a1^2-a2^2)/(2*a1*a2)%cos(theta2)

if(abs(D)<=1)

theta3=pi+pi/2+atan2(pos(2),pos(1))

% sqrt(1-D^2)%sin(theta2)

theta2_1=atan(sqrt(1-D^2)/D)%elbow up
theta2_2=atan(-sqrt(1-D^2)/D)%elbow down

theta2=theta2_2; 

theta1=atan((pos(3)-a0)/(sqrt(pos(1)^2+pos(2)^2-d^2)))-atan(a2*sin(theta2)/(a1+a2*cos(theta2))); 

phi=[theta1,theta2,theta3]; 

else
   
    phi=[nan, nan, nan]; 
    
end

end



end