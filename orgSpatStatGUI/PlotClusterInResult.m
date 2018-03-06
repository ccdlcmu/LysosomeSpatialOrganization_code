function PlotClusterInResult(X, IDX) 
%By Guru
    
    k=max(IDX);

    Colors=hsv(k);
    %figure,
    Legends = {};
    for i=0:k
        Xi=X(IDX==i,:);
        if i~=0
            Style = '.';
            MarkerSize = 10;
            Color = Colors(i,:);
            Legends{end+1} = ['Cluster #' num2str(i)];
        else
            Style = 'o';
            MarkerSize = 6;
            Color = [0 0 0];
            if ~isempty(Xi)
                Legends{end+1} = 'Noise';
            end
        end
        if ~isempty(Xi)
            
            plot(Xi(:,1),Xi(:,2),Style,'MarkerSize',MarkerSize,'Color',Color);
        end
        hold on;
    end
    hold off;
  
    axis equal;
    %grid on;
    legend(Legends);
    legend('Location', 'NorthEastOutside');
    
end



