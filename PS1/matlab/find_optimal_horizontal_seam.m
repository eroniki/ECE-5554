% TODO Add comments for the code and the function
function horizontalSeam = find_optimal_horizontal_seam(cumulativeEnergyMap)
    [h, w, ~] = size(cumulativeEnergyMap);    
    horizontalSeam = zeros(w,1);
    [~, horizontalSeam(w)] = min(cumulativeEnergyMap(:,w));
    for col=w-1:-1:1
        lower = max(horizontalSeam(col+1)-1,1);
        higher = min(horizontalSeam(col+1)+1,h);
        index = lower:higher;
        [~, ind] = min(cumulativeEnergyMap(index, col));
        horizontalSeam(col) = ind+lower-1;
    end    
end