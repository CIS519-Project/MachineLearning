function [X_test_pca] = PCA_test(Xtest, coefs, mu, D)
%  Principal component analysis to reduce dimension of X
%   X - the raw training dataset 
%   coefs - the coefs got from PCA_train
%   mu - the center of X
%   D - the expected dimension

Xtest = bsxfun(@minus,Xtest,mu); % center the test data
X_test_pca = Xtest*coefs(:,1:D);
end