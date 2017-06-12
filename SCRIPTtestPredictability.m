% this is a script for just running a single kmeansCrossoverValidation test
% on a single subject session to see how effective kmeans is for prediction
% in the best case ...

subjects = [59]; %55,56,57,58,59,61,67,70,71]
results=[];
results2=[];
global W;
W = 600;
for s=[1:length(subjects)]
    subject = subjects(s)
    dataset = createDataset(subject);
    k=12;


    v = 4;
    training=[];
    for i=[1] %[1:v]
       training = [dataset{1};dataset{2};dataset{3}];
       testing = dataset{4};
    
       %figure(10*s+i)
    
       labels = testing(:,1);
       vals = testing(:,2:length(testing(1,:)));
       N=1;
       for N1=[1:100]
          [accuracy0,windowAccuracy,bestAccuracy,testAcc,trainAcc,~,~] = kmeansTrainTest(training,testing,k,N);
       %figure(10*s+5+i);
          display([N1,windowAccuracy]);
       end
       %display(testAcc);
       %display((testAcc(1,1)+testAcc(2,2)+testAcc(3,3)+testAcc(4,4))/sum(sum(testAcc)));
       %display(windowAccuracy);
       %[~,~, accuracy1, accByLabel1, windowAccuracy1, accuracy12 ] = kmeansClassify(labels,vals, k );
       %testP = testAcc./sum(testAcc);
       %trainP = trainAcc./sum(trainAcc);
       %result = [subject,s,i,accuracy12,accuracy0,accuracy1,bestAccuracy,windowAccuracy,windowAccuracy1];
       %results = [results;result];
       %results2 = [results2;,[trainP(1,1),trainP(2,2),trainP(3,3),trainP(4,4)]];
       %display([result,0]);
    

    end

end
