% Demo
clear
clc 
close all
addpath('193.soccer-ball')
addpath('017.bowling-ball')
dirstruct=dir('193.soccer-ball\*jpg');
L=length(dirstruct);
center=cell(L);
radii=cell(L);
for i=1:L
    [center{i},radii{i}]=findCircle(dirstruct(i).name);
    pause
end 