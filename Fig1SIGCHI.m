%subjects = [55,56,57,58,59,61,67,70,71,72];
subjects = [55,58];%,56,57,61,67,70,71,72];
for i=[1:length(subjects)]
    %figure(i)
    subplot(length(subjects),1,i);
    dataset = createDataset(subjects(i),'R-O');
    alldata = [dataset{1};dataset{2};dataset{3};dataset{4}];
    alldata = alldata(:,2:21);
    musePlot(alldata);
    xticks([0:3000:24000]);
    yticks([1:4]);
    ylabel(strcat('Subject ', num2str(i)),'fontsize',18);
    xlabel('time','fontsize',18)
    if (i>1)
        legend('hide')
    else
        title('Relative EEG bands for Subjects 1 and 2','fontsize',24);
    end
end

    