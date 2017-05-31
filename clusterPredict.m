function [accuracy,  accByLabel, windowAccuracy, accuracy2 ] = clusterPredict(labelledData, classifier, clusters)
% clusterPredict(data,classifier,clusters)
%  labelledData = labelled data (label in col 1)
%  classifier = column array giving labels of each cluster
%  clusters = matrix where each row is a cluster point
%  accuracy = probability that the classification = label
%  accByLabels =  rows = prediction, cols = label,
%             value = number of samples with that label and prediction
%  accuracy2 is the minimum accuracy for samples of a fixed label
%      that is, the accuracy when look at only samples with a selected
%      label will be at least accuracy2, if this is high then the
%      prediction are relatively good for all activities!


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
      %display([s,size(clusters),size(data)]);
      distances = sum(((clusters - data(s,:)).^2)');

      % this finds the index of the smallest distance
      [~,j] = min(distances);
      predictions(s) = classifier(j);
  end

  %figure()
  %histogram(predictions,0:r+1);
  %legend('show')

  windowPredictionPlots = clusterWindow2(predictions,600);
  %display(size(windowPredictionPlots));
  [~,windowPredictions] = max(windowPredictionPlots');
  %display(size(windowPredictions));

  % Finally we calculate the accuracy and the accByLabels
  accuracy = sum(labels == predictions)/length(labels);
  windowAccuracy = sum(labels==windowPredictions')/length(labels); %'
 % display(windowAccuracy);


  accByLabel = zeros(r,r);  % r is the number of labels
    for i=[1:r]
        accByLabel(i,:) = hist(labels(windowPredictions==i),[1:r]); % use predictions ..
    end
  %accByLabel
  % next we look at each label and find the percent of the samples
  % with the label which were correctly predicted
  % we set the accuracy to be the minimum of those values
  % so we know that it will be at least that correct on all labels
  acc=[];
  sumAcc= sum(accByLabel);
  for i=1:r
      acc(i)=accByLabel(i,i)/sumAcc(i);
  end
  accuracy2 = min(acc);
  %accuracy2
  %accuracy

end
