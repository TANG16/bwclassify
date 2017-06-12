% 9-fold validation predicting the 9th subject based on other eight
% for one subject at a time...
subjects = [55,56,57,58,59,61,67,70,71]
values = [150];% ,48,96,160,300,600,1200];
%values = [5,10,20,40,80,150,300,600];
%values = [160,600];
S = length(subjects);
V = length(values);

results={};
data=[];
allResults=[];


N=10;
global W;
W=600;
global cutoff;
cutoff=0.0;

for count=[1:V]
  k=values(count);
  display('**************************')
  k=k
  figure(count)

  for i = [1:S]
    dataset = createDataset(subjects(i));

    %figure(i);
    [accuracy,alist,blist,wlist,testAcc] = kmeansCrossoverValidation(dataset,k,N,i);
    results{count,i+1} = testAcc; %[accuracy,mean(alist),mean(blist),mean(wlist),-1,alist,-1,blist,-1,wlist];
    %mw=mean(wlist);
   
    for j=[1:length(testAcc)]
         display([subjects(i),k,i,j]);
        display(testAcc{j});
    end
%{
    data=[];
    for jj = [1:length(dataset)]
        L = max(dataset{1}(:,1));
        dd = [];
        display(values(count));
        display(subjects(i)); display(jj);
        display(testAcc{jj});
        for j=[1:length(testAcc{jj})]
            dd = [dd,testAcc{jj}(j,:)./sum(testAcc{jj})];
        end
        display(dd);
        %datadisplay(dd);
        k = S*count+i-S;
        correct = 0;
        for jjj = [1:L]
          correct = correct + testAcc{jj}(jjj,jjj);
        end
        total = sum(sum(testAcc{jj}));
        %display([values(count),subjects(i),correct./total*100]);
        data=[data;[values(count),subjects(i),dd]];
    end
    %}


    %display([row,accuracy,alist,blist,wlist])
  end
  %{
  results{count,1}=data;
  z = 100*mean(data);% zz = [z(3:6);z(7:10);z(11:14);z(15:18)];
  display(datetime());
 % display([values(count),(zz(1,1)+zz(2,2)+zz(3,3)+zz(4,4))/sum(sum(zz))]);
  display(round(z));
  display(round(100*data));
  data=[];
  %}
end
%data2=[];

%figure();
%boxplot(data',values);
%hold on;
%plot data;



%data=[];
%for i=1:length(subjects)
%    for j=1:length(results{1})
%        data(i,j)=results{i}(j);
%    end
%end
%data
