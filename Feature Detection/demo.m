% Demo
clear
clc 
close all
addpath('193.soccer-ball')
addpath('017.bowling-ball')
addpath('088.golf-ball\')
addpath('216.tennis-ball\')
dirstruct=dir('216.tennis-ball\*jpg');
L=length(dirstruct);
center=cell(L);
radii=cell(L);
for i=1:L
    [center{i},radii{i}]=findCircle(dirstruct(i).name);
    title(dirstruct(i).name);
    pause
end 