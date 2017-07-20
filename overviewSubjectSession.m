function [classifier, clusters, accByLabel ] = overviewSubjectSession(subject,session,theDataType,numClusters )
%overview Show main clustering data for the specified file
%   this calls museplot on all 4 electrodes
%   shows the clusters and their specificity for each of the activities
%   show the 4 meta-clusters and their specificity
%   shows the accuracy of prediction over all the data

global windowSize;
windowSize = 600;
subjects = [55,56,57,58,59,61,67,70,71]
%dataset = createDataset(subject,theDataType);
dataset = createCleanDataset(subject,theDataType);
labels = dataset{session}(:,1);
vals = dataset{session}(:,2:21);
k=numClusters
global W
W=600

%data=[];
%for i=[1:length(dataset)]
%    data = [data; dataset{i}];
%end
figure()
musePlot(vals);


[ classifier, clusters, accuracy, accByLabel, windowAccuracy, accuracy2 ] = kmeansClassify(labels,vals, k )
title('Classification Accuracy','FontSize',20);
xlabel('Sample number (10Hz for 20 minutes)','FontSize',20)
ylabel('Prediction probability','FontSize',20);


global kmclass;
figure()
bar(kmclass./sum(kmclass)*100)
legend('Math','Shut','Read','Open')
title('k-means cluster classification','FontSize',20)
xlabel('cluster id','FontSize',20)
ylabel('percent in each cluster','FontSize',20)


%{
a=1;


% The top plot is the five bands for each of the 4 electrodes

% The second plot is the clusters for each sample

% The third plot is the percentage of a sliding window containing each
% cluster

% The fourth is the number of times that each cluster appears in each of
% the four mental activities, arranged by cluster 

% The fifth is the same number of times that each cluster appears but
% arranged by activity


% Here is the code ..
% read in the data
math=[]
read=[];
shut=[];
open=[];
numFiles = length(filenames);

for i=[1:numFiles]  
    filename = filenames{i}
    all = importdata(filename,' ',0);
    extra = max(1,round((length(all)-12000)/2))
    all = all(extra:length(all)-extra,:);
    all = all(:,2:21);
    sizes = [size(math);size(shut);size(read);size(open)]
    math = [math;all(1:3000,:)];
    shut = [shut;all(3001:6000,:)];
    read = [read;all(6001:9000,:)];
    open = [open;all(9001:length(all),:)];
end
    
all = [math;shut;read]; %open];

%musePlot(all);  % look at all data, select some


% classify 

[~,Clusters,~,~] = kmeans(vals,numClusters);

[Classifications,~]=museClassifyAll(vals,1,Clusters);


% plot
hold off;

subplot(4,1,1); 
musePlot(all);
%xticks([0:3000:12000])
grid on; grid minor;
legend('alpha','beta','delta','gamma','theta');



subplot(4,1,2); 
% plot of the frequency each cluster appears in each core activity
% i.e. the middle three minutes of each activity
mathMax = 3000*numFiles;
shutMax = 6000*numFiles;
readMax = length(all); %9000*numFiles;
openMax = length(all);

a1= hist(Classifications(1:mathMax),0.5:numClusters-0.5);
a2= hist(Classifications(mathMax+1:shutMax),0.5:numClusters-0.5);
a3= hist(Classifications(shutMax+1:readMax),0.5:numClusters-0.5);
%a4= hist(C(readMax+1:openMax),0.5:numClusters-0.5);

aa = [a1;a2;a3]';
bar(aa./30); legend('math','relax1','reading');
title('Plot B. Frequency each cluster appears in MORC sections')




subplot(4,1,3);
% plot the accuracy of each prediction over all four activities

 vv = (aa' == max(aa'));
 numCC = 3;
 dd = [1:numCC]*vv;
 CC = dd(Classifications);
 c1= hist(CC(1:mathMax),0.5:numCC-0.5);
 c2= hist(CC(mathMax:shutMax),0.5:numCC-0.5);
 c3= hist(CC(shutMax:readMax),0.5:numCC-0.5);
 %c4= hist(CC(readMax:openMax),0.5:numCC-0.5);
 ccs = [c1;c2;c3]'./30;
 bar(ccs'); legend('math','relax1','reading');
 grid on;
 grid minor;
 %axis([0,5,0,100])
 title('Plot C: Accuracy of k-means classification for each MORC region')




subplot(4,1,4); 
zz1 = clusterWindow(CC,windowSize);
plot(zz1./(windowSize/100));
%legend(string(1:max(CC)));
legend('math','relax1','reading');
grid on; grid minor;
%xticks([0:3000:12000])
% look into analyzing data using pca(all) to see which
% vectors have the most importance, and cluster on those??
clusters = [1:numClusters];
mathClusters = clusters(vv(1,:)==1);
closedClusters = clusters(vv(2,:)==1);
readClusters = clusters(vv(3,:)==1);
%openClusters = clusters(vv(4,:)==1);
title('Plot D: 1 minute smoothing of k-means classification');


maxzz1 = max(zz1')';
zz1size = size(zz1)
maxzz1size= size(maxzz1)
otherize = size(zz1==maxzz1)
display(size([1;2;3;4]))
display('compare zz1 and maxzz1')
display(size(zz1))
display(size(maxzz1))
winner = (zz1==maxzz1)*[1;2;3;4];
n = length(math);
accuracyMath = sum(winner(1:n)==1)*100/n
accuracyShut = sum(winner(n+1:2*n)==2)*100/n
accuracyRead = sum(winner(2*n+1:3*n)==3)*100/n
accuracyOpen = sum(winner(3*n+1:length(winner))==4)*100/n

end
%}
a=2;
