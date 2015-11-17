clc; close all; clear all;
%% Set Variables
framesdir = 'frames';
siftdir = 'sift';
nClusters = 300;
frameOfInterest = [232:235];
nFrames = 500;
nCandidate = 10;
%% Initialize FeatureSpace
fnames = dir([siftdir '/*.mat']);

fprintf('reading %d total files...\n', length(fnames));

N = 100;  % to visualize a sparser set of the features

featureSpace.featureMap = [];

% Loop through all the data files found
for i=1:nFrames

    fprintf('reading frame %d of %d\n', i, length(fnames));
    
    % load that file
    fname = [siftdir, '/friends_0000000', num2str(100+i), '.jpeg.mat'];
    load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    numfeats = size(descriptors,1);
    
    % read in the associated image
    imname = [framesdir '/' imname]; % add the full path
    im = imread(imname);
    fprintf('imname = %s contains %d total features, each of dimension %d\n', imname, numfeats, size(descriptors,2));
    [h,w,~]  =  size(im);
    randinds = randperm(numfeats);
    nFeatures = min([N,numfeats]);
    
%     featureSpace.featureMap = [featureSpace.featureMap; descriptors(randinds(1:min([N,numfeats])),:)];
%     featureSpace.feature(i).features = descriptors(randinds(1:min([N,numfeats])),:);
%     featureSpace.feature(i).positions = positions(randinds(1:min([N,numfeats])),:);
%     featureSpace.feature(i).scales = scales(randinds(1:min([N,numfeats])));
%     featureSpace.feature(i).orientations = orients(randinds(1:min([N,numfeats])));
%     featureSpace.feature(i).nFeatures = nFeatures;
    featureSpace.featureMap = [featureSpace.featureMap; descriptors];
    featureSpace.feature(i).features = descriptors;
    featureSpace.feature(i).positions = positions;
    featureSpace.feature(i).scales = scales;
    featureSpace.feature(i).orientations = orients;
    featureSpace.feature(i).nFeatures = numfeats;
    
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
wordList = zeros(1,nClusters);
for frame=132:132+length(frameOfInterest)-1
    figure;
    im = imread(char(featureSpace.feature(frame).imname));
    featureSpace.feature(frame).imname
    oninds = selectRegion(im, featureSpace.feature(frame).positions(1:featureSpace.feature(frame).nFeatures,:));
%     wordList(membership(oninds)) = wordList(membership(oninds))+1;
    for j=1:nClusters
        wordList(j) = wordList(j) + sum(membership(oninds) == j);
    end
    displaySIFTPatches(featureSpace.feature(frame).positions(oninds,:), featureSpace.feature(frame).scales(oninds), featureSpace.feature(frame).orientations(oninds), im); 
  %  imwrite(im,['../submission/regionQueries-FOI-',num2str(frame),'.png']);
end
%%
normMatrice = zeros(nFrames,1);
nominator = zeros(1,nFrames);
denominator = zeros(1,nFrames);
score = zeros(1,nFrames);

for i=1:nFrames
    normMatrice(i) = norm(frameHist(i,:));
end

%%
denominator = norm(wordList)*normMatrice';
nominator = wordList*frameHist';
score = nominator./denominator;
%%
% score = zeros(1,nFrames);
% for i=1:nFrames
%    score(i) = sum(wordList.*frameHist(i,:)) / (norm(wordList)*norm(frameHist(i,:)));   
% end
%%
idx = isnan(score);
score(idx) = 0;
[val, id] = sort(score, 'descend');  
val(1:nCandidate)
id(1:nCandidate)
figure;
for candidate=1:nCandidate
    imCandidate = imread(char(featureSpace.feature(id(candidate)).imname));
    subplot(1,nCandidate,candidate); imshow(imCandidate);
%    imwrite(imCandidate,['../submission/regionQueries-Sample-',num2str(candidate),'.png']);
end

