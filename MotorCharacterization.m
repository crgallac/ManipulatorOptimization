function [mass, tor]=MotorCharacterization(num)

% weight=[.140 .090 .150 .070];
% torque=[.1900 .1000 .2200 .0850];
% voltage=[5.4 4.5 5.9 3.5]; 
% current=[1 1 1 1]; 


weight=[0.150 0.090]; 
torque=[0.22 0.1]; 


mass=weight(num);
tor=torque(num); 
% scatter(weight, torque)





end