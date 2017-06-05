function [ classifier, clusters, accuracy, accByLabel, windowAccuracy, accuracy2 ] = kmeansClassify3(labels,vals, k )
%kmeansClassify(data,k,N) create a k-means classifier for labelled data
%   data is a matrix with m+1 cols
%      the first column is an integer label in the range 1:r
%      the remaining are floats
%   k is the number of clusters if calculates
%   classifier is a kxm+1 matrix of the k clusters for the data
%      the first column is the label for that cluster
%   accuracy is the proportion of the data which is correctly classified
%   accByLabel is a rxr matrix M where M(i,j) is the number of samples
%      in the data with label i that are predicted to be of type j
    global cutoff;
    cutoff=-1.0; % I'm removing the cutoff option for now...
                  % if we want it back we will make it a parameter
                  
                      % Lets first find out how many labels there are
    maxLabel = round(max(labels));

 symbol = {'ro','r*','rx','r+','bo','b*','bx','b+'};
 symbol2 = {'go','g*','gx','g+','mo','m*','mx','m+'};

    %[clusteredData,clusters,~,~] = kmeans(vals,k);

    clusteredData=[];
    clusters=[];
    k4 = ceil(k/maxLabel);
    k=k4*maxLabel;
    cmap=[];
    newvals=[];
    for i = [1:maxLabel]
        vals1 = vals(labels==i,:);
        [cd1,c1,~,~] = kmeans(vals1,k4);
        cm1= i+0*cd1;
        cmap = [cmap;cm1];
        newvals = [newvals;vals1];
     
        clusteredData = [clusteredData;cd1+k4*(i-1)]; 
        clusters = [clusters;c1];
        zz = vals(labels==i,:);
       % scatter(zz(:,1),zz(:,2),symbol{i}); hold on;
       % scatter(c1(:,1),c1(:,2),symbol2{i});
    end
    %cmap= cmap
    %legend('show')
    %axis([0,6,0,6])
    %figure()
    % clusteredData is a column vector which gives the cluster id for
    % each row in vals
    %dxd1=clusteredData
    %x1=clusters
    %xk=k
    %xk4=k4
    %ddd = [clusteredData,labels]

    % then for each cluster, we see which label appears most frequently
    % in that cluster, and we assign that label to that cluster
    % using the classifier vector
    classifier = zeros(1,k);

    p=[];
    for (c=[1:k])
        labelCounts = hist(cmap(clusteredData==c),1:maxLabel);
        
       % zz = newvals(clusteredData==c,:)
       % zz2 =cmap(clusteredData==c)
       % scatter(zz(:,1),zz(:,2),symbol{c}); hold on;
       % scatter(clusters(c,1),clusters(c,2),symbol2{c});
        %display(labelCounts);
        % labelCounts(j) = number of times label j appears in cluster c
        [m,j] = max(labelCounts);
        classifier(c)=j;
        %display([99,c,j,m,99,labelCounts])
        %p(c) = m/(max(1,sum(labelCounts)));
        % j is the label that appears most often in cluster c
        % and m is the number of times it appears!
        % so j is the label we assign to cluster c for our classifier
        %classifier(c)=j;
        %if p(c)>cutoff
        %    classifier(c)=j;
        %else
        %    classifier(c)=0;  % maybe make this -j to preserve info?
        %end
    end
    %display(p);
    %figure();
    %histogram(p,0:0.01:1);

    % legend('show')
    %axis([0,6,0,6])
    %figure()
    [accuracy, accByLabel, windowAccuracy, accuracy2] = clusterPredict([labels,vals],classifier,clusters);
    %display(accByLabel);

end

