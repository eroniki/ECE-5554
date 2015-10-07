function [centers] = detectCirclesRadii(im, radii, useGradient)
    im = rgb2gray(im);
    [h, w, ~] = size(im);
    [~,Gdir] = imgradient(im);

    Gdir = Gdir * 0.0175 + pi;

    thetaResolution = 0.01;
    angle = 0:thetaResolution:2*pi;

    centers.edges = edge(im, 'canny', .8, 6);

    centers.houghSpace = zeros(h,w,numel(radii));
    centers.centers = zeros(h,w,numel(radii));
    centers.votes = zeros(h,w,numel(radii));
    
    [i, j] = find(centers.edges == 1);

    for counter=1:numel(i)
        center.y = i(counter);
        center.x = j(counter);
        if(useGradient == 1)
            theta = [Gdir(center.y, center.x); Gdir(center.y, center.x)- pi];
        else
            theta = angle;            
        end
        for radIndex=1:numel(radii)
            a = center.x + radii(radIndex) * cos(theta);
            b = center.y + radii(radIndex) * sin(theta);
            a(a>w | a<1) = [];
            b(b>h | b<1) = [];
            centers.houghSpace(round(b), round(a), radIndex) = centers.houghSpace(round(b), round(a), radIndex) + 1;
        end
        
    end
    for radIndex=1:numel(radii)
        list = centers.houghSpace(:,:,radIndex);
        [orderedVotes, orderedIndices] = sort(list(:), 'descend');   
        centers.votes(:,:,radIndex) = reshape(orderedVotes, h,w);
        centers.centers(:,:,radIndex) = reshape(orderedIndices, h, w);
    end
   
end