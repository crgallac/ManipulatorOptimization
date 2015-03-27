function [ vol] = Volume( LogicMap, distance )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

% distance 

vol=sum(sum(LogicMap))*distance^3; 

end

