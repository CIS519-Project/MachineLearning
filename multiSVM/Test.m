%% Train TEST
clear all
clc

load('all.mat');

L = length( Y );
idx = randsample( L, L);
X = X(idx, :);
Y = Y(idx);

trainRatio = 0.5;
num = round( trainRatio * L );
Xtrain = X( 1:num, :);
Xtest = X( num+1:end, : );
Ytrain = Y(1:num);
Ytest = Y(num+1:end);

X_mean = mean( Xtrain,1 );
X_std = std( Xtrain,1 );
Xtrain = bsxfun( @rdivide, bsxfun(@minus, Xtrain, X_mean), X_std);
Xtest = bsxfun( @rdivide, bsxfun( @minus, Xtest, X_mean), X_std);
tic
model = multiSVMfit( Xtrain, Ytrain);
toc

Y_pre_train = multiSVMpredict( model, Xtrain);
Y_pre_train = Y_pre_train';

Y_pre_test = multiSVMpredict( model, Xtest);
Y_pre_test = Y_pre_test';

TESTaccuracy = sum( Ytest == Y_pre_test) / length( Ytest );
TRAINaccuracy = sum( Ytrain == Y_pre_train) / length( Ytrain );
