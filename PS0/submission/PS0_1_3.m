%% clear workspace , and command window, close all figures already open.
clear all, close all, clc;
%% PS0-1.3a
diceResults = diceTrials(99);
%% PS0-1.3b
% y = [1, 2, 3, 4, 5, 6]'
y = (1:6)';
% z = [1, 3, 5; 2, 4, 6]
z = reshape(y,[2,3]);
%% PS0-1.3c
% find the max value of matrice y and of which indice
[x, I] = max(y);
% convert indice to subscripts (row and column number)
[r, c] = ind2sub(size(z),I);
%% PS0-1.3d
% create vector v = [1, 8, 8, 2, 1, 3, 9, 8]
v = [1,8,8,2,1,3,9,8];
% alter the value of vector x
% the problem can be solved by two different approach
% 1 - x = numel(v(v==1))
% 2 - x = sum(v==1)
x = numel(v(v==1));