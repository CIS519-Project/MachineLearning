function X_pca = reduceDimension(X, d)
%  Principal component analysis to reduce dimension of X
%   X - the raw training dataset 
%   d - the expected dimension

[~,score,~]=princomp(X);
% c is the number of column of X
[~,c] = size(X); 
% make sure that d is less or equal than c
D = min(d,c);
X_pca = score(:,1:D);
end