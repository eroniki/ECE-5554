function [histEqual, histClustered, HSV] = getHueHists(im, k)
    HSV.double = rgb2hsv(im);
    HSV.uint8 = uint8(HSV.double*255);
    [output, ~] = quantizeHSV(HSV.uint8, k);
    [histClustered, ~] = imhist(output(:,:,1));
    [counts, x] = imhist(HSV.uint8(:,:,1),k);
    histEqual = zeros(1,255);
    histEqual(round(x+1)) = counts;
end