function [ dataset ] = createDataset( subject )
%createDataset reads the files and creates a cell array of labelledData  in the usual way
  datapath = '../Data_1st_Paper/';
  subject = strcat(datapath,num2str(subject));
  filenames = {strcat(subject,'_2.txt'),strcat(subject,'_3.txt'),strcat(subject,'_4.txt'),strcat(subject,'_5.txt')};
  numFiles = length(filenames);

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
    %labels = 1+mod(labels,2);  %2,1,2,1
    %dataset{i} = [labels(1:9000)', all(1:9000,:)];
    filter = mod(labels,2)==1; % mathread
    %filter = ((labels(:)==1) | (labels(:)==3));
    d=[1,0,2,0];
    %filter = labels<4;
    %d=[1,0,2,0];
    labels = d(labels);
    %mathshut = labels<3;
    %dataset{i} = [labels', all];
    dataset{i} = [labels(filter)',all(filter,:)];
    %dataset{i}= [labels',all];
  end
end
