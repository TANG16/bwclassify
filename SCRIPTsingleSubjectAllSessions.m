% 4-fold validation predicting the fourth session based on other three
% for one subject at a time...
subjects = [55,56,57,58,59,61,67,70,71] % remove 58,59?

results={};
for i = [1:length(subjects)]
    dataset = createDataset(subjects(i));
    k=1200;
    repetitions=1;
    %figure(i);
    row=i;
    [accuracy,alist,blist,wlist] = kmeansCrossoverValidation(dataset,k,repetitions,i);
    results{i} = [accuracy,mean(alist),mean(blist),mean(wlist),-1,alist,-1,blist,-1,wlist];
    mw=mean(wlist);
    %display([row,accuracy,alist,blist,wlist])
end


data=[];
for i=1:length(subjects)
    for j=1:length(results{1})
        data(i,j)=results{i}(j);
    end
end
data
