% CornerDemo
clear
clc 
close all
addpath('193.soccer-ball')
addpath('017.bowling-ball')
dirstruct=dir('193.soccer-ball\*jpg');
L=length(dirstruct);
for i=1:L
    im=imread(dirstruct(i).name);
    sizeImage = size(im);
    l=min(sizeImage(1:2));
    ratio=l/150;
    resizeImage_o = imresize(im,round(sizeImage(1:2)/ratio));
    if length(sizeImage)==3
        resizeImage=rgb2gray(resizeImage_o);
    else
        resizeImage=resizeImage_o;
    end
    CM=cornermetric(resizeImage);
    [y,x,row,col,~]=anms(CM,50);
    figure(1)
    clf
    imshow(resizeImage_o)
    hold on
%     plot(col,row,'b.')
    plot(x,y,'r.')
    pause
end 