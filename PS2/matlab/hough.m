 clc; clear all; close all; profile on;

im = imread('jupiter.jpg');
[h, w, ~] = size(im);
maxDim = max(h,w);
frame = zeros(h,w, 'uint8');

radius = 50;
useGradient = 0;


detectCircles(im, maxDim, 0);

