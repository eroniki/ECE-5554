% TODO Add comments for the code and the function
function horizontalSeam = find_optimal_horizontal_seam(cumulativeEnergyMap)
    [h, w, ~] = size(cumulativeEnergyMap);    
    horizontalSeam = zeros(h,1);
    [~, horizontalSeam(h)] = min(cumulativeEnergyMap(:,w));
    for col=w-1:-1:1
        index = max(horizontalSeam(col+1)-1,1):min(horizontalSeam(col+1)+1,w);
        [~, horizontalSeam(col)] = min(cumulativeEnergyMap(index, col));
    end    
end
