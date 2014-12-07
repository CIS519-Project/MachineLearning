close all;
r1 = 3*rand(100,1);
t1 = pi/6*rand(100,1);
data1 = [r1.*cos(t1),r1.*sin(t1)];
r2 = 3*rand(100,1); % Radius
t2 = pi/6*rand(100,1)+pi/6;      % Angle
data2 = [r2.*cos(t2), r2.*sin(t2)]; % points
r3 = 3*rand(100,1); % Radius
t3 = pi/6*rand(100,1)+pi/3;      % Angle
data3 = [r3.*cos(t3), r3.*sin(t3)]; % points

figure;
plot(data1(:,1),data1(:,2),'r.','MarkerSize',15)
hold on
plot(data2(:,1),data2(:,2),'b.','MarkerSize',15)
plot(data3(:,1),data3(:,2),'g.','MarkerSize',15)

ezpolar(@(x)1);ezpolar(@(x)2);
axis equal
hold off

data = [data1;data2;data3];
y = 1*ones(300,1);
y(101:200) = 2;
y(201:end) = 3;

cl = multiSVMfit(data,y);
d = 0.02;
[x1Grid,x2Grid] = meshgrid(min(data(:,1)):d:max(data(:,1)),...
     min(data(:,2)):d:max(data(:,2)));
xGrid = [x1Grid(:),x2Grid(:)];
[test,scores] = multiSVMpredict(cl,xGrid);
h = gscatter(data(:,1),data(:,2),y,'rbg','.');
figure;
h2 = gscatter(xGrid(:,1),xGrid(:,2),test,'rbgy','.');
hold on;
h = gscatter(data(:,1),data(:,2),y,'rbg','o');

% C = 1; sigma = 0.1;
% ytemp = double((y==1));
% all(ytemp==y)
% cl = svmTrain(data,ytemp, C, @(x1, x2) gaussianKernel(x1, x2, sigma),1);
% 
% d = 0.02;
% [x1Grid,x2Grid] = meshgrid(min(data(:,1)):d:max(data(:,1)),...
%     min(data(:,2)):d:max(data(:,2)));
% xGrid = [x1Grid(:),x2Grid(:)];
% [test,scores] = svmPredict(cl,xGrid);
% test;
% figure;
% h2 = gscatter(xGrid(:,1),xGrid(:,2),test,'rb','.')
% figure;
% visualizeBoundary(data, y, cl);

% figure;
% h(1:2) = gscatter(data(:,1),data(:,2),y,'rbg','.');
% hold on
% ezpolar(@(x)1);
% h(3) = plot(data3(cl.IsSupportVector,1),data3(cl.IsSupportVector,2),'ko');
% contour(x1Grid,x2Grid,reshape(scores(:,2),size(x1Grid)),[0 0],'k');
% legend(h,{'1','2','Support Vectors'});
% axis equal
% hold off
