function [ KappaD ] = DynamicManip( M )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

% KappaM=abs(det(J)); 
[U S V]=svd(M);


S=S.^(1/2);
S;
% KappaD=abs(S(1,1)/S(3,3)); %condition number checks out
% KappaD=abs(det(S));%dynamic manipulability
% KappaD=abs(S(1,1)); 
KappaD=abs(trace(S));

% KappaD=abs(1/trace(S)*1/(S(1,1)/S(3,3))); 
% lambda
end

