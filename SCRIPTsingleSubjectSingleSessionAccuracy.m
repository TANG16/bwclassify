% this is a script for plotting how the accuracy varies as a function of k
% for predicting a single subject single session...
global W;
W=600;
subjects = [55,56,57,58,59,61,67,70,71]
results=[];
allResults=[];
values = [1,2,5,10,20,40,80,150,300,600,1200,2400];
W=600;
k = 150;
%for k= kvalues  %[4,12,48,120,600,1200]
for W = values
  for s=[1:length(subjects)]
    subject = subjects(s)
    dataset = createDataset(subject);

    numSessions = length(dataset);
    for session=[1:numSessions]
       testing = dataset{session};
       labels = testing(:,1);
       vals = testing(:,2:length(testing(1,:)));
       [~,~, accuracy1, accByLabel1, windowAccuracy1, accuracy2 ] = kmeansClassify(labels,vals, k );
       results(s,session) = accuracy2;
       display('******************');
       display('*** new session test ***');
       display([W,k,s,session,accuracy2,accuracy1,windowAccuracy1]);
       display(accByLabel1);
       display('******************');
    end
  end
  rr = [results(:,1);results(:,2);results(:,3);results(:,4)];
  allResults = [allResults, rr];
  
end
boxplot(allResults, values);
hold on;
plot(allResults');
