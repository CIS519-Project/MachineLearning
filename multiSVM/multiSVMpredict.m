function [prediction,score] = multiSVMpredict(cl,X)
    classLength = length(cl);
    score = zeros(length(X(:,1)),classLength);
    
    for i=1:classLength
        className(i) = cl{i}.className;
        [~,scoreTemp] = svmPredict(cl{i},X);
        score(:,i) = scoreTemp;
    end
    className(classLength+1) = 0;
    noneClass = all(score<0,2);
    any(noneClass);
        
    [~,I] = max(score,[],2);
    prediction = className(I);
    prediction(noneClass) = 0;
end