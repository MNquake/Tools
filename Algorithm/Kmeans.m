function [cluster, centr,iterations] = Kmeans(k, P)

%kMeans Clusters data points into k clusters.
%   Input args: k: number of clusters; 
%   points: m-by-n matrix of n m-dimensional data points.
%   Output args: cluster: 1-by-n array with values of 0,...,k-1
%   representing in which cluster the corresponding point lies in
%   centr: m-by-k matrix of the m-dimensional centroids of the k clusters


numP = size(P,2); % number of points
dimP = size(P,1); % dimension of points


%% Choose k data points as initial centroids

% choose k unique random indices between 1 and size(P,2) (number of points)
randIdx = randperm(numP,k);
% initial centroids
centr = P(:,randIdx);


%% Repeat until stopping criterion is met

% init cluster array
cluster = zeros(1,numP); %F矩阵

% init previous cluster array clusterPrev (for stopping criterion)
clusterPrev = cluster;

% for reference: count the iterations
iterations = 0;

% init stopping criterion
stop = false; % if stopping criterion met, it changes to true

while stop == false
    
    % for each data point 
    for idxP = 1:numP
        % init distance array dist
        dist = zeros(1,k);
        % compute distance to each centroid
        for idxC=1:k
            dist(idxC) = norm(P(:,idxP)-centr(:,idxC));    %计算||xi-cj||
        end
        % find index of closest centroid (= find the cluster)
        [~, clusterP] = min(dist);          %找最近的中心点
        cluster(idxP) = clusterP;           %把这个点归于这一类中心点
    end
    
    % Recompute centroids using current cluster memberships:
        
    % init centroid array centr
    centr = zeros(dimP,k);
    % for every cluster compute new centroid
    for idxC = 1:k
        % find the points in cluster number idxC and compute row-wise mean
        centr(:,idxC) = mean(P(:,cluster==idxC),2);             %更新中心点
    end
    
    % Checking for stopping criterion: Clusters do not change anymore
    if clusterPrev==cluster
        stop = true;
    end
    % update previous cluster clusterPrev
    clusterPrev = cluster;
    
    iterations = iterations + 1;
    
end

end