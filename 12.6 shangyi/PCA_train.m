function [X_pca,coefs,mu, D] = PCA_train(X, d)
%  Principal component analysis to reduce dimension of X
%   X - the raw training dataset 
%   d - the expected dimension

[coefs,score,~]=princomp(X,'econ');
% c is the number of column of X
[~,c1] = size(X); 
[~,c2] = size(score); 
% make sure that d is less or equal than c
D = min(min(d,c1),c2);
X_pca = score(:,1:D);

mu = mean(X);
end