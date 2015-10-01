function [coordinates,frame] = circleCoordinates(im, center, radius)  
    [h, w, ~] = size(im);   
    frame = zeros(h,w, 'uint8')
    [xx, yy] = meshgrid(1:w, 1:h);

    p = (xx-center.x).^2;
    t = (yy-center.y).^2;

    coordinates = (p+t)>=radius^2 & (p+t)<=(radius+1)^2;
    frame(coordinates) = 255;
end