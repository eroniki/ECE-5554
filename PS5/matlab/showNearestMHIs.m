clc; clear all; close all;
%% Init
actions = {'botharms', 'crouch', 'leftarmup', 'punch', 'rightkick'};
sequences = {'-p1-1', '-p1-2', '-p2-1', '-p2-2'};
basedir = '../database/';
allMHIs = zeros(480,640,20);
huVectors = zeros(20,7);
trainLabels = [1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5];
nActions = length(actions);
nSequences = length(sequences);
testAction = randi(nActions*nSequences);
counter = 1;
nNeighbour = 4;
%% Loop-over sequences to create MHIs
for i=1:nActions
    for j=1:nSequences
        subdir = [basedir, actions{i}, '/', actions{i}, sequences{j}, '/'];
        H = computeMHI(subdir);
        allMHIs(:, :, counter) = H;
        figure(getFigureID()); imagesc(H); title(['Action: ', actions{i}, ' Sequence: ', sequences{j}]);
        saveas(getFigureID()-1, ['MHI-', actions{i}, sequences{j}, '.png'],'png');
        counter = counter+1;
    end
end
%% Show MHI of the chosen action
[sequenceID, actionID] = ind2sub([nSequences, nActions],testAction);
figure(getFigureID()); imagesc(allMHIs(:,:,testAction)); title(['The test HMI (Action: ', ...
    actions{actionID}, ' Sequence: '...
        num2str(sequenceID),')']);
saveas(getFigureID()-1, ['test-MHI', actions{actionID}, sequences{sequenceID}, '.png'],'png');
    
%% Calculate Hu moments
for i=1:nActions*nSequences
    huVectors(i,:) = huMoments(allMHIs(:,:,i));    
end    
%% Nearest Neighbour Classifier
predictedLabel = predictAction(huVectors(testAction,:), huVectors, trainLabels);
%% Visualization
for i=2:nNeighbour+1
    [sequenceID, actionID] = ind2sub([nSequences, nActions],label(i));
    figure(getFigureID()); imagesc(allMHIs(:,:,label(i))); title(['The neearest neighbor (n:', ...
        num2str(i-1), ') Action: ', actions{actionID}, ' Sequence: '...
        num2str(sequenceID)]);
    saveas(getFigureID()-1, ['matched-', actions{actionID}, sequences{sequenceID},'-k-',num2str(i-1), '.png'],'png');
end

%% Save accumulated MHIs to a mat file
save('allMHIs.mat', 'allMHIs');
save('huVectors.mat', 'huVectors');