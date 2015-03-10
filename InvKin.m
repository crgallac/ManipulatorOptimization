function [Phi_est]=InvKin1(E,a0,a1,a2,d0)


% handle= 50.6; 

% E1= E'+[0 0 handle/2];
% E2= E'-[0 0 handle/2];
% E1'
% E2'

% Rot= [1 0 0; 0 0 1; 0 -1 0;]; 




% FwdKin_Eq1=@(phi_u)[cos(phi_u(3)) * (l1 * cos(phi_u(1)) - l2 * cos(phi_u(1) + phi_u(2)) + d1) - sin(phi_u(3)) * d4-E1(1);    l1 * sin(phi_u(1)) - l2 * sin(phi_u(1) + phi_u(2)) - d2-E1(2);  d3/2-sin(phi_u(3)) * (l1 * cos(phi_u(1)) - l2 * cos(phi_u(1) + phi_u(2)) + d1) - cos(phi_u(3)) * d4-E1(3);];
% FwdKin_Eq2=@(phi_l)[cos(phi_l(3)) * (l1 * cos(phi_l(1)) - l2 * cos(phi_l(1) + phi_l(2)) + d1) + sin(phi_l(3)) * d4-E2(1);
%     l1 * sin(phi_l(1)) - l2 * sin(phi_l(1) + phi_l(2)) - d2-E2(2);
%     -d3/2 - sin(phi_l(3)) * (l1 * cos(phi_l(1)) - l2 * cos(phi_l(1) + phi_l(2)) + d1) + cos(phi_l(3)) * d4-E2(3); ];
% 
% %   options = optimoptions('fsolve','Display','iter'); % Option to display output
% 
% [phi1_est fsol]=fsolve(FwdKin_Eq1,[0;3*pi/2;0],optimset('Display','off')); %optimset('Display','off')
% phi2_est=fsolve(FwdKin_Eq2,[0;3*pi/2;0],optimset('Display','off'));
% 
% Phi_est=[phi1_est;phi2_est];


% 
% E1=Rot*E1';
% E2=Rot*E2';


Phi_est(1:3)= calculatePhi(E,0); 

% Phi_est(4:6)= calculatePhi(E2,1); 


phi1_est=Phi_est(1:3); 
% phi2_est=Phi_est(4:6); 



% if (phi1_est(1) < 0.0365) || (phi1_est(1) > 2.2992) || (phi1_est(2) < -5.865) || (phi1_est(2) > -3.8031) || (phi1_est(3) < -0.8685) || (phi1_est(3) > 0.9000) || (phi2_est(1) < 0.0559) || (phi2_est(1) > 2.3252) || (phi2_est(2) < -5.839) || (phi2_est(2) > -3.7822) || (phi2_est(3) < -0.8205) || (phi2_est(3) > 0.9451)
% if (phi1_est(1) < -1.6039) || (phi1_est(1) > 0.6588)
%     Phi_est(1) = nan;
% elseif (phi1_est(2) < 3.555) || (phi1_est(2) > 5.6169)
%     Phi_est(2) = nan;
% elseif (phi1_est(3) < -0.8685) || (phi1_est(3) > 0.9000)
%     Phi_est(3) = nan;
% end

% Phi_est=Phi_est.*180/3.14; 



function phi= calculatePhi(S,a)


%Parameters in the inverse kinematics vs forward correspond to d1 -> d1,
%... d2-> d2, d3-> 2*d0, d4 -> d3, 

d1=0;
d2=a0;%*1e-3;
d3=0;%*1e-3; 
d4= d0;%*1e-3; 

l1=a1;%*1e-3;
l2=a2;%*1e-3; 

E1=S;

if (a)
    d3=-d3;
    d4=-d4; 
end
    

% E1(2)-d3/2
if(E1(1)>0 && E1(1)^2+(E1(2)-d3/2)^2-d4^2 >0)
th13=-(atan2((E1(2)-d3/2),E1(1)) + atan2(d4,sqrt(E1(1)^2+(E1(2)-d3/2)^2-d4^2)));


c12= (E1(1)^2+(E1(2)-d3/2)^2-d4^2+(d2-E1(3))^2-l1^2-l2^2)/(2*l1*l2);

if (abs(c12)<=1)
th12=atan2(sqrt(1-c12^2),c12)+pi;

if (E1(1)^2+(E1(2)-d3/2)^2-d4^2 > 0 && l1+l2*c12 >0 )
th11= atan2((d2-E1(3)),sqrt(E1(1)^2+(E1(2)-d3/2)^2-d4^2)) - atan2(l2*sqrt(1-c12^2), l1+l2*c12); 

else 
    th11=nan; 
    th12=nan;
    th13=nan; 
end


else 
    th12=nan;
    th13=nan; 
    th11=nan; 
%th11=atan2(sin(th12), (l1/l2)-c12); 
end 


else 
    
    th13=nan;
    th11=nan;
    th12=nan; 
    
end


phi= [th11; th12; th13;]; 



end



end