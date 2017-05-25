% this is a script for just running a single kmeansCrossoverValidation test
% on a single subject
subjects = [55,56,57,58,59,61,67,70,71]
dataset = createDataset(57);
k=12;
repetitions=1;
[accuracy,alist,blist,wlist] = kmeansCrossoverValidation(dataset,k,repetitions)
mw=mean(wlist)