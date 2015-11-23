clc; clear all; close all;
%% Init
actions = {'botharms', 'crouch', 'leftarmup', 'punch', 'rightkick'};
sequences = {'-p1-1', '-p1-2', '-p2-1', '-p2-2'};
basedir = '../database/';
allMHIs = zeros(480,640,20);
counter = 1;
%% Loop-over sequences to create MHIs
for i=1:length(actions)
    for j=1:length(sequences)
        subdir = [basedir, actions{i}, '/', actions{i}, sequences{j}, '/'];
        H = computeMHI(subdir);
        allMHIs(:, :, counter) = H;
        figure(counter); imagesc(H);
%         saveas(counter, ['MHI-', actions{i}, sequences{j}, '.png'],'png');
        counter = counter+1;
    end
end
%% Save accumulated MHIs to a mat file
save('allMHIs.mat', 'allMHIs');