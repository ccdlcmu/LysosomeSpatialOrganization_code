function [] = plotloglogMSD(ma, confinedParticle, brownianParticle, directedParticle)

clip_factor = 0.75;
% if nargin < 2
%     clip_factor = 0.25;
% end
% 
% if ~obj.msd_valid
%     obj = obj.computeMSD;
% end
% n_spots = numel(obj.msd);
% 
% if clip_factor < 1
%     fprintf('Fitting %d curves of log(MSD) = f(log(t)), taking only the first %d%% of each curve... ',...
%         n_spots, ceil(100 * clip_factor) )
% else
%     fprintf('Fitting %d curves of log(MSD) = f(log(t)), taking only the first %d points of each curve... ',...
%         n_spots, round(clip_factor) )
% end
% 
% alpha = NaN(n_spots, 1);
% gamma = NaN(n_spots, 1);
% r2fit = NaN(n_spots, 1);
% ft = fittype('poly1');
% 
% fprintf('%4d/%4d', 0, n_spots);

n_spots = length(ma.msd);

for i_spot = 1 : length(confinedParticle)
    
    %fprintf('\b\b\b\b\b\b\b\b\b%4d/%4d', i_spot, n_spots);
    
    msd_spot = ma.msd{confinedParticle(i_spot)};
    
    t = msd_spot(:,1);
    y = msd_spot(:,2);
    w = msd_spot(:,4);
    
    % Clip data
    if clip_factor < 1
        t_limit = 2 : round(numel(t) * clip_factor);
    else
        t_limit = 2 : min(1+round(clip_factor), numel(t));
    end
    t = t(t_limit);
    y = y(t_limit);
    w = w(t_limit);
    
    % Thrash bad data
    nonnan = ~isnan(y);
    
    t = t(nonnan);
    y = y(nonnan);
    w = w(nonnan);
    
    if numel(y) < 2
        continue
    end
    
    xl = log(t);
    yl = log(y);
    
    bad_log =  find(isinf(xl) | isinf(yl));
    xl(bad_log) = [];
    yl(bad_log) = [];
    w(bad_log) = [];
    
    if numel(xl) < 2
        continue
    end
    
    plot(xl,yl,'g')
    hold on
    

end

for i_spot = 1 : length(brownianParticle)
    
    %fprintf('\b\b\b\b\b\b\b\b\b%4d/%4d', i_spot, n_spots);
    
    msd_spot = ma.msd{brownianParticle(i_spot)};
    
    t = msd_spot(:,1);
    y = msd_spot(:,2);
    w = msd_spot(:,4);
    
    % Clip data
    if clip_factor < 1
        t_limit = 2 : round(numel(t) * clip_factor);
    else
        t_limit = 2 : min(1+round(clip_factor), numel(t));
    end
    t = t(t_limit);
    y = y(t_limit);
    w = w(t_limit);
    
    % Thrash bad data
    nonnan = ~isnan(y);
    
    t = t(nonnan);
    y = y(nonnan);
    w = w(nonnan);
    
    if numel(y) < 2
        continue
    end
    
    xl = log(t);
    yl = log(y);
    
    bad_log =  find(isinf(xl) | isinf(yl));
    xl(bad_log) = [];
    yl(bad_log) = [];
    w(bad_log) = [];
    
    if numel(xl) < 2
        continue
    end
    
    plot(xl,yl,'b')
    hold on
    

end


for i_spot = 1 : length(directedParticle)
    
    %fprintf('\b\b\b\b\b\b\b\b\b%4d/%4d', i_spot, n_spots);
    
    msd_spot = ma.msd{directedParticle(i_spot)};
    
    t = msd_spot(:,1);
    y = msd_spot(:,2);
    w = msd_spot(:,4);
    
    % Clip data
    if clip_factor < 1
        t_limit = 2 : round(numel(t) * clip_factor);
    else
        t_limit = 2 : min(1+round(clip_factor), numel(t));
    end
    t = t(t_limit);
    y = y(t_limit);
    w = w(t_limit);
    
    % Thrash bad data
    nonnan = ~isnan(y);
    
    t = t(nonnan);
    y = y(nonnan);
    w = w(nonnan);
    
    if numel(y) < 2
        continue
    end
    
    xl = log(t);
    yl = log(y);
    
    bad_log =  find(isinf(xl) | isinf(yl));
    xl(bad_log) = [];
    yl(bad_log) = [];
    w(bad_log) = [];
    
    if numel(xl) < 2
        continue
    end
    
    plot(xl,yl,'r')
    hold on
    

end

xlabel('log (delay)')
ylabel('log (MSD)')
set(gca, 'FontSize', 20)
