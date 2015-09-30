function [histEqual, histClustered, HSV] = getHueHists(im, k)
    HSV.double = rgb2hsv(im);
    HSV.uint8 = uint8(HSV.double*255);
     
%     inputImage.HSV = rgb2hsv(inputImage.RGB);
%     inputImage.HSVuint = uint8(inputImage.HSV*255);

    [output, ~] = quantizeHSV(HSV.uint8, k);
    [histClustered, ~] = imhist(output(:,:,1));
    [histEqual, ~] = imhist(HSV.uint8(:,:,1));    
end