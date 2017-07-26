function [ P] = clusterWindow(C,w)
%clusterPlot(C,w) runs a window of size w along the data and
% calculates the percentage of the window containing each of the clusters
% so if the entire window is all from cluster 3, then cluster 3 will be 1.0
% 
%  C is a vector of length N which records the cluster number for each
%  sample
%  Plots is a vector of size N x k where k is the number of clusters
%  The ith row of plots gives the percentage of samples in the range
%  C(i-w/2:i+w/2) which have value j for each of the j clusters...
N = length(C);  % number of samples
K = max(C);  % number of clusters
P = zeros(N,K+1);
C2 = C(:);
C2(C(:)==0)=K+1;  %make all zero clusters equal to K+1

P(1,C2(1)) = 1;
for i=2:N
    P(i,:) = P(i-1,:);
    P(i,C2(i)) = P(i,C2(i))+1;
    if (i>w) 
        P(i,C2(i-w)) = P(i,C2(i-w))-1;
    end
end

%figure();
%subplot(2,1,1);
%plot(P);
%P(:,K+1)=0;  % remove all 0 data ...
%legend('show');
%subplot(2,1,2);
%plot(P);
%legend('show');
end

