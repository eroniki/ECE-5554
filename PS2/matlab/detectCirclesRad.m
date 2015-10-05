function [centers] = detectCirclesRad(im, radius, useGradient)
    im = rgb2gray(im);
    [h, w, ~] = size(im);
    [~,Gdir] = imgradient(im);

    Gdir = Gdir * 0.0175 + pi;

    thetaResolution = 0.01;
    angle = 0:thetaResolution:2*pi;
    
    centers.edges = edge(im, 'canny', .8);
    centers.houghSpace = zeros(h,w,numel(radius));
    centers.centers = zeros(h,w,numel(radius));
    centers.votes = zeros(numel(radius), numel(im));
    
    [i, j] = find(centers.edges == 1);

    for counter=1:numel(i)
        center.y = i(counter);
        center.x = j(counter);
        if(useGradient == 1)
            theta = Gdir(center.y, center.x);
        else
            theta = angle;
        end

        for rad=1:numel(radius)
            a = center.x - radius(rad) * cos(theta);
            b = center.y + radius(rad) * sin(theta);
            a(a>w | a<1) = [];
            b(b>h | b<1) = [];
            centers.houghSpace(round(b), round(a), rad) = centers.houghSpace(round(b), round(a), rad) + 1;
        end    
    end

    for rad=1:numel(radius)
%         centers.centers(:,:,rad) = imregionalmax(centers.houghSpace(:,:,rad));
        list = centers.houghSpace(:,:,rad);
        votes = centers.votes(rad,:);
        meanVote = mean(votes);
        votes(votes<meanVote) = [];
        centers.votes(rad,:) = votes;
        [centers.votes(rad,:), orderedIndices] = sort(list(:), 'descend');    
        centers.centers(:,:,rad) = reshape(orderedIndices, h, w);
    end    
    
       
end