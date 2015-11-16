clc; close all; clear all;
%% Set Variables
framesdir = 'frames';
siftdir = 'sift';
nClusters = 1500;
nFrames = 2000;
frameOfInterest = [56,974,1844];
nCandidate = 5;
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
        frameHist(i, idx) = frameHist(i, idx) + sum(idx == j);
    end
    clear idx
end
clear membershipCopy
%% Look for the most similar frames
normMatrice = zeros(nFrames,1);
nominator = zeros(length(frameOfInterest),nFrames);
denominator = zeros(length(frameOfInterest),nFrames);
score = zeros(length(frameOfInterest),nFrames);
for i=1:nFrames
    normMatrice(i) = norm(frameHist(i,:));
end

denominator = normMatrice(frameOfInterest)*normMatrice';
nominator = frameHist(frameOfInterest,:)*frameHist';
%%
for i=1:length(frameOfInterest)
    score(i,:) = nominator(i,:)./denominator(i,:);
    idx = isnan(score(i,:));
    score(i,idx) = 0;
    [val(i,:), id(i,:)] = sort(score(i,:), 'descend');  
    
    val(i,1:nCandidate+1)
    id(i,1:nCandidate+1)
    figure;
    for candidate=1:nCandidate+1
        imCandidate = imread(char(featureSpace.imname{id(i,candidate)}));
        subplot(1,6,candidate); imshow(imCandidate);
        imwrite(imCandidate,['../submission/fullFrame',num2str(i),'-Sample-',num2str(candidate),'.png']);
    end
end
