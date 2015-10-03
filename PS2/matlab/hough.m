clc; clear all; close all; profile on;

im = imread('jupiter.jpg');
[h, w, ~] = size(im);

frame = zeros(h,w, 'uint8');

radius = 150;
% center.x = 200;
% center.y = 200;
useGradient = 1;
% detectCircles(im,10,1);

im = rgb2gray(im);
[h, w, ~] = size(im);
[Gmag,Gdir] = imgradient(im);
edges = Gmag>mean(Gmag(:));

Gdir = Gdir * 0.0175 + pi;

[i, j] = find(edges == 1);

thetaResolution = 0.1;
angle = 0:thetaResolution:2*pi;
angleIndex = 1:numel(angle);
houghSpace = zeros(h,w);

for counter=1:numel(i)
    center.y = i(counter);
    center.x = j(counter);
    if(useGradient == 1)
        theta = Gdir(center.y, center.x);
    else
        theta = angle;
    end
           
    a = center.x + radius * cos(theta);
    b = center.y + radius * sin(theta);
    a(a>w | a<1) = [];
    b(b>h | b<1) = [];
    
    houghSpace(round(b), round(a)) = houghSpace(round(b), round(a)) + 1;
    
%     for votingCounter=1:numel(theta)
%         [~, idx] = min(abs(angle-theta(votingCounter)));
%         ['a: ', num2str(round(a)), ' b: ', num2str(round(b)), ' theta: ', num2str(theta), ' idx: ', num2str(idx)];
%         houghSpace(round(b), round(a));
%     end
end