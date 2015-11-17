function [oninds] = selectRegion(im, positions)
% takes as input the image to show, as well as the positions where
% it has SIFT descriptors extracted.
% Displays the image, then lets a user select a polygonal region.
% Then it determines which of the given positions fall within that region,
% and returns a list of indices into positions telling which points are within the region.

imshow(im);

h = impoly(gca, []);
api = iptgetapi(h);
nextpos = api.getPosition();

ptsin = inpolygon(positions(:,1), positions(:,2), nextpos(:,1), nextpos(:,2));
oninds = find(ptsin==1); % these are the indices into the SIFT desc and positions that fall within the polygon region
