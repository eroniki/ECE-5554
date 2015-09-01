% TODO Add comments for the code and the function
function [cumulativeEnergyMap] = cumulative_enegy_map(energyMap, direction)
    if(nargin~=2)
        errorMessage = 'Missing argument';
        error(errorMessage);
    end
    
    cumulativeEnergyMap = zeros(size(energyMap));
	minVal = 0;
    
    if('v' == lower(direction(1)))
        for row=2:size(energyMap,1)
            for col=1:size(energyMap,2)
                if(col~=1)
                    minVal= min(cumulativeEnergyMap(row-1,col-1), minVal);
                elseif(col~=size(energyMap,2))
                    minVal = min(cumulativeEnergyMap(row-1, col+1), minVal);
                end
                cumulativeEnergyMap(row,col) = energyMap(row,col)+min(cumulativeEnergyMap(row-1,col),minVal);
            end
        end
    elseif('h' == lower(direction(1)))
        % TODO Implement horizontal version
    end
end
