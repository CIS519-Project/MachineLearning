function sim = polyKernel(x1,x2,d)

x1 = x1(:);
x2 = x2(:);

sim = (x1'*x2+1)^d;

end
