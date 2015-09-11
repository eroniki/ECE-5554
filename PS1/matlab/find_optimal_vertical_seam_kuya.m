% TODO Add comments for the code and the function
function verticalSeam = find_optimal_vertical_seam_kuya(cumulativeEnergyMap)
    [h, w, ~] = size(cumulativeEnergyMap);    
    verticalSeam = zeros(h,1);
    [~, verticalSeam(h)] = max(cumulativeEnergyMap(h,:));

    for row=h-1:-1:1
        lower = max(verticalSeam(row+1)-1,1);
        higher = min(verticalSeam(row+1)+1,w);
        index = lower:higher;
        [~, ind] = max(cumulativeEnergyMap(row,index));
        verticalSeam(row) = ind + lower - 1;
    end    
end