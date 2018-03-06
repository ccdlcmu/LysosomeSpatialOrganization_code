function PC = DBSCAN(ptloc, eps, minpts)

% Implimentation od density-based clustering (DBSCAN)
% DBSCAN version 2

% INPUT:  

% By Qinle Ba at BME, Carnegie Mellon Univeristy, 2016 April


    N = size(ptloc,1); % # of points
    PC = zeros(N,1); % Which points in which cluster
   
    j = 0; % Number of clusters
    for i = 1:N % Examine each point
        
        if PC(i) == 0 % Unclustered point
            
            %------------------------expand cluster-----------------------%
            % Distance with other points;
            D = sqrt(sum((ptloc - [ptloc(i,1)*ones(N,1) ptloc(i,2)*ones(N,1)]).^2,2));
            seedsNo = find(D<=eps); % Point index in ptloc including self
            iscandpt  = PC(seedsNo)<1;
            ptNumb = sum(iscandpt); % A noise point can be reached by other points
            % 
            if ptNumb < minpts
                PC(i) = -1; % Assign point i to be noise 
            else
                j = j+1; % Add a new cluster
                PC(seedsNo(iscandpt)) = j;% Assign to a new cluster
                seedsNo(seedsNo==i) = [];  % Delete point i from seeds
                ii = 1;
                while isempty(seedsNo)== 0
                    % EPS-neighborhood
                    DS = sqrt( sum( ( ptloc-...
                        [ptloc(seedsNo(ii),1)*ones(N,1),ptloc(seedsNo(ii),2)*ones(N,1)]).^2,2 ) );
                    rsltNo = find(DS<=eps); % Point index in PC including self
                    NN = length(rsltNo); % # of points in seed ii EPS-neigb
                    if NN >= minpts
                        pts = find(PC(rsltNo)<1); % A noise point can be reached by other points
                        PC(rsltNo(pts)) = j;
                        seedsNo = [seedsNo; rsltNo(pts)];
                    end % end if NNN>=minpts
                    seedsNo(ii)=[]; % Delete seed ii
                end % end while
           
            end % end if
            %----------------------finish expanding cluster---------------% 
        
        end % end if i      
    end % end i
    
end