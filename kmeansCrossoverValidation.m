function [ accuracy, accuracies, bestAccuracies, windowAccuracies ] = kmeansCrossoverValidation(dataset,k,N )
%kmeansCrossoverValidation removes a dataset, trains on rest, test on dataset
%          returns average accuracy 
%  datasets is a cell array containing labelledData datasets{i} being the ith dataset
v = length(dataset);
accuracies=[];
bestAccuracies = [];
windowAccuracies=[];
for(i=[1:v])
    trainingData=[];
    for j=[1:v]
        if i==j
            testingData = dataset{j};
        else
            trainingData = [trainingData;dataset{j}];
        end
    end
    [accuracy0,windowAccuracy,bestAccuracy,~,~,~,~] = kmeansTrainTest(trainingData,testingData,k,1);
    %display([accuracy0,windowAccuracy,bestAccuracy]);
    accuracies = [accuracies, accuracy0];
    bestAccuracies =[bestAccuracies, bestAccuracy];
    windowAccuracies = [windowAccuracies,windowAccuracy];
end
%display(bestAccuracies);
accuracy = sum(accuracies)/length(accuracies);


end

