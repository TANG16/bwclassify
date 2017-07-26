function [ dataset ] = createCleanDataset( subject, theDataType )
%createDataset reads the files and creates a cell array of labelledData  in the usual way
  datapath = '../Data_1st_Paper/';
  subject = strcat(datapath,num2str(subject));
  filenames = {strcat(subject,'_2.txt'),strcat(subject,'_3.txt'),strcat(subject,'_4.txt'),strcat(subject,'_5.txt')};
  numFiles = length(filenames);
  
  %global theDataType;
  %theDataType='M-S-R-O';  % could have 'M-R', 'MR-SO',
  %display(theDataType);
  
  for i=[1:numFiles]
    filename = filenames{i};
   % display(filename);
    all = importdata(filename,' ',0);
    extra = max(1,round((length(all)-12000)/2));
    all = all(extra:length(all)-extra,:);
    lengthAll = min(12000,length(all)); % this makes sure we don't have more that 12000 elts
    all = all(1:lengthAll,2:21);
    partLength = ceil(lengthAll/4);
    labels = 1+floor([0:length(all)-1]/partLength); %1,2,3,4

    switch (theDataType)
        case 'M-S-R-O'
            dataset{i} = [labels',all];
        case 'M-S'
            filter = labels<=2; % mathshut
            dataset{i} = [labels(filter)',all(filter,:)];
        case 'M'
            filter = labels<=1; % math
            dataset{i} = [labels(filter)',all(filter,:)];
        case 'M-R'
            filter = mod(labels,2)==1; % mathread
            d=[1,0,2,0]; % Math is label 1, Read is label 2, S and O are filtered out
            dataset{i} = [d(labels(filter))',all(filter,:)];
        case 'MR-SO'
            labels = 1+mod(labels,2);  %2,1,2,1  MR are 2 and SO are 1
            dataset{i} = [labels(filter)',all(filter,:)];
        otherwise
            display('unknown dataType'); display(dataType);
            dataset{i} = [labels',all];
    end
    all = dataset{i}(:,2:21);
    lengthAll = length(all);
    n = lengthAll-10;
    a1 = all(1:n+1,:);
    a2 = all(2:n+2,:);
    a3 = all(3:n+3,:);
    a123 = (a1==a2) & (a2==a3);
    bad = (a123(:,1)|a123(:,2)|a123(:,3)|a123(:,4));
    good = ~bad;
    %display('size of good and labels(good) and all(good) and dataset{i}')
    %display(size(good))
    %display(size(labels(good)))
    %display(size(all(good,:)))
    dataset{i}=[labels(good)',all(good,:)];
    %display(size(dataset{i}))
    %display('size of dataset and size of good')
    %display(size(dataset{i}))
    %display(size(good));
    %dataset{i} = dataset{i}(good,:);
    
    %labels = 1+mod(labels,2);  %2,1,2,1
    %dataset{i} = [labels(1:9000)', all(1:9000,:)];
    %filter = mod(labels,2)==1; % mathread
    %filter = ((labels(:)==1) | (labels(:)==3));
    %d=[1,0,2,0];
    %filter = labels<4;
    %d=[1,0,2,0];
    %labels = d(labels);
    %mathshut = labels<3;
    %dataset{i} = [labels', all];
    %dataset{i} = [labels(filter)',all(filter,:)];
    %dataset{i}= [labels',all];
  end
end
