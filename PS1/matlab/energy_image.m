% TODO Add comments for the code and the function
function energyMap = energy_image(im)
    frameGray = rgb2gray(im);
    [energyMap, ~] = imgradient(frameGray, 'prewitt'); 
%     frameGray = rgb2gray(im);
%     LoG = conv2(fspecial('laplacian'),fspecial('gaussian'));
%     energyMap = imfilter(frameGray, LoG); 
end

