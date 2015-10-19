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

width = round(x.max - x.min);
height = round(y.max - y.min);

canvasHeight = hRef + height;
canvasWidth = wRef + width;

warpIm = zeros(height*width,3,'uint8');
mergeIm = zeros(canvasHeight,canvasWidth,3,'uint8');

Hinv = inv(H);

xx = 1:width;
yy = 1:height;
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

for i=1:width*height
    if(g(i)==1) 
%         [x(i), y(i)]
%         rangeY = max(floor(y(i)),1):min(ceil(y(i)),hRef)
%         rangeX = max(floor(x(i)),1):min(ceil(x(i)),wRef)
%         meanPixel = mean(mean(inputIm(rangeY,rangeX,:)))
%         warpIm(i,:) = meanPixel;
        warpIm(i,:) = inputIm(yr(i), xr(i), :);
    end
end

warpIm = reshape(warpIm,height,width,3);
% 
% offsetX=1;
% offsetY=1;
% 
% if(y.min<1)
%     offsetY = ceil(abs(y.min));
% end
% 
% if(x.min<1)
%     offsetX = ceil(abs(x.min));
% end
% 
% canvas = zeros(hRef+offsetY-1, wRef+offsetX-1,3);
% assignin('base', 'canvasSize', size(canvas));
% assignin('base', 'offsetX', offsetX);
% assignin('base', 'offsetY', offsetY);
% assignin('base', 'canvasPort', size(canvas(offsetY:end,offsetX:end,:)));
% canvas(offsetY:end,offsetX:end,:) = refIm;

mergeIm = imfuse(refIm,warpIm,'blend');

end

