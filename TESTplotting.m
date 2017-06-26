subjects = [55,56,57,58,59,61,67,70,71,72];
for i=[1:length(subjects)]
    figure(i)
    dataset = createDataset(subjects(i));
    for j=[1:4]
        subplot(4,1,j);
        musePlot(dataset{j}(:,2:21));
        hold on;
        plot(dataset{j}(:,1),'k.');
        hold off;
        title(strvcat(['subject = ',num2str(i),' and session = ',num2str(j)]));
    end
end

    