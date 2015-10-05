function [bw] = morphologicalEdges(im)
    bw = im2bw(im);
    bw = imfill(bw, 'holes');
    se1 = strel('disk',3);
    bw = imclose(bw,se1);
    bw = imfill(bw, 'holes');
%     edges = bw - imopen(bw, se1);
%     edges = bw - imerode(bw, se1);
%     se2 = strel('square',3);
%     edges = bw - imerode(bw, se2);
end

