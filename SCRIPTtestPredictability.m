% this is a script for just running a single kmeansCrossoverValidation test
% on a single subject session to see how effective kmeans is for prediction
% in the best case ...

subjects = [55,56,57,58,59,61,67,70,71]
results=[];
results2=[];
for s=[1:length(subjects)]
    subject = subjects(s)
    dataset = createDataset(subject);
    k=200;
    N=3;

    v = 4;
    training=[];
    for i=[1:v]
       training = dataset{i};
       testing = dataset{i};
    
       %figure(10*s+i)
    
       labels = testing(:,1);
       vals = testing(:,2:length(testing(1,:)));

       [accuracy0,windowAccuracy,bestAccuracy,testAcc,trainAcc,~,~] = kmeansTrainTest(training,testing,k,N);
       %figure(10*s+5+i);
       [~,~, accuracy1, accByLabel1, windowAccuracy1, accuracy12 ] = kmeansClassify(labels,vals, k );
       testP = testAcc./sum(testAcc);
       trainP = trainAcc./sum(trainAcc);
       result = [subject,s,i,accuracy12,accuracy0,accuracy1,bestAccuracy,windowAccuracy,windowAccuracy1];
       results = [results;result];
       results2 = [results2;,[trainP(1,1),trainP(2,2),trainP(3,3),trainP(4,4)]];
       display([result,0]);
    

   end

end
