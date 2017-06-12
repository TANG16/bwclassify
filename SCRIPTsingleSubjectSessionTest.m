% this is a script for just running a single kmeansCrossoverValidation test
% on a single subject
subjects = [55,56,57,58,59,61,67,70,71]
results=[];
for s=[1:length(subjects)]
    subject = subjects(s)
dataset = createDataset(subject);
global W;
W=600;
k=120;
N=3;

v = 4;
training=[];
for i=[1:v]
    for j = [1:v]
        if i==j
            testing = dataset{j};
        else
            training = [training;dataset{j}];
        end
    end
    %figure(10*s+i)
    
    labels = testing(:,1);
    vals = testing(:,2:length(testing(1,:)));

    [accuracy0,windowAccuracy,bestAccuracy,testAcc,trainAcc,~,~] = kmeansTrainTest(training,testing,k,N);
    %figure(10*s+5+i);
    [~,~, accuracy1, accByLabel1, windowAccuracy1, accuracy12 ] = kmeansClassify(labels,vals, k );
    testP = testAcc./sum(testAcc);
    trainP = trainAcc./sum(trainAcc);
    result = [subject,s,i,accuracy0,accuracy1,bestAccuracy,windowAccuracy,windowAccuracy1];
    results = [results;result];
    display([result,0]);
    

end

end
