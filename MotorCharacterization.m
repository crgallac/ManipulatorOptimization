function [mass, tor]=MotorCharacterization(num)

% weight=[.140 .090 .150 .070];
% torque=[.01900 .01000 .02200 .00850];
% voltage=[5.4 4.5 5.9 3.5]; 
% current=[1 1 1 1]; 


weight=[0.140 0.070]; 
torque=[0.019 0.0085]; 


mass=weight(num);
tor=torque(num); 
% scatter(weight, torque)





end