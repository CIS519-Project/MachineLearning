%% Dataset Crop
% University of Pennsylvania
% CIS 519     Introduction to Machine Learning 
% Written by Shangyi Cheng 
% Algorithm to Detect and Classfy the Balls in a image

% When manully select the ROI, please make sure the ball stay in the center
% of the box and leave about 10% margin each side.

%% Load
clear 
clc
addpath('data\193.soccer-ball')
addpath('data\017.bowling-ball')
addpath('data\088.golf-ball\')
addpath('data\216.tennis-ball\')

savedir = 'Patches/Bowling/';
Num = 0;
Label = 'Bowling';
PatchSize = [40 40];
moveRatio=0.1;
dirstruct=dir('data\017.bowling-ball\*jpg');

for i = 1:length(dirstruct)
    im = im2double( imread( dirstruct(1).name ) );
    Y = size(im,1);
    X = size(im,2);
    nextImage = 0;
  
    while nextImage ~=1
        display('Select the ROI ( click the LEFT TOP point first ), then double left clicks to crop...')
        [~,rect] = imcrop( im );
        xmin = rect(1);
        ymin = rect(2);
        w = rect(3);
        h = rect(4);
        side = min( w, h );
        
        CropAround = -1;
        while CropAround ~= 0 && CropAround ~= 1
            CropAround = input( 'Would you like to sample around?  0/1:');
            if CropAround ~= 0 && CropAround ~= 1
                display(' Input error, try again.')
            end
        end
     
        if CropAround == 0
            Patch = imcrop ( im,  [xmin, ymin, side, side] );
            Num = Num + 1;
            name = [ savedir Label num2str(Num) '.jpg'];
            Patch = imresize( Patch, PatchSize );
            imwrite(Patch,name,'jpg'); 
        else
            %   2  3  4
            %   1  0  5
            %   8  7  6
            shift = moveRatio * side;
            Xmin = xmin - shift;
            Xmax = xmin + side + shift;
            Ymin = ymin -shift;
            Ymax = ymin + side + shift;
            List = 0:8;
            if Xmin < 0
                List = List( List ~= 2);
                List = List( List ~= 1);
                List = List( List ~= 8);
            end          
            if Ymin < 0
                List = List( List ~= 2);
                List = List( List ~= 3);
                List = List( List ~= 4);
            end
            if Xmax > X
                List = List( List ~= 4);
                List = List( List ~= 5);
                List = List( List ~= 6);
            end            
            if Ymax > Y
                List = List( List ~= 8);
                List = List( List ~= 7);
                List = List( List ~= 6);
            end
            for j = List
                Num = Num + 1;
                name = [ savedir Label num2str(Num) '.jpg'];
                switch j
                    case 0
                        a = xmin;
                        b = ymin;
                    case 1
                        a = Xmin;
                        b = ymin;                
                    case 2
                        a = Xmin;
                        b = Ymin;
                    case 3
                        a = xmin;
                        b= Ymin;
                    case 4
                        a = xmin + shift;
                        b = Ymin;
                    case 5
                        a = xmin + shift;
                        b = ymin;
                    case 6
                        a = xmin + shift;
                        b = ymin + shift;
                    case 7
                        a = xmin;
                        b = ymin + shift;
                    case 8
                        a = Xmin;
                        b = ymin + shift;
                end
                Patch = imcrop ( im,  [a, b, side, side] );
                Patch = imresize( Patch, PatchSize );
                imwrite(Patch,name,'jpg');
            end
        end
        
        nextImage = -1;
        while nextImage ~=0 && nextImage ~= 1
            nextImage = input( 'Would you like to crop next image? 0/1:');
            if nextImage ~= 0 && nextImage ~= 1
                display(' Input error, try again.')
            end
        end
        clc
        end
        close all
end