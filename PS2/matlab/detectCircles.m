function [centers, ind] = detectCircles(im, radius, useGradient)
    im = rgb2gray(im);
    [h, w, ~] = size(im);
    [Gmag,Gdir] = imgradient(im);
    edges = edge(im, 'Canny');

    Gdir = Gdir * 0.0175 + pi;

    [i, j] = find(edges == 1);

    thetaResolution = 0.1;
    angle = 0:thetaResolution:2*pi;
    angleIndex = 1:numel(angle);
    houghSpace = zeros(h,w);

    for counter=1:numel(i)
        center.y = i(counter);
        center.x = j(counter);
        if(useGradient == 1)
            theta = Gdir(center.y, center.x);
        else
            theta = angle;
        end

        for rad=1:numel(radius)
            a = center.x + radius(rad) * cos(theta);
            b = center.y + radius(rad) * sin(theta);
            a(a>w | a<1) = [];
            b(b>h | b<1) = [];
            houghSpace(round(b), round(a)) = houghSpace(round(b), round(a)) + 1;
        end    
    end
    figure; imshow(edges);
    figure; imagesc(houghSpace);
end