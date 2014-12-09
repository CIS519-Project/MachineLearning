function cl = multiSVMfit(X,Y,kernelType)

    C = 0.01;
    sigma = 4;

    classTypes = unique(Y);
    %classTypes
    %cl = [];
    for i=1:length(classTypes)
        Ytemp = double((Y==classTypes(i)));
<<<<<<< HEAD
        switch kernelType
            case 'Gauss'
                cl{i} = svmTrain(X,Ytemp,C,@(x1,x2) gaussianKernel(x1,x2,sigma),classTypes(i));%,1e-4,20);
            case 'Linear'
                cl{i} = svmTrain(X,Ytemp,C,@linearKernel,classTypes(i),1e-4,20);
            case 'Poly'
                cl{i} = svmTrain(X,Ytemp,C,@(x1,x2) polyKernel(x1,x2,d),classTypes(i),1e-4,20);
        end
        cl{i} = svmTrain(X,Ytemp,C,@(x1,x2) gaussianKernel(x1,x2,sigma),classTypes(i), 1e-3, 50);
=======
        cl{i} = svmTrain(X,Ytemp,C,@(x1,x2) gaussianKernel(x1,x2,sigma),classTypes(i), 1e-4, 20);
>>>>>>> edf9b25d6108604c68a4e9348f204419e94890f9
%         cl{i} = svmTrain(X,Ytemp,C,@linearKernel,classTypes(i), 1e-3, 20);
    end
end