clc; close all; clear all;

framesdir = 'frames';
siftdir = 'sift';
 
fnames = dir([siftdir '/*.mat']);

fprintf('reading %d total files...\n', length(fnames));

N = 100;  % to visualize a sparser set of the features

featureSpace.features = []
featureSpace.scales = [];
featureSpace.orientations = [];
featureSpace.positions = [];
featureSpace.frameID = [];

% Loop through all the data files found
for i=1:length(fnames)

    fprintf('reading frame %d of %d\n', i, length(fnames));
    
    % load that file
    fname = [siftdir '/' fnames(i).name];
    load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    numfeats = size(descriptors,1);
    
    % read in the associated image
    imname = [framesdir '/' imname]; % add the full path
    im = imread(imname);

    
    % display the image and its SIFT features drawn as squares
    fprintf('imname = %s contains %d total features, each of dimension %d\n', imname, numfeats, size(descriptors,2));
    imshow(im);
    displaySIFTPatches(positions, scales, orients, im); % a provided function
    title('showing all features');
    fprintf('hit a key to continue.\n');
%     pause;
    
    % now display the same image but only show N of the features
    fprintf('now showing a random subset of %d of those for visualization purposes only...\n', N);
    randinds = randperm(numfeats);
    clf;
    imshow(im);
    min([N,numfeats])
    displaySIFTPatches(positions(randinds(1:min([N,numfeats])),:), scales(randinds(1:min([N,numfeats]))), orients(randinds(1:min([N,numfeats]))), im); 
    title('showing N features');
    fprintf('hit a key to continue.\n');
    featureSpace.features = [featureSpace.features; descriptors(randinds(1:min([N,numfeats])),:)];
    featureSpace.positions = [featureSpace.positions; positions(randinds(1:min([N,numfeats])),:)];
    featureSpace.scales= [featureSpace.scales; scales(randinds(1:min([N,numfeats])),:)];
    featureSpace.orientations = [featureSpace.orientations; orients(randinds(1:min([N,numfeats])),:)];
    featureSpace.frameID = [featureSpace.frameID; imname];
%     pause;
%     
    clear descriptors positions scales orients im
    
end
