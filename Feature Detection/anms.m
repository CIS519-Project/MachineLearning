function [y,x,rmax]=anms(cimg,max_pts)
%Written by Shangyi
%Adaptive Non-maxima Suppression
%cimg harris-score image
%max_pts max corner feature number
%y,x position of the corner feature
%rmax least distance between two corner features
CMmin=min(min(cimg));
CMmax=max(max(cimg));
CM_adjusted=(cimg-CMmin)/(CMmax-CMmin);
cr_peak=imregionalmax(CM_adjusted);
[H,W]=size(cr_peak);
E=20;
cr_peak([1:E,H-E:H],:)=0;
cr_peak(:,[1:E,W-E:W])=0;
cr_idx=find(cr_peak==1);
%Threshold Control
[~,I]=sort(CM_adjusted(cr_idx),'descend');
cr_idx=cr_idx(I(1:max(max_pts,round(0.3*length(I)))));

R=zeros(size(cr_idx));
[row,col]=ind2sub(size(CM_adjusted),cr_idx);
for i=1:length(cr_idx)
    corner=CM_adjusted(row(i),col(i));
    idx=find(CM_adjusted(cr_idx)>corner);
    ROW=row(idx);
    COL=col(idx);
    if isempty(ROW)
        R(i)=inf;
    else   
        dis=sqrt((row(i)-ROW).^2+(col(i)-COL).^2);
        R(i)=min(dis);
    end
end
[~,topIdx]=sort(R,'descend');
L_topIdx=length(topIdx);
I_rmax=min(max_pts,L_topIdx);
rmax=R(topIdx(I_rmax));
x=col(topIdx(1:I_rmax));
y=row(topIdx(1:I_rmax));