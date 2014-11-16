function [center, rad] = findCircle(filename,ifShown)

image = imread(filename);
sizeImage = size(image);
resizeImage = imresize(image,[150 ceil(150*sizeImage(2)/sizeImage(1))]);
sensitivity = [0.85,0.9,0.95,0.97,0.99];
center = []; i = 1;
rad = [];
while isempty(center)
    i=i+1;
    if i>=5
        break;
    end
    [center1, rad1] = imfindcircles(resizeImage,[10,20],'ObjectPolarity','dark','Sensitivity',sensitivity(i));
    [center2, rad2] = imfindcircles(resizeImage,[20,60],'ObjectPolarity','dark','Sensitivity',sensitivity(i));
    [center3, rad3] = imfindcircles(resizeImage,[10,20],'Sensitivity',sensitivity(i));
    [center4, rad4] = imfindcircles(resizeImage,[20,60],'Sensitivity',sensitivity(i));
    [center5, rad5] = imfindcircles(resizeImage,[60,80],'ObjectPolarity','dark','Sensitivity',sensitivity(i));
    [center6, rad6] = imfindcircles(resizeImage,[60,80],'Sensitivity',sensitivity(i));
    center = [center1;center2;center3;center4;center5;center6];
    rad = [rad1;rad2;rad3;rad4;rad5;rad6];
end

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
