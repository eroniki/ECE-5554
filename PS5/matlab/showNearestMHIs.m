clc; clear all; close all;
%% Init
actions = {'botharms', 'crouch', 'leftarmup', 'punch', 'rightkick'};
sequences = {'-p1-1', '-p1-2', '-p2-1', '-p2-2'};
basedir = '../database/';
allMHIs = zeros(480,640,20);
trainLabels = [1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5];
huVectors = zeros(20,7);
nActions = length(actions);
nSequences = length(sequences);
% testAction = randi(nActions*nSequences);
testAction=13;
counter = 1;
nNeighbour = 4;
%% Loop-over sequences to create MHIs
for i=1:nActions
    for j=1:nSequences
        subdir = [basedir, actions{i}, '/', actions{i}, sequences{j}, '/'];
        H = computeMHI(subdir);
        allMHIs(:, :, counter) = H;
        figure(getFigureID()); imagesc(H); title(['Action: ', actions{i}, ' Sequence: ', sequences{j}]);
        saveas(getFigureID()-1, ['../submission/MHI-', actions{i}, sequences{j}, '.png'],'png');
        counter = counter+1;
    end
end
%% Calculate Hu moments
for i=1:nActions*nSequences
    huVectors(i,:) = huMoments(allMHIs(:,:,i));    
end  
%% Nearest Neighbour Classifier
predictedLabel = predictAction(huVectors(testAction,:), huVectors, trainLabels);
%% Visualization
[sequenceID, actionID] = ind2sub([nSequences, nActions],testAction);
figure(getFigureID()); subplot(3,2,1); imagesc(allMHIs(:,:,testAction)); title(['The test HMI (Action: ', ...
    actions{actionID}, ' Sequence: '...
        num2str(sequenceID),')']);
for i=1:nNeighbour
    [sequenceID, actionID] = ind2sub([nSequences, nActions],label(i));
    subplot(3,2,i+1); imagesc(allMHIs(:,:,label(i))); title(['The neearest neighbor (n:', ...
        num2str(i), ') Action: ', actions{actionID}, ' Sequence: '...
        num2str(sequenceID)]);
end
saveas(getFigureID()-1, ['../submission/matched-', num2str(testAction), '-', num2str(label(i)), actions{actionID}, sequences{sequenceID},'-k-',num2str(i-1), '.png'],'png');

%% Save accumulated MHIs and huVectors to a mat file
save('../submission/allMHIs.mat', 'allMHIs');
save('../submission/huVectors.mat', 'huVectors');