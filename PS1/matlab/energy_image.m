% TODO Add comments for the code and the function
function energyMap = enegy_image(im)
    frameGray = rgb2gray(im);
    [energyMap, ~] = imgradient(frameGray, 'prewitt'); 
end

