function [x,r_mean,r_stm]=averaged_correlation(l,corr,drawfigure)
[l_sorted,index]=sort(l);
h=(l_sorted(end)-l_sorted(1))/500;
x=l_sorted(1)+h/2:h:l_sorted(end)-h/2;
y=hist(l_sorted,x);
clock=1;
i=1;
while i<=length(l_sorted)
    r=zeros(1,y(clock));
    for k=1:y(clock)
        r(k)=corr(index(i));
        i=i+1;
    end
    r_mean(clock)=mean(r);
    r_stm(clock)=std(r)/sqrt(y(clock));
    r_std(clock)=std(r);
    clock=clock+1;
end
if drawfigure
    figure,errorbar(x,r_mean,r_stm,'k.');
end
%return;
%if max(r_mean>10)
%    disp(file);
%end
%hold on, plot(x,r_mean,'rs','LineWidth',1,...
%                'MarkerEdgeColor','r',...
%                'MarkerFaceColor','y',...
%                'MarkerSize',6);
%plot(x,r_mean,'-k.');hold on;
