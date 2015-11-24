function predictedLabel = predictAction(testMoments, trainMoments, trainLabels)
    predictedLabel = -1;
    [h,~] = size(trainMoments);
    distances = zeros(h,1);
    % Calculate distances
    variance = var(trainMoments);
    for i=1:h
        distances(i) = sqrt(sum(((trainMoments(i,:)-testMoments).^2)./variance));
    end
    [Y, I] = sort(distances);
    predictedLabel = trainLabels(I(2));
    assignin('base','label', I);
    assignin('base','distances', Y);
end

