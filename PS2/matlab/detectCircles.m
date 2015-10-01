function [centers, ind] = detectCircles(im, radius, useGradient)
    [h, w, ~] = size(im);
    
    houghSpace = zeros(h,w);
    theta.x= linspace(0,2*pi,h);
    theta.y= linspace(0,2*pi,w);
    
    if(useGradient==1)

        im = rgb2gray(im);

        [Gmag,Gdir] = imgradient(im);
        edges = uint8(Gmag);

        edges = edges>mean(Gmag(:));
        imshow(edges)
    %     for i=1:h
    %         for j=1:w
    %             if(edges == 1)
    %                 ind.x = radius * cos(theta) +.x;
    %                 ind.y = radius * sin(theta) +center.y;
    %                 houghSpace(ind.x,ind.y) = houghSpace(ind.x,ind.y) + 1;
    %             end
    %         end
    %     end         
        i=1:h;
        j=1:w;

        ind.x = radius * cos(theta.x) + i
        ind.y = radius * sin(theta.y) + j
        houghSpace(ind.x,ind.y) = houghSpace(ind.x,ind.y) + 1;
        centers = houghSpace;
	end
end