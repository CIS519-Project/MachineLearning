function h = plotROC(labels,scores,cl,colors)
newscore = zeros(size(scores));
if size(scores,2)~=1
    for i =1:size(scores,1)
        newscore(i,:) = (scores(i,:)-min(scores(i,:)))/(max(scores(i,:))-min(scores(i,:)));
    end
else
    newscore(:,1) = (scores(:,1)-min(scores(:,1)));%/(max(scores(:,1))-min(scores(:,1)));
    %newscore(:,2) = newscore(:,1);
end
figure();
axis([]);
hold on;
classType = unique(labels);
if (length(classType)==2)
    classType = [1];
end
for i=1:length(classType)
    templabels = double(labels==cl{i}.className);
    %templabels = double(labels==1);
    [X,Y,T,AUC] = perfcurve(templabels,newscore(:,i),1);
    h(i) = plot(X,Y,colors(i),'LineWidth',3);
    legends{i} = strcat('ROC plot for class ',num2str(cl{i}.className));
    texts{i} = text(0.8,0.3-0.05*i,strcat('AUC of class ',num2str(cl{i}.className),'=',num2str(AUC)));
    set(texts{i},'FontSize',22,'FontWeight','bold');
end
hold off;
legend(h,legends);
xlabel('False positive rate');
ylabel('True positive rate')
end