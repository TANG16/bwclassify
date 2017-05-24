% this is a script for just running a single kmeansCrossoverValidation test
% on a single subject
dataset = createDataset(56);
k=36;
repetitions=500;
[accuracy,alist,blist,wlist] = kmeansCrossoverValidation(dataset,k,repetitions)
mw=mean(wlist)