function [minaccuracy, windowAccuracy, bestAccuracy, accByLabel, bestAccByLabel, classifier, clusters ] = kmeansTrainTest( trainingData, testingData, k, N)
%kmeansTrainTest = trains a k-means classifier N times to get best, then
%                  applies it to the testing data to get the accuracy

  % first we run the kmean classifier N times and get the best accuracy ...

  % Next, I'll rewrite this as it seems to be the source of the problems,
  % for some unknown reason!!


  labels = trainingData(:,1);
  trainingSize = size(trainingData);
  d=trainingSize(2);

  vals = trainingData(:,2:d);
  bestAccuracy = -1;
  bestAccByLabel= [];
  bestClassifier=[];
  bestClusters=[];
  allAccuracies=zeros(1,N);
  bestResult=1;
  results={};

  for(j=[1:N])
    %figure(j+2)
     % here we call kmeans and get several measures of accuracy
    [classifier,clusters,accuracy1,accByLabel0, windowAccuracy, accuracy2] = kmeansClassify(labels,vals,k);


    % this is where we decide which measure of accuracy to use
    accuracy0 = windowAccuracy;
    results{j}={classifier,clusters,accuracy0,accByLabel0};
    allAccuracies(j)=accuracy0;
    if accuracy0>bestAccuracy
        bestAccuracy = accuracy0;
        allAccuracies(j)=accuracy0;
        bestAccByLabel=accByLabel0;
        bestClassifier=classifier;
        bestClusters=clusters;
    end
    %display([j,accuracy1,windowAccuracy]);
  end
  %z = allAccuracies
  %figure(j+3);
  %display(bestClusters);
  accuracy = windowAccuracy;
  [accuracy, accByLabel, windowAccuracy,minaccuracy] = clusterPredict(testingData,bestClassifier,bestClusters);
    %display(accuracy);
    %display(accByLabel);
    %display(windowAccuracy);


end
