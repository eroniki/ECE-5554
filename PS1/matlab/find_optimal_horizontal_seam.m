% TODO Add comments for the code and the function
function horizontalSeam = find_optimal_horizontal_seam(cumulativeEnergyMap)
    [h, w, ~] = size(cumulativeEnergyMap);    
    horizontalSeam = zeros(2, w);
    horizontalSeam(1,w) = w;
    [~, horizontalSeam(2,w)] = min(cumulativeEnergyMap(:,w));
    for col=w-1:1
        index = horizontalSeam(2, w)-1:horizontalSeam(2, w)+1;
        index(index<1) = [];
        index(index>w) = [];
        horizontalSeam(2, col) = cumulativeEnergyMap(index,col);
        horizontalSeam(1, col) = col;
    end    
end
