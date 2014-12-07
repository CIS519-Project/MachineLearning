function cl = multiSVMfit(X,Y,varargin)

    C = 1.0;
    sigma = 0.1;

    classTypes = unique(Y);
    %classTypes
    %cl = [];
    for i=1:length(classTypes)
        Ytemp = double((Y==classTypes(i)));
        cl{i} = svmTrain(X,Ytemp,C,@(x1,x2) gaussianKernel(x1,x2,sigma),classTypes(i));
        %cl{i} = svmTrain(X,Ytemp,C,@linearKernel,classTypes(i), 1e-3, 20);
    end
end