% 4-fold validation predicting the fourth session based on other three
% for one subject at a time...
subjects = [55,56,57,58,59,61,67,70,71] % remove 58,59?

results={}
v = 4;
dataset={[],[],[],[]};
for i=[1:length(subjects)]
    dataset0 = createDataset(subjects(i));
    for j = [1:v]
        dataset{j} = [dataset{j};dataset0{j}];
    end
end
    
    
    results{i}=[];
    for k=[1:v]
        trainingData=[];
        for j=[1:v]
            if k==j
                testingData = dataset{j};
            else
                trainingData = [trainingData;dataset{j}];
            end
        end


        bestClassifier = trainingData(:,1);
        bestClusters = trainingData(:,2:21);
        testingData = testingData;
        [accuracy, accByLabel, windowAccuracy] = clusterPredict(testingData,bestClassifier,bestClusters);
        display([i,k,accuracy,windowAccuracy]);display(accByLabel);

    results{i} = [results{i},accuracy, windowAccuracy];
    end


data=[];
for i=[1:v]
    for j=1:length(results{1})
        data(i,j)=results{i}(j);
    end
end
data
