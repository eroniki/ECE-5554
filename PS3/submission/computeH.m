function H = computeH(t1, t2)
% computeH(): Calculate homography matrix given t1 and t2 2-by-N points.  
% Murat Ambarkutuk, PS3
nPoints = numel(t1)/2;
L = zeros(2*nPoints,9);
% Homogeneous Coordinate
t1 = [t1; ones(1,nPoints)];
t2 = [t2; ones(1,nPoints)];
% Construct matrix L 
for i=1:nPoints
    L(i*2-1:2*i,:) = [t1(:,i)', zeros(1,3),-1*t2(1,i)*t1(:,i)'; zeros(1,3), t1(:,i)', -1*t2(2,i)*t1(:,i)'];
end
assignin('base','L',L);
% Find eigenvectors and matrix containing eigenvalue on primary diagonal
% elements.
[V, D] = eig(L'*L);
% Find the smallest eigen value from the diagonal elements of D
diagD = diag(D);
numDiag = numel(diagD);
% for i=1:numDiag
%     signum = sign(diagD(i));
%     if signum<0
%         D(i,:) = -1*D(i,:);
%         V(:,i) = -1*V(:,i);
%     end
% end
[minVal, minLoc] = min(diag(D));
% Reshape and assign the eigenvector corresponding to smallest eigenvalue
H = reshape(V(:,minLoc),3,3)';
end

