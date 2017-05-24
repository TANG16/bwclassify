function [accuracy, windowAccuracy, bestAccuracy, accByLabel, bestAccByLabel, classifier, clusters ] = kmeansTrainTest( trainingData, testingData, k, N)
%kmeansTrainTest = trains a k-means classifier N times to get best, then
%                  applies it to the testing data to get the accuracy

  % first we run the kmean classifier N times and get the best accuracy ...

      
  labels = trainingData(:,1);
  trainingSize = size(trainingData);
  d=trainingSize(2);
  
  vals = trainingData(:,2:d);
  bestAccuracy = 0;
  bestAccByLabel= [];
  bestClassifier=[];
  bestClusters=[];
  allAccuracies=zeros(1,N);
  bestResult=1;
  results={};
  for(j=[1:N])
    [classifier,clusters,accuracy0,accByLabel0] = kmeansClassify(labels,vals,k);
    %display(accuracyByLabel0);
    results{j}={classifier,clusters,accuracy0,accByLabel0};
    allAccuracies(j)=accuracy0;
    if accuracy0>bestAccuracy
        bestAccuracy = accuracy0;
        allAccuracies(j)=accuracy0;
        bestAccByLabel=accByLabel0;
        bestClassifier=classifier;
        bestClusters=clusters;
    end
  end
  %z = allAccuracies
        
  
  [accuracy, accByLabel, windowAccuracy] = clusterPredict(testingData,bestClassifier,bestClusters);
   

end

