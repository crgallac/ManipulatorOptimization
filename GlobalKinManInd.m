function [ GKMI ] = GlobalKinManInd( Km, volume )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

Km(isnan(Km))=0; %matrix A determines which entries of Km are not NaN

KmTot=sum(sum(Km)); 

GKMI=KmTot/volume; 


end

