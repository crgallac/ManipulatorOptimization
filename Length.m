function [ L] = Length( param )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

%param=[a0 a1 a2 Ro Ri rho Mmot1 Mmot2 Mgrip]

a0=param(1);
a1=param(2);
a2=param(3); 


L=sqrt(a0^2+a1^2+a2^2); 


end

