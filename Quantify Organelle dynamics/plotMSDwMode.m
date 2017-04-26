function [] = plotMSDwMode(confinedParticle, directedParticle, brownianParticle, ma)


MSD_all = ma.msd;

for i = 1:length(confinedParticle)
    t = MSD_all{confinedParticle(i)}(:,1);
    m = MSD_all{confinedParticle(i)}(:,2);
    
    plot(t,m,'g')
    hold on
end

for i = 1:length(brownianParticle)
    t = MSD_all{brownianParticle(i)}(:,1);
    m = MSD_all{brownianParticle(i)}(:,2);
    
    plot(t,m,'b')
    hold on
end

for i = 1:length(directedParticle)
    t = MSD_all{directedParticle(i)}(:,1);
    m = MSD_all{directedParticle(i)}(:,2);
    
    plot(t,m,'r')
    hold on
end


