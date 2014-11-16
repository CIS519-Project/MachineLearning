% HogTest
clear
clc 
close all
addpath('193.soccer-ball')
im=imread('193_0009.jpg');
sizeImage = size(im);
l=min(sizeImage(1:2));
ratio=l/150;
resizeImage_o = imresize(im,round(sizeImage(1:2)/ratio));
if length(sizeImage)==3
    resizeImage=rgb2gray(resizeImage_o);
else
    resizeImage=resizeImage_o;
end
[~,vl]=extractHOGFeatures(resizeImage,'cellsize',[6 6]);
figure(1)
clf 
imshow(resizeImage_o)
hold on 
plot(vl)