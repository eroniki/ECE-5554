% TODO Add comments for the code and the function
function [newImage, newEnergyMap] = reduceWidth(image, energyMap)
    if(nargin~=2)
        errorMessage = 'Missing argument';
        error(errorMessage);
    end
	[h, w, c] = size(image);
    newImage = zeros(h-1, w,c);
    newEnergyMap = zeros(h-1, w);
    % Calculate horizontal cumulative energy map
    cumulativeEnergyMap = cumulative_energy_map(energyMap, 'h');
	% Find the optimal horizontal seam
    optimalHorizontalSeam = find_optimal_horizontal_seam(cumulativeEnergyMap);
	% Show horizontal cumulative energy map
    figure(2);
    imagesc(cumulativeEnergyMap);
    displaySeam(image, optimalHorizontalSeam, 'h');
end
