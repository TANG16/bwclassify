function [results,resultsBySubject] = runSSSStest(k,N,dataType,subjects)
% this is a script for just running a single kmeansCrossoverValidation test
% on a single subject
%subjects = [55,56,57,58,59,61,67,70,71,72]
%subjects = [55,56,57,61,67,70,71,72]
results=[];
resultsBySubject=[];
for s=[1:length(subjects)]
    subject = subjects(s)
dataset = createCleanDataset(subject,dataType);
global plotP;
plotP=false;
global W;
W=600;
%k=24;
%N=1;

v = 4;
training=[];
subjectResults = [];
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

    %[trainAccW,trainAccNoW,testAcc,trainAcc,~,~] = kmeansTrainTest(training,testing,k,N);
    [trainAccNoW,testAccNoW,trainAccW,testAccW,~,~] = kmeansTrainTest(training,testing,k,N);
    %figure(10*s+5+i);

    % renaming variables ... 
    %  trainAccNoW, testAccNoW, trainAccW, testAccW
    result = [subject,s,i,trainAccNoW,testAccNoW,trainAccW,testAccW];
    results = [results;result];
    subjectResults = [subjectResults;result];
    %display([result]);
    

end
display(mean(subjectResults));
resultsBySubject = [resultsBySubject;mean(subjectResults)];
end

boxplot(resultsBySubject(:,4:7))
axis([0 5 0.5 1])
grid on
grid minor
title({'k=',k,'W=',W,'N=',N})

end


