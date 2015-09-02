% TODO Add comments for the code and the function
function verticalSeam = find_optimal_vertical_seam(cumulativeEnergyMap)
    [h, w, ~] = size(cumulativeEnergyMap);    
    verticalSeam = zeros(2, h);
    verticalSeam(1,h) = h;
    [~, verticalSeam(2,h)] = min(cumulativeEnergyMap(h,:));
    for row=h-1:1
        index = verticalSeam(2, h)-1:verticalSeam(2, h)+1;
        index(index<1) = [];
        index(index>w) = [];
        verticalSeam(2, row) = cumulativeEnergyMap(row,index);
        verticalSeam(1, row) = row;
    end    
end
