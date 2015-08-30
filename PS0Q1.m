%% clear workspace , and command window, close all figures already open.
clear all, close all, clc;
figure(1);
A = uint8(randi(255,[100,100]));
subplot(2,2,1), imshow(A);
title('Random Generated Intensity Profiles (A)')
save('inputAPS0Q1.mat', 'A');
load('inputAPS0Q1.mat', 'A');
%% PS-0 4a
A_sorted = sort(reshape(A,[numel(A), 1]), 'descend');
A_sorted = reshape(A_sorted, size(A));
subplot(2,2,2), imshow(A_sorted);
title('Sorted Intensity Values (A)')
%% PS-0 4b
bins = 20;
maxA = max(A(:));
minA = min(A(:));
range = (maxA-minA)/bins;
hist = zeros(1,bins);
y = zeros(1,bins);
for i=1:20
    hist(i) = numel(A(A>=(minA+(i-1)*range) & A<(minA+(i)*range)));
    y(i) = minA+(i-1)*range;
end
subplot(2,2,3), bar(y,hist, 0.8, 'r');
axis([0 255 min(hist) max(hist)*1.05])
grid on;
title('Intensity Histogram of A (20 windows)');
%% PS-0 4c
% X = A_sorted(size(A,1)/2:size(A,1), 0:size(A,2)/2);
X = A_sorted(size(A_sorted,1)/2+1:size(A_sorted,1), 1:size(A_sorted,2)/2);
save('outputXPS0Q1.mat','X');
subplot(2,2,4), imagesc(X);
%% PS-0 4d
Y = A - mean(A(:));
save('outputYPS0Q1.mat','Y');
figure(2);
imagesc(Y);
%% PS-0 4e
Z = uint8(zeros(size(A_sorted,1),size(A_sorted,2),3));
ind = A(A>mean(A(:)));
[u v] = ind2sub(size(A),ind);
for i=1:numel(ind)
   Z(u(i),v(i),:) = [255,0,0]; 
end
figure(4);
imshow(Z);