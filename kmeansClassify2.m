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
%
% This uses the second method where we run kmeans on each labelled set independently
% with ceil(k/4) as the k value... we don't do any sensitivity labelling...


    maxLabel = round(max(labels));
    clusteredData=[];
    clusters=[];
    classifier = [];
    k4 = ceil(k/4);
    for (r=[1:maxLabel])
        [cData,cs,~,~] = kmeans(vals(labels==r,:),k4);
        clusteredData=[clusteredData;cData];
        clusters = [clusters;cs];
        classifier = [classifier,r*ones(1,length(cs))];
    end


    [accuracy, accByLabel, windowAccuracy, accuracy2] = clusterPredict([labels,vals],classifier,clusters);


end
