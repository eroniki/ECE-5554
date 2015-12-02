function predictedLabel = predictAction(testMoments, trainMoments, trainLabels)
    predictedLabel = -1;
    [h,~] = size(trainMoments);
    distances = zeros(h,1);
%     sequenceMatched = 1:h;
    % Calculate variances for normalized euclidian distance
    variance = nanvar(trainMoments);
    for i=1:h
        % calculate distances
        distances(i) = sqrt(sum(((trainMoments(i,:)-testMoments).^2)./variance));
    end
    [Y, I] = sort(distances);
%     Confusion Matrix for Murat.
%     predictedLabel = trainLabels(I(2));

    predictedLabel = mode(trainLabels(I(1:4)));
    assignin('base','label', I);
    assignin('base','distances', Y);
%     assignin('base','sequenceMatched', sequenceMatched(I));
end

