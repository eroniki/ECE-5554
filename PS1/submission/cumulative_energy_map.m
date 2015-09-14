% TODO Add comments for the code and the function
function [cumulativeEnergyMap] = cumulative_energy_map(energyMap, direction)
    if(nargin~=2)
        errorMessage = 'Missing argument';
        error(errorMessage);
    end
    
    [h, w, ~] = size(energyMap);
    cumulativeEnergyMap = zeros(h,w);
    
    if('v' == lower(direction(1)))
        for row=2:h
            for col=1:w
                index = max(col-1,1):min(col+1,w);
                cumulativeEnergyMap(row,col) = energyMap(row,col)+min(cumulativeEnergyMap(row-1,index));
            end
        end
    elseif('h' == lower(direction(1)))
        for col=2:w
            for row=1:h
                index = max(row-1,1):min(row+1,h);
                cumulativeEnergyMap(row,col) = energyMap(row,col)+min(cumulativeEnergyMap(index, col-1));
            end
        end
    else 
        error('bad argumentation / wrong direction keyword');
    end
end
