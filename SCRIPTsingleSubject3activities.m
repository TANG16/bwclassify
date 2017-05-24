dataset = createDataset(71);
subjects = [55,56,57,58,59,61,67,70,71]
% here we loop through removing all of the open eye samples from the data
% and running the predictions on this smaller set ...
results={};
for i=1:length(subjects)
    dataset = createDataset(subjects(i));
    for j=1:length(dataset)
        data1=dataset{j};
        %data1(data1(:,1)==4,1)=2;  % this merges the open and shut labels
        %data1 = data1(data1(:,1)<=3,:); % ignore the 'open' samples
        s = size(data1);
        data1(:,2:s(2)) = rand(s(1),s(2)-1);
        %display(size(data1));
        dataset{j}=data1;
    end
    k=36;
    repetitions=1;
    [accuracy,alist,blist,wlist] = kmeansCrossoverValidation(dataset,k,repetitions);
    results{i}= [accuracy,mean(wlist),mean(alist),mean(blist);alist;blist;wlist];
    display(results{i});
end

data=[]
for i=1:length(subjects)
    for j=1:4
        for k=1:4
            data(i,4*j+k-4)=results{i}(j,k)
        end
    end
end

            
