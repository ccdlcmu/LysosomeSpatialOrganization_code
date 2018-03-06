function msd = MSD(track,LagNumb)
% functio for calculating mean square displacement(MSD)from a trajectory

% input:
% track: a matrix with x,y positions of a trajectory at each time point,
% whose 1st column stores x and 2nd column y.
% LagNumb:  <15% total shortest lags of the trajectory

% By Qinle Ba at BME, Carnegie Mellon Univeristy, 2016-Dec

TotalLagNumb = length(track) - 1;

if TotalLagNumb < LagNumb % too short a trajectory
    msd = [];
else
    lag = 0.1; % 0.1 s
    for dt = 1: LagNumb
        sd = sum ( sum( ( track(1:end-dt,:)-track(dt+1:end,:) ).^2 , 2) );
        msd(dt) = sd/(TotalLagNumb-dt+1);
    end
    msd = msd';
%     plot(lag*(1:LagNumb),msd)
%     hold on;
    
end


end