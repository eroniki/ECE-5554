% TODO Add comments for the code and the function
function verticalSeam = find_optimal_vertical_seam(cumulativeEnergyMap)
    [h, w, ~] = size(cumulativeEnergyMap);    
    verticalSeam = zeros(2, h);
    verticalSeam(1,h) = h;
    [~, verticalSeam(2,h)] = min(cumulativeEnergyMap(h,:));
    for row=h-1:1
        index = max(verticalSeam(2, row)-1,1):min(verticalSeam(2, row)+1,w)
        [~, verticalSeam(2, row)] = min(cumulativeEnergyMap(row,index));
        verticalSeam(1, row) = row;
    end    
end
