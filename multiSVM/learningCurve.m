function [accuracyTest,accuracyTrain] = learningCurve(X,Y,n)
L = length(Y);
oneTenths = floor(L/10);
accuracyTest = zeros(n*10,10);
accuracyTrain = zeros(n*10,10);
tic;
for trail=1:n
    
    idx = randsample(L,L);
    X = X(idx,:);
    Y = Y(idx,:);
    for i = 1:10
        i
        Xtest = X((i-1)*oneTenths+1:min(i*oneTenths,L),:);
        Ytest = Y((i-1)*oneTenths+1:min(i*oneTenths,L),:);
        Xtrain = [X(1:(i-1)*oneTenths,:);
                X(min(i*oneTenths+1,L):end,:)];
        Ytrain = [Y(1:(i-1)*oneTenths,:);
                Y(min(i*oneTenths+1,L):end,:)];
        for j = 1:10
            tic;
            trainRatio = 0.1*j;
            num = round(trainRatio*length(Ytrain));
            X_train = Xtrain(1:num,:);
            Y_train = Ytrain(1:num,:);
            X_mean = mean(X_train,1);
            X_std = std(X_train,1);
            X_train = bsxfun(@rdivide, bsxfun(@minus,X_train,X_mean),X_std);
            X_test = bsxfun(@rdivide, bsxfun(@minus,Xtest,X_mean),X_std);
            
            
            cl = multiSVMfit(X_train,Y_train,'Gauss');
            [predTest,~] = multiSVMpredict(cl,X_test);
            [predTrain,~] = multiSVMpredict(cl,X_test);
            accuracyTest(10*(trail-1)+i,j) = sum(predTest(:)==Ytest(:))/length(Ytest);
            accuracyTrain(10*(trail-1)+i,j) = sum(predTrain(:)==Ytest(:))/length(Ytest);

            clear cl;

        end
    end
end
toc
end
