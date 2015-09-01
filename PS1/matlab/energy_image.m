function energyMap = enegy_image(im)
    frameGray = rgb2gray(frame);
    [energyMap, ~] = imgradient(im, 'prewitt'); 
end

