%function [windowAccuracy, bestAccuracy, accByLabel, bestAccByLabel, classifier, clusters ] = kmeansTrainTest( trainingData, testingData, k, N)
function [trainAccNoW,testAccNoW,trainAccW,testAccW, classifier, clusters ] = kmeansTrainTest( trainingData, testingData, k, N)
%kmeansTrainTest = trains a k-means classifier N times to get best, then
%                  applies it to the testing data to get the accuracy



  labels = trainingData(:,1);
  trainingSize = size(trainingData);
  d=trainingSize(2);

  vals = trainingData(:,2:d);
  bestTrainW = -1;  % best accuracy using the sliding window for training data
  bestTrainNoW = -1;
  bestClassifier=[];
  bestClusters=[];



  for(j=[1:N])
    [classifier,clusters,trainAccNoW,trainAccW] = kmeansClassify(labels,vals,k);

    if trainAccW>bestTrainW
        bestTrainW = trainAccW;
        bestTrainNoW = trainAccNoW;
        bestClassifier=classifier;
        bestClusters=clusters;
    end
  end


  [testAccNoW, testAccW] = clusterPredict(testingData,bestClassifier,bestClusters);



end
