%function runSSSStest(W,k,N,subjects)
% this is a script for just running a single kmeansCrossoverValidation test
% on a single subject
%subjects = [55,56,57,58,59,61,67,70,71,72]
display('this is working!!!');
subjects = [55,56,57,61,67,70,71,72]
results=[];
for s=[1:length(subjects)]
    subject = subjects(s)
dataset = createCleanDataset(subject,'R-O');
global plotP;
plotP=false;
global W;
W=600;
k=120;
N=1;

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

    %[trainAccW,trainAccNoW,testAcc,trainAcc,~,~] = kmeansTrainTest(training,testing,k,N);
    [trainAccNoW,testAccNoW,trainAccW,testAccW,~,~] = kmeansTrainTest(training,testing,k,N);
    %figure(10*s+5+i);

    % renaming variables ... 
    %  trainAccNoW, testAccNoW, trainAccW, testAccW
    result = [subject,s,i,trainAccNoW,testAccNoW,trainAccW,testAccW];
    results = [results;result];
    display([result,0]);
    

end

end
%end

