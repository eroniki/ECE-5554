function [T] = calculateNormalization(t1)
% calculateNormalization(): normalize the points 
% move centroid of data set to (0,0)
% variance = sqrt(2)
% Murat Ambarkutuk, PS3
X = t1(1,:);
Y = t1(2,:);
nPoints = numel(t1(1,:));
meanX = mean(t1(1,:));
meanY = mean(t1(2,:));

s = sqrt(2)*nPoints/sum(sqrt((X-meanX).^2+(Y-meanY).^2));

T = eye(3);
T(1,3) = -meanX;
T(2,3) = -meanY;
T(3,3) = 1/s;
T = s*T;
end

