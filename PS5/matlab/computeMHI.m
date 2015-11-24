function H = computeMHI(address)
%   Get the depth file locations
    depthfiles = dir([address, '/*.pgm']);
    nFrames = length(depthfiles);
%   Thresholds moving pixels and the lenght of the sequence will be used.
    tau = nFrames;
    threshold = 600;    
    previousFrame = imread([address, depthfiles(1).name]);    
    D = zeros(nFrames, 480, 640, 'uint8');
    H = zeros(nFrames, 480, 640, 'uint8');

    for i=2:nFrames        
        depth = imread([address, depthfiles(i).name]);
        diff = abs(previousFrame-depth);
        indices = diff>=threshold;
        assignin('base','indices', indices);
%   Binary image sequence indicating motion locations (moving pixels)
        D(i, indices) = 255;
        H(i, indices) = tau;
        H(i, ~indices) = H(i-1, ~indices)-1;
        previousFrame = depth;
%%  Visualization for debug purposes
%         figure(1); imagesc(reshape(D(i,:),480,640));
%         figure(2); imagesc(reshape(H(i,:),480,640));
%%  Morphological Filters
%         se = strel('square', 3);
%         afterOpening = imerode(diff,se);
%         figure(2); imshow(afterOpening);
    end
%   Extend energy image and motion history image to the workspace (DEBUG)
%     assignin('base','D', D);
    assignin('base','H_series', H);
    H = double(H);
    H = H(nFrames,:)/max(H(nFrames,:));
    H =reshape(H, 480,640);
end

