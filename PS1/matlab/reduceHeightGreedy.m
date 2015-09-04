% TODO Add comments for the code and the function
function [newImage, newEnergyMap] = reduceHeightGreedy(image, energyMap)
    if(nargin~=2)
        errorMessage = 'Missing argument';
        error(errorMessage);
    end
    [h, w, c] = size(image);
    newImage = zeros(h-1, w,c, 'uint8');
    newEnergyMap = zeros(h-1, w);
%   Find the optimal horizontal seam
    optimalHorizontalSeam = find_optimal_horizontal_seam(energyMap);
	displaySeam(image, optimalHorizontalSeam, 'h');
%   delete the seam
%%  optimal solution, yet does not work
%	newImage = reshape(image, [h*(w),3]);
%   murat = [(1:h); optimalVerticalSeam];
%   indexes = sub2ind([h,w],murat(1),murat(2));
%	newImage(indexes) = [];
%	newImage = reshape(newImage, h, c-1, 3);
%%  rookie solution
    for col=1:w
        roiR = image(:,col,1);
        roiG = image(:,col,2);
        roiB = image(:,col,3);
        roiR(optimalHorizontalSeam(col)) = [];
        roiG(optimalHorizontalSeam(col)) = [];
        roiB(optimalHorizontalSeam(col)) = [];
        newImage(:,col,1) = roiR;
        newImage(:,col,2) = roiG;
        newImage(:,col,3) = roiB;
    end
    % re-create energy map
    newEnergyMap = energy_image(newImage);
end
