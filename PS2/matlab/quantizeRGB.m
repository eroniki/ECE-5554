function [outputImage, meanColors] = quantizeRGB(inputImage, nCluster)
    [h, w, c] = size(inputImage);
    dataSet = double(reshape(inputImage, h*w,c));

    [labels, meanColors] = kmeans(dataSet,nCluster,'MaxIter', 250);
    labels = reshape(labels,h,w);
    
    outputImage = zeros(h,w,c,'uint8');
    
    for i=1:h
        for j=1:w
            outputImage(i,j,:) = meanColors(labels(i,j),:);
        end
    end
end