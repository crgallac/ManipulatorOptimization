function [yieldstress, dens]= MaterialProperties(num)
%Material properties

%[steel titanium aluminum HDPE polypro carbon fibre wood]


% stress=1*10^6*[690 830 400 33 43 200 40]; 
% density=[7800 4500 2700 950 910 1750 430];

stress=1*10^6*[830 400 200]; 
density=[4500 2700 1750];


yieldstress= stress(num); 
dens= density(num); 

end