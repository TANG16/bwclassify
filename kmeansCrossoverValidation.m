function [ accuracy, accuracies, bestAccuracies, windowAccuracies, testAccs ] = kmeansCrossoverValidation(dataset,k,N,row )
%kmeansCrossoverValidation removes a dataset, trains on rest, test on dataset
%          returns 
%            accuracy  - average accuracy and
%            testAccs  - a cell array of all the prediction accuracy
%                        matrices, M where (
%                   M(p,a) = number of events of type a predicted to be p
%  input is
%       datasets = a cell array containing labelledData 
%       k = k for kmeans
%       N = number of time to run the training to get the best accuracy

v = length(dataset);
accuracies=[];
bestAccuracies = [];
windowAccuracies=[];
minacclist = [];
testAccs = {};

for(i=[1:v])
    % create training data from 3 of the 4 datasets
    % let the remaining dataset be the testing set
    trainingData=[];
    for j=[1:v]
        if i==j
            testingData = dataset{j};
        else
            trainingData = [trainingData;dataset{j}];
        end
    end
    %display(i);
    %w = ceil(sqrt(v));
    subplot(9,4,4*row+i-4);
    [accuracy0,windowAccuracy,bestAccuracy,testAcc,trainAcc,~,~] = kmeansTrainTest(trainingData,testingData,k,N);
    %display([i,accuracy0,windowAccuracy,bestAccuracy]);
    testAccs{i}= testAcc;
    testP = testAcc./sum(testAcc);
    trainP = trainAcc./sum(trainAcc);
    minaccs=[];
    for (m=[1:length(testP)])
      minaccs = [minaccs,testP(m,m)];
    end
    %minaccs = [testP(1,1),testP(2,2),testP(3,3),testP(4,4)];
    %minacc = sum(minaccs)/length(minaccs);
    minacc = min(minaccs);
    accuracies = [accuracies, accuracy0];
    bestAccuracies =[bestAccuracies, bestAccuracy];
    windowAccuracies = [windowAccuracies,windowAccuracy];
    minacclist(i) = minacc;
end
%display(bestAccuracies);
%accuracy = sum(accuracies)/length(accuracies);

accuracy = mean(minacclist);
accuracies = minacclist;
%display([accuracy,accuracies]);


end
