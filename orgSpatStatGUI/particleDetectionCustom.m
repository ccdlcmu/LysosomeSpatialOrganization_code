% point detection
%clear all; clc;

function [PrtclLoc, imf] = particleDetectionCustom(img, masksize, quantile, wavelength, pixelsize, NA)

display('Start particle detection program!')
% [img,rectimg] = imcrop(img,[]);
im0 = im2double(img);
figure,
[img_bg,~] = imcrop(img,[]); 
bg = im2double(img_bg);
% avg_bg = mean(reshape(bg,[],1));
std_bg = std(bg(:));

%apply gaussian filter
sigma = 1/3*0.61*wavelength/pixelsize/NA; 
imf = imgaussfilt(im0,sigma);

% local maxima and minima
padsize = (masksize-1)/2;
iml = padarray(imf,[padsize padsize]);
imlmx = zeros(size(imf));
imlmn = zeros(size(imf));
for i = (padsize+1):(size(imf,1)+padsize)
    for j = (padsize+1):(size(imf,2)+padsize)
        imlocal = iml( (i-padsize):(i+padsize),(j-padsize):(j+padsize) );
        if iml(i,j) == max(imlocal(:))
            imlmx(i-padsize,j-padsize) = imf(i-padsize,j-padsize);
        end
         if iml(i,j) == min(nonzeros(imlocal(:)))
%         if iml(i,j) == min(imlocal(:));
           imlmn(i-padsize,j-padsize) = imf(i-padsize,j-padsize);
        end
        
    end
end


% connection of local maxima and minima
[X, Y] = find(imlmn>0); % coordinates of local minima points
DT = delaunayTriangulation(X,Y);
P = DT.Points;
T = DT.ConnectivityList;
TR = triangulation(T,P); 
[Xm,Ym] = find(imlmx>0);
QP = [Xm,Ym];
ti = pointLocation(TR,QP);% enclosing triangles for each maxima point
Ilbg =zeros(1,size(ti,1));
Ilmx = Ilbg; 
for k = 1:size(ti,1)
    if isnan(ti(k))==0 % for those points enclosed by triangles
        tri = T(ti(k),:);% which triangle
        P1 = P(tri(1),:); % coordinates of the first triangle point
        P2 = P(tri(2),:);
        P3 = P(tri(3),:);
        Ilbg(k) = 1/3*(imf(P1(1),P1(2))+ ...
            imf(P2(1),P2(2))+imf(P3(1),P3(2))); % local background intensity
        Ilmx(k) = imf(QP(k,1),QP(k,2)); % local maxima intensity
        
    end
    
end
% t-test
Tstat = abs(Ilbg-Ilmx)./(std_bg);
Prtcl = find(Tstat > quantile);
PrtclLoc = [QP(Prtcl,2),QP(Prtcl,1)];% particle localization

figure, imshowpair(im0,im0, 'montage')
hold on
plot(PrtclLoc(:,1),PrtclLoc(:,2),'.r');



% save('mito_6\drp1_6_2_particle','PrtclLoc','QT')

