%% Main.m
% University of Pennsylvania
% CIS 519     Introduction to Machine Learning 
% Written by Shangyi Cheng 
% Algorithm to Detect and Classfy the Balls in a image

%% Define
clear
clc

display = 1;
dirstruct = dir( '*jpg' );
imNum = length(dirstruct);
imGray = cell( imNum,1 );
imHOG = cell( imNum,1 );
imHOG_vis = cell( imNum,1 );
% imGradient = cell( imNum );
% gx = [1 0 1];
% gy = [1 0 1]';
%% Load Image and Image Processing
for i =1: imNum
    im = im2double( imread( dirstruct(i).name ) );
    if length(size(im)) == 3
        im = rgb2gray( im );
    end
    % Normalize the color
    im =  imadjust( im );
    imGray {i} = im;   
%     %Gradient Computation
%     imGx = imfilter(im, gx, 'conv', 'symmetric');
%     imGy = imfilter(im, gy, 'conv', 'symmetric');
%     Gmag = hypot( imGx, imGy );
%     gmax = max( max( Gmag ) );
%     Gmag = Gmag/gmax;
%     imGradient{i} = Gmag;

    % HOG 
    [ imHOG{i}, imHOG_vis{i} ] = extractHOGFeatures( im, 'CellSize', [ 4, 4 ], 'BlockSize', [ 2, 2 ], 'NumBins', 9, 'UseSignedOrientation', false);
end

if display == 1
    figure(1)
    for i = 1:imNum
        subplot( 1,imNum, i  )
        imshow( imGray{i} )
        title('Origin')
        hold on 
        plot(imHOG_vis{i})
        hold off
%         subplot( 2, imNum, i + imNum)
%         imshow(imGradient{i})
%         title('Gradient')
    end
end


    
 