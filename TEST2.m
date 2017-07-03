
% this is a script for just running a single kmeansCrossoverValidation test
% on a single subject
%subjects = [55,56,57,58,59,61,67,70,71,72]
subjects = [55,56,57,58,59,61,71,72];
%create a labelled dataset for all 10 subjects and all sessions
data = [];
for i=[1:length(subjects)]
    dataset = createDataset(subjects(i));
    for j=[1:4]
        data1 = dataset{j};
        display([j,size(data1)]);
        data1(:,1) = i; % set the label to be the subject id!
        %data1(:,1) = j;
        data = [data;data1];
    end
end
global W
W=600

labels = data(:,1);
vals = data(:,2:21);
k=160;
display(size(data));
display(size(labels));
display(size(vals));
[classifier,clusters, accuracy1, accByLabel1, windowAccuracy1, accuracy12 ] = kmeansClassify3(labels,vals, k );
A=accByLabel1

s=0;
for i=[1:length(A)]
s = s+A(i,i);
end
totalAccuraucy = s/sum(sum(A))
