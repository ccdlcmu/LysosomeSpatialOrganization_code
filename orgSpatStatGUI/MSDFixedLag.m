function msd = MSDFixedLag(track,lagNumb)
% function for calculating mean square displacement(MSD)from a trajectory

% input:
% track: a matrix with x,y positions of a trajectory at each time point,
% whose 1st column stores x and 2nd column y.
% LagNumb

% By Qinle Ba at BME, Carnegie Mellon Univeristy, 2017

totalLagNumb = length(track) - 1;

if totalLagNumb < lagNumb % too short a trajectory
    msd = [];
else  
    dt = lagNumb;
    sd = sum ( sum( ( track(1:end-dt,:)-track(dt+1:end,:) ).^2 , 2) );
    msd = sd/(totalLagNumb-dt+1); 
end