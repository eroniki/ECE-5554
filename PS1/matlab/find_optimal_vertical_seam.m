% TODO Add comments for the code and the function
function verticalSeam = find_optimal_vertical_seam(cumulativeEnergyMap)
    [h, w, ~] = size(cumulativeEnergyMap);    
    verticalSeam = zeros(h,1);
    [~, verticalSeam(h)] = min(cumulativeEnergyMap(h,:));

    for row=h-1:-1:1
        lower = max(verticalSeam(row+1)-1,1);
        higher = min(verticalSeam(row+1)+1,w);
        index = lower:higher;
        [~, verticalSeam(row)] = min(cumulativeEnergyMap(row,index));
        verticalSeam(row) = verticalSeam(row) + lower;
    end    
end
