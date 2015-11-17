function [normalizedPoints] = normalizeHomogeneous(points)
% normalizeHomogeneous(): [u*w,v*w,w] to [u,v,1]
nPoints = size(points,2);
normalizedPoints = zeros(size(points));
for i=1:nPoints
    normalizedPoints(:,i) = points(:,i)/points(3,i);
end
end
