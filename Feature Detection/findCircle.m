function [center, rad] = findCircle(filename,ifShown)

image = imread(filename);
sizeImage = size(image);
resizeImage = imresize(image,[100 ceil(100*sizeImage(2)/sizeImage(1))]);
[center1, rad1] = imfindcircles(resizeImage,[10,20],'ObjectPolarity','dark','Sensitivity',0.9);
[center2, rad2] = imfindcircles(resizeImage,[20,60],'ObjectPolarity','dark','Sensitivity',0.9);
[center3, rad3] = imfindcircles(resizeImage,[10,20],'Sensitivity',0.9);
[center4, rad4] = imfindcircles(resizeImage,[20,60],'Sensitivity',0.9);
%[center5, rad5] = imfindcircles(resizeImage,[5,10],'ObjectPolarity','dark','Sensitivity',0.9);
%[center6, rad6] = imfindcircles(resizeImage,[5,10],'Sensitivity',0.9);
center = [center1;center2;center3;center4]%;center5;center6];
rad = [rad1;rad2;rad3;rad4]%;rad5;rad6];

if nargin == 1
    ifShown = 1;
end
if ifShown
figure(1);
imshow(resizeImage);
hold on;
viscircles(center,rad,'EdgeColor','b');
end

end
