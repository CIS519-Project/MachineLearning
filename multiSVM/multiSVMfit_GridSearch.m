function cl = multiSVMfit_GridSearch(X,Y,sigma)

    C = 0.01;
if ~exist('sigma', 'var') || isempty(sigma)
    sigma = [ 0.1,  0.5,  1,  1.5,  2,  3,  4,  5];
end 

    classTypes = unique(Y);
    %classTypes
    %cl = []
    modelNum=0;
for s = sigma
    modelNum = modelNum + 1
    for i=1:length(classTypes)
        Ytemp = double((Y==classTypes(i)));
        cl{modelNum}{i} = svmTrain(X,Ytemp,C,@(x1,x2) gaussianKernel(x1,x2,s),classTypes(i), 1e-3, 50);
%         cl{i} = svmTrain(X,Ytemp,C,@linearKernel,classTypes(i), 1e-3, 20);
    end   
end
end