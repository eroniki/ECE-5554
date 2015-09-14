% Clear command window and workspace, close all figures
close all, clear all, clc;
profile on;

p = profile('status');
suffixes = {'BurrussHall','EAP', 'Manhattan', 'NorthKorea', 'PennStation'};
% Load the image and show the original work

parfor i=1:size(suffixes,2)
    suffix = suffixes{i};
    inputFile = [suffix,'/input', suffix, '.jpg'];
    outputFile= [suffix,'/output', suffix, 'H.png'];

    frame = imread(inputFile);


    [h, w, c] = size(frame);
    % Compute and acquire the energy map
    % TODO - imgradient requires me to pass grayscale image!
    energyMap = energy_image(frame);

    newImage = frame;
    newEnergyMap = energyMap;
    
    for k=1:100
        tic
        [newImage, newEnergyMap] = reduceHeight(newImage,newEnergyMap);
        toc
    end

    imwrite(newImage, outputFile);
    comparisonOriginal = imfuse(frame,newImage,'falsecolor');
    imwrite(comparisonOriginal, [suffix,'/outputIOH','.png']);
    
    figure(2*i-1), imshow(frame), title('Input Image');
    figure(2*i), imshow(newImage), title('Output Image (Dynamic Programming)');
end
% profile viewer