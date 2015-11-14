function [warpIm, mergeIm] = warpImage(inputIm, refIm, H)
% warpImage(): Warp inputIm with respect to H to refIm.
% Murat Ambarkutuk, PS3

[hInput,wInput,~] = size(inputIm); 
[hRef,wRef,~] = size(refIm); 

corners = [1,   1,  wInput, wInput; 
           1,   hInput, 1,  hInput;
           1,   1,  1,  1];  
        
cornersWarped = H*corners;
cornersWarped = normalizeHomogeneous(cornersWarped)

x.min = min(cornersWarped(1,:));
x.max = max(cornersWarped(1,:))
y.min = min(cornersWarped(2,:));
y.max = max(cornersWarped(2,:))

width = ceil(x.max - x.min);
height = ceil(y.max - y.min);

warpIm = zeros(height*width,3,'uint8');

Hinv = inv(H);

xx = x.min:x.max;
yy = y.min:y.max;
assignin('base', 'xx', size(xx));
assignin('base', 'yy', size(yy));
[X,Y] = meshgrid(xx,yy);

pointsProjected = [X(:)'; Y(:)'; ones(1,numel(X))];
pointsSource = Hinv*pointsProjected;
pointsSource = normalizeHomogeneous(pointsSource);
pointsSource(3,:,:) = [];

x__ = pointsSource(1,:);
y__ = pointsSource(2,:);

xr = round(x__);
yr = round(y__);
g = xr>=1 & yr>=1 & xr<wInput & yr<hInput;
assignin('base', 'xr', size(xr));
assignin('base', 'g', size(g));

for i=1:width*height
    if(g(i)==1) 
        warpIm(i,:) = inputIm(yr(i), xr(i), :);
        
    end
end

warpIm = reshape(warpIm,height,width,3);
% 
offsetX=1;
offsetY=1;

if(y.min<1)
    offsetY = round(abs(y.min));
end

if(x.min<1)
    offsetX = round(abs(x.min));
end
% 

canvas = zeros(hRef+offsetY-1, wRef+offsetX-1,3, 'uint8');
assignin('base', 'canvasSize', size(canvas));
assignin('base', 'offsetX', offsetX);
assignin('base', 'offsetY', offsetY);
assignin('base', 'canvasPort', size(canvas(offsetY:end,offsetX:end,:)));
canvas(offsetY:end,offsetX:end,:) = refIm;
mergeIm = imfuse(warpIm,canvas*1.8,'blend');
end
