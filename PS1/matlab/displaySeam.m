% TODO Add comments for the code and the function
function displaySeam(image, seam, direction)
    if(nargin~=3)
        errorMessage = 'Missing argument';
        error(errorMessage);
    end
    figure(3);
    imshow(image);
    hold on;
    [h, w, c] = size(image);
    if('v' == lower(direction(1)))
        plot(seam, 1:h, 'w*');
    elseif('h' == lower(direction(1)))
        plot(1:w, seam, 'w*');
    end    
%     hold off;
end
