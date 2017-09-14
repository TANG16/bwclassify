% Fig accuracy by k

accByK = [];
ks = [4,12,24,120,240]

for i = [1:length(ks)]
    k = ks(i);
    [results,resultsBySubject]=runSSSStest(k,1,'R-O',[55,56,57,67,70,71,72]);
    accByK = [accByK, resultsBySubject(:,7)]
end

boxplot(accByK,ks)
axis([0 length(ks)+1 0 1])
grid on
grid minor
xlabel('k')
ylabel('accuracy')
title('SSSS')

    