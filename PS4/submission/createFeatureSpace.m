function [featureSpace] = createFeatureSpace(framesdir, siftdir, nFrames)
fnames = dir([siftdir '/*.mat']);

fprintf('reading %d total files...\n', length(fnames));

N = 100;  % to visualize a sparser set of the features

featureSpace.features = [];
featureSpace.scales = [];
featureSpace.orientations = [];
featureSpace.positions = [];
featureSpace.frameID = [];
featureSpace.imname = cell(nFrames,1);

% Loop through all the data files found
for i=1:nFrames

    fprintf('reading frame %d of %d\n', i, length(fnames));
    
    % load that file
    fname = [siftdir '/' fnames(i).name];
    load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    numfeats = size(descriptors,1);
    
    % read in the associated image
    imname = [framesdir '/' imname]; % add the full path
    im = imread(imname);
    fprintf('imname = %s contains %d total features, each of dimension %d\n', imname, numfeats, size(descriptors,2));
    
    randinds = randperm(numfeats);
    nFeatures = min([N,numfeats]);
    
    featureSpace.features = [featureSpace.features; descriptors(randinds(1:min([N,numfeats])),:)];
    featureSpace.positions = [featureSpace.positions; positions(randinds(1:min([N,numfeats])),:)];
    featureSpace.scales= [featureSpace.scales; scales(randinds(1:min([N,numfeats])),:)];
    featureSpace.orientations = [featureSpace.orientations; orients(randinds(1:min([N,numfeats])),:)];
    featureSpace.frameID = [featureSpace.frameID; nFeatures];
    featureSpace.imname{i} = cellstr(imname);
    clear descriptors positions scales orients im
    
end
featureSpace.frameCumulative = [0; cumsum(featureSpace.frameID)];


end

