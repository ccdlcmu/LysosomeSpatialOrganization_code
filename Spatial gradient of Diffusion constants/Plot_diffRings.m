%Plot diffusion rings with distance from nucleus

%data = xlsread('DiffusionConstants_spatialGradient','Cell 1');
sMat_diff = dir('Diff*_Cell2*.mat');
fileMat_diff = {sMat_diff.name};

for i = 1:length(fileMat_diff)
    
    load(fileMat_diff{i})
    
    x = [];
    g = [];
    
    mean_diffC = [];
    std_diffC = [];
    
    for ring = 1:length(diffRings)
        
        if numel(diffRings{ring}) == 0
            mean_diffC = [mean_diffC, 0];
            std_diffC = [std_diffC, 0];
            x = [x; diffRings{ring}];
            g = [g; ones(length(diffRings{ring}),1)*ring];
        else
            mean_diffC = [mean_diffC, mean(diffRings{ring})];
            std_diffC = [std_diffC, std(diffRings{ring})];
        
            x = [x; diffRings{ring}];
            g = [g; ones(length(diffRings{ring}),1)*ring];
        end

    end
    
    figure;
    h = boxplot(x,g);
    set(h(7,:),'Visible','off')
    xlabel('Increasing distance from nucleus --\rangle')
    ylabel('Diffusion constant (\mum^2/s)')
    %errorbar(1:length(diffRings),mean_diffC,std_diffC)
    
end

        
    
