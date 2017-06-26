% 9-fold validation predicting the 9th subject based on other eight
% for one subject at a time...
subjects = [55,56,57,58,59,61,67,70,71,72];  %[55,56,57,58,59,61,67,70,71]
%values = [10,20,40,160];% ,48,96,160,300,600,1200];
%values = [5,10,20,40,80,150,300,600];
values = [20];
NValues = [1,4,16,64];
S = length(subjects);
V = length(values);
NV = length(NValues);

results={};
data=[];
allResults=[];

% read all of the data for each subject
% and combine all four sessions into one big labelled dataset for each
% subject
subjdata={}
for s=[1:S]
    dataset = createDataset(subjects(s));
    subjdata{s}=[];
    for t=[1:length(dataset)]
        subjdata{s} = [subjdata{s};dataset{t}];
    end
end


N=10;
global W;
W=600;
global cutoff;
cutoff=0.0;

meanAcc=[];
predAccs = [];

%for count=[1:V]
for count = [1:NV]
  N = NValues(count)
  k=20;
  %k=values(count);
  display('**************************')
  k=k
  figure(count)
  predAcc = [];
  [accuracy,alist,blist,wlist,testAcc] = kmeansCrossoverValidation(subjdata,k,N,1);
   for j=[1:length(testAcc)]
       A = testAcc{j}
       p = 0;
       for i = [1:length(A)]
           p = p+A(i,i);
       end
       predAcc(j) = p/sum(sum(A));
       display(predAcc(j));
       display(testAcc{j});
       predAccs(count,j) = predAcc(j);
       
   end
   meanAcc(count) = mean(predAcc);
   
end

