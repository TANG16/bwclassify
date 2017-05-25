function [ classifier, clusters, accuracy, accByLabel, windowAccuracy, accuracy2 ] = kmeansClassify(labels,vals, k )
%kmeansClassify(data,k,N) create a k-means classifier for labelled data 
%   data is a matrix with m+1 cols
%      the first column is an integer label in the range 1:r 
%      the remaining are floats
%   k is the number of clusters if calculates
%   classifier is a kxm+1 matrix of the k clusters for the data
%      the first column is the label for that cluster
%   accuracy is the proportion of the data which is correctly classified
%   accByLabel is a rxr matrix M where M(i,j) is the number of samples
%      in the data with label i that are predicted to be of type j

    cutoff=0.0;
    
    [clusteredData,clusters,~,~] = kmeans(vals,k);
    % clusteredData is a column vector which gives the cluster id for
    % each row in vals
    
    
    % Lets first find out how many labels there are 
    maxLabel = round(max(labels));
    % then for each cluster, we see which label appears most frequently
    % in that cluster, and we assign that label to that cluster
    % using the classifier vector
    classifier = zeros(1,maxLabel);

    p=[];
    for (c=[1:k])
        labelCounts = hist(labels(clusteredData==c),1:maxLabel);
        
        % labelCounts(j) = number of times label j appears in cluster c
        [m,j] = max(labelCounts);
        p(c) = m/sum(labelCounts);
        % j is the label that appears most often in cluster c 
        % and m is the number of times it appears!
        % so j is the label we assign to cluster c for our classifier
        if p(c)>cutoff
            classifier(c)=j;
        else       
            classifier(c)=0;
        end
    end
    %figure();
    %histogram(p,0:0.01:1);
    
    [accuracy, accByLabel, windowAccuracy, accuracy2] = clusterPredict([labels,vals],classifier,clusters);
    

end

