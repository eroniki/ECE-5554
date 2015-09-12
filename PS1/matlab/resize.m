close all, clear all, clc;
profile on;

p = profile('status');
suffixes = {'BurrussHall','EAP', 'Manhattan', 'NorthKorea', 'PennStation'};
% Load the image and show the original work
scales = [0.5, 0.5, 0.5, .125, .25];
for i=1:size(suffixes,2)
    suffix = suffixes{i};
    inputFile = [suffix,'/org', suffix, '.jpg'];
    outputFile= [suffix,'/input', suffix, '.jpg'];
    I = imread(inputFile);
    J = imresize(I, scales(i));
    imwrite(J,outputFile);
end