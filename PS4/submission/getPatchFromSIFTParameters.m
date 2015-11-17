function [patch] = getPatchFromSIFTParameters(position, scale, orient, im)
% position is 2d vector, scale and orient are scalars;
% im is the image from which the patch will be grabbed.
%
% returns in 'patch' the rotated patch from the original image,
% corresponding to the ROI defined by the SIFT keypoint.


if(size(im,3)~=1)
    fprintf('expected grayscale image\n');
    keyboard;
end


row = position(2);
col = position(1); 
angle=orient;

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

s=radius*2+1;
x1=tlr(2);x2=brr(2);y1=tlr(1);y2=brr(1);
xdata=[1 s];ydata=[1 s];
t=cp2tform([x1 y1;x2 y2],[1,1;s,s],'linear conformal');
patch=imtransform(im,t,'xdata',xdata,'ydata',ydata,'Size',[s s]);
patch=patch(2:end-1,2:end-1);
linec=[tlr+[1;1] trr+[1;-1] brr+[-1;-1] blr+[-1;1]];

