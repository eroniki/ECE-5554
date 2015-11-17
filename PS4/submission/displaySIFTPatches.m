function displaySIFTPatches(positions, scales, orients, im)
% position is n x 2, scale and orient are n x 1 vectors.
% im is the original image in which the patches were detected.
% This function shows the image with the patches outlined on top of it.

patchcolor = 'c';
linew = 2;

N = size(positions,1);

if(length(scales)~=N | length(orients)~=N)
    fprintf('expected all params to have same length\n');
    keyboard;
end


for i=1:N
    row=positions(i,2);
    col=positions(i,1);
    scale=scales(i);
    angle=orients(i);

    magStep=3;
    indexSize=4;
    radius=fix(scale*magStep*(indexSize+1)/2);

    tl=[row-radius;col-radius];
    br=[row+radius;col+radius];
    bl=[row+radius;col-radius];
    tr=[row-radius;col+radius];

    rot=[cos(angle-pi/2) sin(angle-pi/2);-sin(angle-pi/2) cos(angle-pi/2)];
    tlr=round(rot'*(tl-[row;col])+[row;col]);
    brr=round(rot'*(br-[row;col])+[row;col]);
    trr=round(rot'*(tr-[row;col])+[row;col]);
    blr=round(rot'*(bl-[row;col])+[row;col]);
    
    corners{i}=[tlr+[1;1] trr+[1;-1] brr+[-1;-1] blr+[-1;1]];
end




hold on;
for i=1:N
    line(corners{i}(2,[1:4,1]), corners{i}(1,[1:4,1]), 'Color', patchcolor, 'LineWidth', linew);
end
