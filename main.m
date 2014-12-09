close all;
clear all;

load('all.mat');
%X = pca(X,30);
disp('PCA finished');
%% Shuffle
L = length(Y);
idx = randsample(L,L);
X = X(idx,:);
Y = Y(idx,:);

%% cross validation
trainRatio = 0.5;
num = round(trainRatio*L);
Xtrain = X(1:num,:);
Ytrain = Y(1:num,:);
Xtest = X(num+1:end,:);
Ytest = Y(num+1:end,:);
X_mean = mean(Xtrain,1);
X_std = std(Xtrain,1);
X_train = bsxfun(@rdivide, bsxfun(@minus,Xtrain,X_mean),X_std);
X_test = bsxfun(@rdivide, bsxfun(@minus,Xtest,X_mean),X_std);


%% multiSVM
tic;
clGauss = multiSVMfit(X_train,Ytrain,'Gauss');
toc
disp('Gaussian completed');
tic
clLinear = multiSVMfit(X_train,Ytrain,'Linear');
toc
%disp('Linear completed');
tic;
%clPoly = multiSVMfit(X_train,Ytrain,'Poly');
toc
%disp('Polynomial completed');

%for i=1:5
    
    [pred,scoresGauss] = multiSVMpredict(clGauss,X_test);
    %acc = sum(pred(:)==Ytest(:))/length(Ytest)
    %[~,scoresGauss] = multiSVMpredict(clGauss,X_train);
    %[~,scoresGauss] = svmPredict(clGauss,X_test);
    %[~,scoresLinear] = svmPredict(clLinear,X_test);
    [~,scoresLinear] = multiSVMpredict(clLinear,X_test);
    %[~,scoresPoly] = multiSVMpredict(clPoly,X_test);

    %pred_train = multiSVMpredict(cl,X_train);

    %test_accuracy = sum(pred'==Ytest)/length(Ytest);
    %train_accuracy = sum(pred_train'==Ytrain)/length(Ytrain);
    %figure(1)
    
    h1 = plotROC(Ytest,scoresGauss,clGauss,'rgbyk');
    %figure(1);
    %string = 'rgbyk'
    %h1{i} = plotROC(double(Ytest == clGauss{i}.className),scoresGauss,clGauss,string(i));
    %hold on;
    %hold on;
    %figure(2)

    h2 = plotROC(Ytest,scoresLinear,clLinear,'rgbyk');
    %h1{i} = plotROC(double(Ytest == clLinear{i}.className),scoresLinear,clLinear,string(i));

    %hold on;
    %h3 = plotROC(Ytest,scoresPoly,clPoly,'rgbyk');
%end

