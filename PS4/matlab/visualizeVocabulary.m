clc; close all; clear all;
%% Set Variables
framesdir = 'frames';
siftdir = 'sift';
nClusters = 750;
nPatches = 20;
nFrames = 500;
mkdir('vocabulary');
%% Initialize FeatureSpace
featureSpace = createFeatureSpace(framesdir, siftdir, nFrames);
%% Cluster descriptors into words
fprintf('start clustering');
[membership,means,rms] = kmeansML(nClusters,featureSpace.features');
%% Create histogram-of-words
fprintf('start bagging');
frameHist = zeros(nFrames,nClusters);
membershipCopy = membership;
memberShip = cell(1,nFrames);
for i=1:nFrames
    memberShip{i} = membershipCopy(1:featureSpace.frameID(i));
    idx = sort(membershipCopy(1:featureSpace.frameID(i)));
    membershipCopy(1:featureSpace.frameID(i)) = [];
    for j=1:nClusters
        frameHist(i, j) = frameHist(i, j) + sum(idx == j);
    end
    clear idx
end
clear membershipCopy
%% Vizualize some words
fprintf('Start saving to file');
for word=1:nClusters
    mkdir(['vocabulary/W', num2str(word)]);
    x = find(frameHist(:,word) > 0);
    randomFrames = x(randperm(length(x)));
    randomFrames = randomFrames(1:min(length(randomFrames),nPatches));
    clear x;
    for j=1:min(length(randomFrames),nPatches)
        x = find(memberShip{randomFrames(j)} == word)
        str = [num2str(j), 'th patch comes from ',  num2str(x'), 'th image (', num2str(word), 'th word matches in the image)']
        idx = featureSpace.frameCumulative(randomFrames(j))+x;
        im = rgb2gray(imread(char(featureSpace.imname{randomFrames(j)})));
        patch = getPatchFromSIFTParameters(featureSpace.positions(idx(1),:), featureSpace.scales(idx(1)), featureSpace.orientations(idx(1)), im);
        imwrite(patch,['vocabulary/W',num2str(word),'/P',num2str(j),'.png']);
    end
    
%     memberShip{randomFrames
%     fname = featureSpace.imname{i};
%     im = imread(char(fname));
%     patch = getPatchFromSIFTParameters(position, scale, orient, im);
end