%% Train TEST Grid Search
clear all
clc

load('all.mat');

L = length( Y );
idx = randsample( L, L);
X = X(idx, :);
Y = Y(idx);

trainRatio = 1;
num = round( trainRatio * L );
Xtrain = X( 1:num, :);
Xtest = X( num+1:end, : );
Ytrain = Y(1:num);
Ytest = Y(num+1:end);

X_mean = mean( Xtrain,1 );
X_std = std( Xtrain,1 );
Xtrain = bsxfun( @rdivide, bsxfun(@minus, Xtrain, X_mean), X_std);
Xtest = bsxfun( @rdivide, bsxfun( @minus, Xtest, X_mean), X_std);
%%%%%%%%%%%%%%%%%
sigma = 1.5;
n = length( sigma );
tic
model = multiSVMfit_GridSearch( Xtrain, Ytrain, sigma);
toc
train_length = length( Ytrain );
test_length = length( Ytest );
Y_pre_train = zeros ( train_length, n);
Y_pre_test = zeros (test_length, n);
TESTaccuracy = zeros(1,n);
TRAINaccuracy = zeros(1,n);
for i = 1:n
    Y_pre_train(:,i) = multiSVMpredict( model{i}, Xtrain)';

    Y_pre_test(:,i) = multiSVMpredict( model{i}, Xtest)';

    TESTaccuracy(i) = sum( Ytest == Y_pre_test(:,i) ) / test_length;
    TRAINaccuracy(i) = sum( Ytrain == Y_pre_train(:,i) ) / train_length;
end

[bestTrainAccu,bestIdx_train] = max(TRAINaccuracy);
[bestTestAccu,bestIdx_test] = max(TESTaccuracy);
best_sigma_train = sigma(bestIdx_train);
best_sigma_test = sigma(bestIdx_test);