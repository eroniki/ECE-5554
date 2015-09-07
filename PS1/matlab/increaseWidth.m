% TODO Add comments for the code and the function
function [newImage, newEnergyMap] = increaseWidth(image, energyMap)
    if(nargin~=2)
        errorMessage = 'Missing argument';
        error(errorMessage);
    end
    [h, w, c] = size(image);
    newImage = zeros(h, w+1,c, 'uint8');
    newEnergyMap = zeros(h, w+1);
    % Calculate vertical cumulative energy map 
    cumulativeEnergyMap = cumulative_energy_map(energyMap, 'V');
    % Find the optimal vertical seam
    optimalVerticalSeam = find_optimal_vertical_seam(cumulativeEnergyMap);
%   Show vertical cumulative energy map
	figure(2);
    imagesc(cumulativeEnergyMap); 
	displaySeam(image, optimalVerticalSeam, 'v');
%   delete the seam
%%  optimal solution, yet does not work
%	newImage = reshape(image, [h*(w),3]);
%   murat = [(1:h); optimalVerticalSeam];
%   indexes = sub2ind([h,w],murat(1),murat(2));
%	newImage(indexes) = [];
%	newImage = reshape(newImage, h, c-1, 3);
%%  rookie solution
    for row=1:h
        lower = max(optimalVerticalSeam(row)-1,1);
        higher = min(optimalVerticalSeam(row)+1, w);
        roiR = image(row,:,1);
        roiG = image(row,:,2);
        roiB = image(row,:,3);
        roiR1 = [roiR(1:optimalVerticalSeam(row)), mean(roiR(lower):roiR(higher)), roiR(optimalVerticalSeam(row)+1:end)];
        roiG1 = [roiG(1:optimalVerticalSeam(row)), mean(roiG(lower):roiG(higher)), roiG(optimalVerticalSeam(row)+1:end)];
        roiB1 = [roiB(1:optimalVerticalSeam(row)), mean(roiB(lower):roiB(higher)), roiB(optimalVerticalSeam(row)+1:end)];
        newImage(row,:,1) = roiR1;
        newImage(row,:,2) = roiG1;
        newImage(row,:,3) = roiB1;
    end
    % re-create energy map
    newEnergyMap = energy_image(newImage);
end
