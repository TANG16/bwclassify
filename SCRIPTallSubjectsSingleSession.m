% 9-fold validation predicting the ninth subject based on the other eight
% with all four sessions for each subject.

subjects = [55,56,57,58,59,61,67,70,71]

dataset0={}
for i = [1:9]
    d = createDataset(subjects(i));
    
    for j=[1:4]
        dataset0{i,j} = d{j};
    end
end

dataset={};
for j=[1:4]
    d=[];
    for i=[1:9]
        d = [d;dataset0{i,j}];
    end
    dataset{j}=d;
end

[accuracy,alist,blist,wlist] = kmeansCrossoverValidation(dataset,1000,5)

    

