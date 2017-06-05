
% this is a script for just running a single kmeansCrossoverValidation test
% on a single subject
subjects = [55,56,57,58,59,61,67,70,71]
subject=70;
dataset = createDataset(70);
k=120;
N=6;
results=[];

v = 4;

testing = dataset{1};
training = [dataset{2};dataset{3};dataset{4}];

    %figure(10*s+i)
    figure(1)
    labels = testing(:,1);
    vals = testing(:,2:length(testing(1,:)));

    [accuracy0,windowAccuracy,bestAccuracy,testAcc,trainAcc,~,~] = kmeansTrainTest(training,testing,k,N);
    %figure(10*s+5+i);
    figure(2)
    [classifier,clusters, accuracy1, accByLabel1, windowAccuracy1, accuracy12 ] = kmeansClassify3(labels,vals, k );
    testP = testAcc./sum(testAcc);
    trainP = trainAcc./sum(trainAcc);
    result = [subject,s,i,accuracy0,accuracy1,bestAccuracy,windowAccuracy,windowAccuracy1];

    results = [results;result];
    display([result,0]);
    

