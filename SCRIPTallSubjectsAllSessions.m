% 9-fold validation predicting the ninth subject based on the other eight
% with all four sessions for each subject.

subjects = [55,56,57,58,59,61,67,70,71]

dataset={}
for i = [1:9]
    d = createDataset(subjects(i));
    dataset{i} = [d{1};d{2};d{3};d{4}];
end

[accuracy,alist,blist,wlist] = kmeansCrossoverValidation(dataset,36,1)

    
