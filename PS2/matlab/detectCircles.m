function [centers] = detectCircles(im, radius, useGradient)
    im = rgb2gray(im);
    [h, w, ~] = size(im);
    [~,Gdir] = imgradient(im);

    Gdir = Gdir * 0.0175 + pi;

    thetaResolution = 0.01;
    angle = 0:thetaResolution:2*pi;

    centers.edges = edge(im, 'canny', .8, 6);

    centers.houghSpace = zeros(h,w);
    centers.centers = zeros(h,w,1);
    centers.votes = zeros(h,w);
    
    [i, j] = find(centers.edges == 1);

    for counter=1:numel(i)
        center.y = i(counter);
        center.x = j(counter);
        if(useGradient == 1)
            theta = Gdir(center.y, center.x);
            theta = [theta; theta - pi];
        else
            theta = angle;            
        end
        a = center.x + radius * cos(theta);
        b = center.y + radius * sin(theta);
        a(a>w | a<1) = [];
        b(b>h | b<1) = [];
        centers.houghSpace(round(b), round(a)) = centers.houghSpace(round(b), round(a)) + 1;
            
    end

	list = centers.houghSpace;
    meanVote = mean(centers.votes(:));
    centers.votes(centers.votes<meanVote) = [];
    [centers.votes, orderedIndices] = sort(list(:), 'descend');    
    centers.centers = reshape(orderedIndices, h, w);       
    
    [y,x] = ind2sub(size(centers.centers), centers.centers);
    centers.coordinates = [x(1:20)', y(1:20)'];    
end