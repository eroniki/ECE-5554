% TODO Add comments for the code and the function
function [newImage, newEnergyMap] = reduceWidth(image, energyMap)
    if(nargin~=2)
        errorMessage = 'Missing argument';
        error(errorMessage);
    end
    [h, w, c] = size(image);
    newImage = zeros(h, w-1,c, 'uint8');
    newEnergyMap = zeros(h, w-1);
    % Calculate vertical cumulative energy map 
    cumulativeEnergyMap = cumulative_energy_map(energyMap, 'V');
    % Find the optimal vertical seam
    optimalVerticalSeam = find_optimal_vertical_seam(cumulativeEnergyMap);
    % Show vertical cumulative energy map
	figure(2);
    imagesc(cumulativeEnergyMap); 
	displaySeam(image, optimalVerticalSeam, 'v');
    % delete the seam
    %%  optimal solution, yet does not work
    %	newImage = reshape(image, [h*(w),3]);
    %   murat = [(1:h); optimalVerticalSeam];
    %   indexes = sub2ind([h,w],murat(1),murat(2));
    %	newImage(indexes) = [];
    %	newImage = reshape(newImage, h, c-1, 3);
    %%  rookie solution
    for row=1:h
        roiR = image(row,:,1);
        roiG = image(row,:,2);
        roiB = image(row,:,3);
        roiR(optimalVerticalSeam(row)) = [];
        roiG(optimalVerticalSeam(row)) = [];
        roiB(optimalVerticalSeam(row)) = [];
        newImage(row,:,1) = roiR;
        newImage(row,:,2) = roiG;
        newImage(row,:,3) = roiB;
    end
    % re-create energy map
    newEnergyMap = energy_image(newImage);
end
