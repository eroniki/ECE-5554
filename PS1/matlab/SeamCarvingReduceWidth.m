% Clear command window and workspace, close all figures
close all, clear all, clc;

% Load the image and show the original work
frame = imread('poe-raven.jpg');

figure(1);
imshow(frame)

% Compute and acquire the energy map
energyMap = energy_image(frameGray);
figure(2);
imshow(energyMap);

% Calculate cumulative energy map


