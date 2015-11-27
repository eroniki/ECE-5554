function predictedLabel = predictActionExperimental(testMoments, trainMoments, trainLabels)
    predictedLabel = -1;
    [h,~] = size(trainMoments);
    distances = zeros(h,1);
    % Calculate distances
    variance = var(trainMoments);

    for i=1:h
%         similarity = (sum(trainMoments(i,:).*testMoments)...
%             -(numel(testMoments)*mean(testMoments)*trainMoments(i,:)))/...
%             (std(trainMoments(i,:))*std(testMoments));
%         %         sumX = sum(similarity)

        distances(i) = norm(trainMoments(i,:)-testMoments)
    end
    [Y, I] = sort(distances,'descend');


    predictedLabel = trainLabels(I(2));
    assignin('base','label', I);
    assignin('base','distances', Y);
    assignin('base','sequenceMatched', trainLabels(I));
end

