% Testing kmeans3
global W
W=600
labels=ceil(rand(40,1)*3);
vals=rand(40,2)+labels.*2;
k=8;
[ classifier, clusters, accuracy, accByLabel, windowAccuracy, accuracy2 ] = kmeansClassify3(labels,vals, k )