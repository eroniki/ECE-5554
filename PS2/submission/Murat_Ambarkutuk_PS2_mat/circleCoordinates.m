function [geometry] = circleCoordinates(center, radius, size)
%     theta = 0:thetaRes:2*pi;
%
%     geometry.x = center.x + radius * cos(theta);
%     geometry.y = center.y + radius * sin(theta);
%
%     geometry.frame = zeros(numel(geometry.x), numel(geometry.y), 'uint8');
%     geometry.frame(round(geometry.y),round(geometry.x)) = 255;
% 
%     size.h = floor(center.y + radius);
%     size.w = floor(center.x + radius);

    geometry.frame = zeros(size.h, size.w, 'uint8');
    [xx, yy] = meshgrid(1:size.w, 1:size.h);

    p = (xx-center.x).^2;
    t = (yy-center.y).^2;

    geometry.coordinates = (p+t)>=radius^2 & (p+t)<=(radius+1)^2;
    geometry.frame(geometry.coordinates) = 255;
end
