function [ GDMI ] = GlobalDynManInd( Kd, volume )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here

Kd(isnan(Kd))=0; %matrix A determines which entries of Km are not NaN

KdTot=sum(sum(Kd)); 

GDMI=KdTot/volume; 


end

