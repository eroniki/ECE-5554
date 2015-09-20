function [outputImage, meanColors] = quantizeHSV(inputImage, nCluster)
    [h, w, ~] = size(inputImage);
    dataSet = double(reshape(inputImage(:,:,1), h*w,1));

    [labels, meanColors] = kmeans(dataSet,nCluster,'MaxIter', 250);
    labels = reshape(labels,h,w);
    
    outputImage = inputImage;
    
    for i=1:h
        for j=1:w
            outputImage(i,j,1) = meanColors(labels(i,j));
        end
    end
end