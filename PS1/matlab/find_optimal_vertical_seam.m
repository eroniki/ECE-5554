% TODO Add comments for the code and the function
function verticalSeam = find_optimal_vertical_seam(cumulativeEnergyMap)
    [h, w, ~] = size(cumulativeEnergyMap);    
    verticalSeam = zeros(h,1);
    [~, verticalSeam(h)] = min(cumulativeEnergyMap(h,:));
    for row=h-1:-1:1
        index = max(verticalSeam(row+1)-1,1):min(verticalSeam(row+1)+1,w);
        [~, verticalSeam(row)] = min(cumulativeEnergyMap(row,index));
    end    
end
