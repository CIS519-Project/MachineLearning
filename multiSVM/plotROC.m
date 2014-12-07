function h = plotROC(labels,scores,cl,colors)
newscore = zeros(size(scores));
for i =1:size(scores,2)
    newscore(:,i) = (scores(:,i)-min(scores(:,i)))/(max(scores(:,i))-min(scores(:,i)));
end
figure;
hold on;
classType = unique(labels);
for i=1:length(classType)
    templabels = double(labels==cl{i}.className);
    [X,Y,T,AUC] = perfcurve(templabels,newscore(:,i),1);
    h(i) = plot(X,Y,colors(i));
    legends{i} = strcat('ROC plot for class',num2str(cl{i}.className));
end
hold off;
legend(h,legends);
end