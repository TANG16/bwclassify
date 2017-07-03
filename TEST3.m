
% this is a script for just running a single kmeansCrossoverValidation test
% on a single subject
%subjects = [55,56,57,58,59,61,67,70,71,72]
subjects = [55,56,57,58,59,61,71,72];
%create a labelled dataset for all 10 subjects and all sessions
crossdata={};
for j=[1:4]
    data=[];
    for i=[1:length(subjects)]
        dataset = createDataset(subjects(i));
        data1 = dataset{j};
        display([j,size(data1)]);
        %data1(:,1) = i; % set the label to be the subject id!
        data = [data;data1];
    end
    crossdata{j}=data
end
global W
W=600
k=160;
N=4;
subjdata = crossdata;
  
[accuracy,alist,blist,wlist,testAcc] = kmeansCrossoverValidation(subjdata,k,N,1);

A=testAcc

s=0;
for i=[1:length(A)]
s = s+A(i,i);
end
totalAccuraucy = s/sum(sum(A))
