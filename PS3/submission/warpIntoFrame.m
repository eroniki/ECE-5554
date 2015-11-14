function [warpIm, mergeIm] = warpIntoFrame(inputIm, refIm, H)
% warpIntoFrame(): Warp inputIm with respect to H to refIm.
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

width = ceil(x.max-x.min);
height = ceil(y.max-y.min);

warpIm = zeros(height*width,3,'uint8');

Hinv = inv(H);

xx = (x.min):(x.max);
yy = (y.min):(y.max);
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
%         canvasWarped(i,:) = inputIm(yr(i), xr(i), :);
    end
end

warpIm = reshape(warpIm,height,width,3);
% mergeIm = reshape(canvasWarped,hRef,wRef,3);
offsetY = ceil(abs(y.min));
offsetX = ceil(abs(x.min));

canvasWarped = zeros(offsetY+height-1, offsetX+width-1,3, 'uint8');
assignin('base', 'canvasSize', size(canvasWarped));
assignin('base', 'offsetX', offsetX);
assignin('base', 'offsetY', offsetY);
assignin('base', 'canvasPort', size(canvasWarped(offsetY:end,offsetX:end,:)));
canvasWarped(offsetY:end,offsetX:end,:) = warpIm;


% warpIm = canvasWarped;

mergeIm = imfuse(canvasWarped,refIm, 'blend');
end

