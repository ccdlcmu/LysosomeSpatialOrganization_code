function [] = plotTrackswMode(confinedParticle, brownianParticle, directedParticle, tracks)

figure,
imC1 = 'egfp-skl_e1s1_fast_cell1t001.tif';
imgC1 = imread(imC1);

imshow(imgC1,[]);
hCell = imfreehand;
posCell = hCell.getPosition();

figure,
imgC1(:) = 0;
imshow(imgC1,[]);
hold on
for i = 1:length(confinedParticle)
    
    particleTrack = tracks{confinedParticle(i)};
    x = particleTrack(:,2)/0.06;
    y = particleTrack(:,3)/0.06;
    
    plot(x,y,'g')
    hold on
end

for i = 1:length(brownianParticle)
    
    particleTrack = tracks{brownianParticle(i)};
    x = particleTrack(:,2)/0.06;
    y = particleTrack(:,3)/0.06;
    
    plot(x,y, 'b')
    hold on
end


for i = 1:length(directedParticle)
    
    particleTrack = tracks{directedParticle(i)};
    x = particleTrack(:,2)/0.06;
    y = particleTrack(:,3)/0.06;
    
    plot(x,y,'r')
    hold on
end

plot(posCell(:,1),posCell(:,2),'w')