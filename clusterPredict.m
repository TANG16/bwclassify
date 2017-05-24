function [accuracy,  accByLabel, windowAccuracy ] = clusterPredict(labelledData, classifier, clusters)
% clusterPredict(data,classifier,clusters)
%  labelledData = labelled data (label in col 1) 
%  classifier = column array giving labels of each cluster
%  clusters = matrix where each row is a cluster point
%  accuracy = probability that the classification = label
%  accByLabels =  rows = prediction, cols = label, 
%             value = number of samples with that label and prediction


  % first we separate the labels and the data
  labels = labelledData(:,1);
  r = round(max(labels));  % number of labels

  dataSize = size(labelledData);
  d = round(dataSize(2)); % dimension of the sample space
  n = round(dataSize(1)); % number of samples
  data = labelledData(:,2:d);  % strip out the labels from the labelledData

  clusterSize = size(clusters);
  k = clusterSize(1);
  predictions = zeros(n,1);

  % next we find the nearest cluster for each of the samples in the labelled Data
  % and we use that cluster and the classifier to make a prediction
  for(s=[1:n])
      % this expression subtracts sample s from each cluster, squares the
      % coordinates, then sums them to get the distances of sample s from
      % each cluster
      distances = sum(((clusters - data(s,:)).^2)');
    
      % this finds the index of the smallest distance
      [~,j] = min(distances);
      predictions(s) = classifier(j);  
  end
  
  windowPredictionPlots = clusterWindow(predictions,600);
  %display(size(windowPredictionPlots));
  [~,windowPredictions] = max(windowPredictionPlots');
  %display(size(windowPredictions));
  
  % Finally we calculate the accuracy and the accByLabels
  accuracy = sum(labels == predictions)/length(labels);
  windowAccuracy = sum(labels==windowPredictions')/length(labels);
 % display(windowAccuracy);
  
  accByLabel = zeros(r,r);  % r is the number of labels
    for i=[1:r]
        accByLabel(i,:) = hist(labels(predictions==i),[1:r]);
    end
end

