function [ KappaM ] = KinematicManip( J )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
% KappaM=abs(det(J)); 

[U,S,V] =svd(J);

S=S.^(1/2);

% KappaM=abs(det(S)); 

%new index (the trace times the condition number)
KappaM=abs(trace(S)*1/((S(1,1)/S(3,3)))); 


end

