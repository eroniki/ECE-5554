clc; close all; clear all;

load('twoFrameData.mat');

oninds = selectRegion(im1, positions1);

descriptorsChoosen = descriptors1(oninds,:);

displaySIFTPatches(positions1(oninds,:), scales1(oninds), orients1(oninds), im1); 

dist = dist2(descriptorsChoosen,descriptors2);
[minVal, minLoc] = min(dist');

figure(2); imshow(im2);
displaySIFTPatches(positions2(minLoc,:), scales2(minLoc,:), orients2(minLoc,:), im2); 
