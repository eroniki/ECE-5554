function [centers, ind] = detectCircles(im, radius, useGradient)
    im = rgb2gray(im);
    [h, w, ~] = size(im);
    [Gmag,Gdir] = imgradient(im);
    edges = Gmag>mean(Gmag(:));
    
    [i, j] = find(edges == 1);
    
    thetaResolution = 0.1;
    angle = 0:thetaResolution:2*pi;
    angleIndex = 1:numel(theta);
    houghSpace = zeros(h,w,numel(theta));
    
    for counter=1:numel(i)
        center.x = i(counter); center.y = j(counter);
        if(useGradient == 1)
            theta = 
        end
            
        a = center.x -radius * cos(theta)
                
    end
    
end