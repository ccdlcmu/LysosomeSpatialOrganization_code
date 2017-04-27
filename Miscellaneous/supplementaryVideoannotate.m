
% Adding a scale bar to every frame in the movie

filename = 'Demo_data\bsc1_pattern_2_002_20s_4xspeed_CellBoundary';
%filename = 'bsc1_unpattern_006_20s_3.93xSpeed_CellBoundary';

vid = VideoReader(strcat(filename,'.avi'));
numFrames = vid.numberOfFrames;
frame1 = read(vid,1);

figure;
imshow(frame1,[])

[stX, stY] = getpts(gcf);
rectScaleBar = [stX, stY, 167, 3];


figure;
imshow(frame1,[])
rectangle('Position',rectScaleBar,'EdgeColor','w','FaceColor','w')
text(stX+50,stY-14,'10\mum','Color','w','FontSize',10)
filesave = strcat('annotated/',filename,'_anno.tif');
hgexport(gcf, filesave, hgexport('factorystyle'), 'Format', 'tiff');


