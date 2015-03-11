function [J]=Jacobian(theta, param)
%Jacobian of the Manipulator J=J(

phi=theta; 

%params=[a0 a1 a2 Ro Ri rho Mmot1 Mmot2 Mgrip]

a1=param(2);
a2=param(2); 


J = [-cos(phi(3)) * (a1 * cos(phi(1)) + a2 * cos(phi(1) + phi(2))) -sin(phi(3)) * (-a1 * sin(phi(1)) - a2 * sin(phi(1) + phi(2))) sin(phi(3)) * a2 * sin(phi(1) + phi(2)); -sin(phi(3)) * (a1 * cos(phi(1)) + a2 * cos(phi(1) + phi(2))) cos(phi(3)) * (-a1 * sin(phi(1)) - a2 * sin(phi(1) + phi(2))) -cos(phi(3)) * a2 * sin(phi(1) + phi(2)); 0 a1 * cos(phi(1)) + a2 * cos(phi(1) + phi(2)) a2 * cos(phi(1) + phi(2));];

%J=[-sin(phi(3)) * (-a1 * sin(phi(1)) - a2 * sin(phi(1) + phi(2))) sin(phi(3)) * a2 * sin(phi(1) + phi(2)) -cos(phi(3)) * (a1 * cos(phi(1)) + a2 * cos(phi(1) + phi(2))); cos(phi(3)) * (-a1 * sin(phi(1)) - a2 * sin(phi(1) + phi(2))) -cos(phi(3)) * a2 * sin(phi(1) + phi(2)) -sin(phi(3)) * (a1 * cos(phi(1)) + a2 * cos(phi(1) + phi(2))); a1 * cos(phi(1)) + a2 * cos(phi(1) + phi(2)) a2 * cos(phi(1) + phi(2)) 0;];

%%2D from Jozsef's notes !!!!!!!!!! Works Well
% J=[-a1*sin(theta(1))-a2*sin(theta(1)+theta(2)) -a2*sin(theta(1)+theta(2)); a1*cos(theta(1))+a2*cos(theta(1)+theta(2)) a2*cos(theta(1)+theta(2))];