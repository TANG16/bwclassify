%subjects = [55,56,57,58,59,61,67,70,71,72];
subjects = [55,56,57,61,67,70,71,72];
for i=[1:length(subjects)]
    figure(i)
    dataset = createCleanDataset(subjects(i),'M-S-R-O');
    for j=[1:4]
        subplot(4,1,j);
        musePlot(dataset{j}(:,2:21));
        hold on;
        plot(dataset{j}(:,1),'k.');
        axis([0,12000,0,4]);
        hold off;
        title(strvcat(['subject = ',num2str(i),' and session = ',num2str(j)]));
    end
end

    