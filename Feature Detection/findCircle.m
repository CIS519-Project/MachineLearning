function [center, rad] = findCircle(filename,ifShown)

image = imread(filename);
sizeImage = size(image);
L=min(sizeImage(1:2));
ratio=L/150;
resizeImage_o = imresize(image,round(sizeImage(1:2)/ratio));
if length(sizeImage)==3
    resizeImage=rgb2gray(resizeImage_o);
else
    resizeImage=resizeImage_o;
end
resizeImage=imadjust(resizeImage);
sensitivity = [0.9,0.92,0.94,0.96,0.98];
center = []; i = 0;
rad = [];
while isempty(center)
    i=i+1;
    if i>5
        break
    end
    [center1, rad1] = imfindcircles(resizeImage,[10,20],'ObjectPolarity','dark','Sensitivity',sensitivity(i));
    [center2, rad2] = imfindcircles(resizeImage,[20,50],'ObjectPolarity','dark','Sensitivity',sensitivity(i));
    [center3, rad3] = imfindcircles(resizeImage,[50,80],'ObjectPolarity','dark','Sensitivity',sensitivity(i));
    [center4, rad4] = imfindcircles(resizeImage,[10,20],'Sensitivity',sensitivity(i));
    [center5, rad5] = imfindcircles(resizeImage,[20,50],'Sensitivity',sensitivity(i));
    [center6, rad6] = imfindcircles(resizeImage,[50,80],'Sensitivity',sensitivity(i));
    center = [center1;center2;center3;center4;center5;center6];
    rad = [rad1;rad2;rad3;rad4;rad5;rad6];
end

if nargin == 1
    ifShown = 1;
end
if ifShown
figure(1)
clf
imshow(resizeImage_o);
hold on;
viscircles(center,rad,'EdgeColor','r');
end
end
