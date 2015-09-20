function [error] = computeQuantizationError(origImg,quantizedImg)
    error = (origImg-quantizedImg).^2;
    error = sum(error(:));
end