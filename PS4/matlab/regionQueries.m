clc; close all; clear all;
%% Set Variables
framesdir = 'frames';
siftdir = 'sift';
nClusters = 150;
frameOfInterest = [2592:2595,2598:2620];
nFrames = length(frameOfInterest);
%% Initialize FeatureSpace
fnames = dir([siftdir '/*.mat']);

fprintf('reading %d total files...\n', length(fnames));

N = 100;  % to visualize a sparser set of the features

featureSpace.featureMap = [];

% Loop through all the data files found
for i=1:nFrames

    fprintf('reading frame %d of %d\n', i, length(fnames));
    
    % load that file
    fname = [siftdir, '/friends_000000', num2str(frameOfInterest(i)), '.jpeg.mat'];
    load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    numfeats = size(descriptors,1);
    
    % read in the associated image
    imname = [framesdir '/' imname]; % add the full path
    im = imread(imname);
    fprintf('imname = %s contains %d total features, each of dimension %d\n', imname, numfeats, size(descriptors,2));
    [h,w,~]  =  size(im);
    randinds = randperm(numfeats);
    nFeatures = min([N,numfeats]);
    
    featureSpace.featureMap = [featureSpace.featureMap; descriptors];
    featureSpace.feature(i).features = descriptors;
    featureSpace.feature(i).positions = positions;
    featureSpace.feature(i).scales = scales;
    featureSpace.feature(i).orientations = orients;
    featureSpace.feature(i).nFeatures = nFeatures;
    featureSpace.feature(i).imname = cellstr(imname);
    clear descriptors positions scales orients im    
end

%% Cluster
[membership,means,rms] = kmeansML(nClusters,featureSpace.featureMap');
%% Create histogram-of-words
fprintf('start bagging\n');
frameHist = zeros(nFrames,nClusters);
membershipCopy = membership;
memberShip = cell(1,nFrames);
for i=1:nFrames
    memberShip{i} = membershipCopy(1:featureSpace.feature(i).nFeatures);
    idx = sort(membershipCopy(1:featureSpace.feature(i).nFeatures));
    membershipCopy(1:featureSpace.feature(i).nFeatures) = [];
    for j=1:nClusters
        frameHist(i, j) = frameHist(i, j) + sum(idx == j);
    end
    clear idx
end
%% Select Region
im = imread(char(featureSpace.feature(1).imname));
oninds = selectRegion(im, featureSpace.feature(1).positions(1:featureSpace.feature(1).nFeatures,:));
wordList = membership(oninds);
displaySIFTPatches(featureSpace.feature(1).positions(oninds,:), featureSpace.feature(1).scales(oninds), featureSpace.feature(1).orientations(oninds), im); 

for i=2:nFrames
    figure;
    im = imread(char(featureSpace.feature(i).imname));
    imshow(im);
    for j=1:length(wordList)
        idx = memberShip{i} == wordList(j);
        hold on;
        displaySIFTPatches(featureSpace.feature(i).positions(idx,:), featureSpace.feature(i).scales(idx), featureSpace.feature(i).orientations(idx), im); 
    end
end

% normMatrice = zeros(nFrames,1);
% nominator = zeros(length(frameOfInterest),nFrames);
% denominator = zeros(length(frameOfInterest),nFrames);
% score = zeros(length(frameOfInterest),nFrames);
% for i=1:nFrames
%     normMatrice(i) = norm(frameHist(i,:));
% end
% for i=1:nFrames
%     denominator(i,:) = normMatrice(i)*normMatrice';
%     nominator(i,:) = frameHist(i,:)*frameHist';
% end
% %%
% for i=1:length(frameOfInterest)
%     score(i,:) = nominator(i,:)./denominator(i,:);
%     idx = isnan(score(i,:));
%     score(i,idx) = 0;
%     [val(i,:), id(i,:)] = sort(score(i,:), 'descend');  
%     val(i,:)
%     id(i,:)
% %     figure;
% %     for candidate=1:5
% %         imCandidate = imread(char(featureSpace.imname{id(i,candidate)}));
% %         subplot(1,5,candidate); imshow(imCandidate);
% %     end
% end
% 
