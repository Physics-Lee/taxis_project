% [run_disp,~]=getdispandtheta(eset);
load('run_disp.mat');
run_disp=run_disp';

N = length(run_disp);
h = 0;
for i=1:N
    l = size(run_disp{i},2)-2;
    if l>=1
        h = h + l;
    end
end


corr=angular_correlation3(run_disp);

[~,I]=sort(corr(:,1),1);
h = length(corr);
corr_sorted = zeros(h,2);

for j=1:length(corr)
    corr_sorted(j,:)=corr(I(j),2:end);
end

M = 4;
h = 2*pi/M;
%x=-pi+h/2:h:pi-h/2;
x=-pi:h:pi;
counts=hist(corr(:,1),x);


pl = cell(M,1);
theta_correlation = cell(M,1);
errorbar_theta_correlation = cell(M,1);
n = 1;
for j=1:M
    [pl{j},theta_correlation{j},errorbar_theta_correlation{j}]=...
        averaged_correlation(corr_sorted(n:n+counts(j)-1,2),corr_sorted(n:n+counts(j)-1,1),0);
    n=n+counts(j);
end

%h = pi/4;
%x=-pi+h/2:h:pi-h/2;
%counts=hist(corr(:,1),x);


%n = sum(counts(1:7));
%corr1 = [corr_sorted(1:counts(1),:);corr_sorted(n+1:n+counts(8),:)];
%corr2 = [corr_sorted(counts(1)+1:counts(1)+counts(2),:);corr_sorted(counts(1)+counts(2)+1:counts(1)+counts(2)+counts(3),:)];
%n = sum(counts(1:3));
%corr3 = [corr_sorted(n+1:n+counts(4),:);corr_sorted(n+counts(4)+1:n+counts(4)+counts(5),:)];
%n = sum(counts(1:5));
%corr4 = [corr_sorted(n+1:n+counts(6),:);corr_sorted(n+counts(6)+1:n+counts(6)+counts(7),:)];

%[pl{1},theta_correlation{1},errorbar_theta_correlation{1}]=averaged_correlation(corr1(:,2),corr1(:,1),0);
%[pl{2},theta_correlation{2},errorbar_theta_correlation{2}]=averaged_correlation(corr2(:,2),corr2(:,1),0);
%[pl{3},theta_correlation{3},errorbar_theta_correlation{3}]=averaged_correlation(corr3(:,2),corr3(:,1),0);
%[pl{4},theta_correlation{4},errorbar_theta_correlation{4}]=averaged_correlation(corr4(:,2),corr4(:,1),0);

c = jet(M);


figure(2);

%[f,xi]=ksdensity(pl(1));
%plot(xi,f);


for j = 1:M
%     plot(pl{j}*50/1000,theta_correlation{j},'Color',c(j,:))
    errorbar(pl{j}*50/1000,theta_correlation{j},errorbar_theta_correlation{j},'Color',c(j,:));
    xlim([0,10]);
    hold on;
end
%legend('[-\pi, -3/4\pi]','[-3/4\pi, -1/2\pi]','[-1/2\pi, -1/4\pi]','[-1/4\pi, 0]','[0, 1/4\pi]','[1/4\pi,1/2\pi]','[1/2\pi,3/4\pi]','[3/4\pi,\pi]');
%legend('[-\pi, -3/4\pi]\cup[3/4\pi, \pi]','[-3/4\pi, -1/4\pi]','[-1/4\pi, 1/4\pi]','[1/4\pi, 3/4\pi]');
legend('[-\pi, -\pi/2]','[-\pi/2, 0]','[0, 1/2\pi]','[1/2\pi, \pi]');
ylabel('<cos \theta>');
%ylabel('<\Delta\theta(x)\Delta\theta(x+l)>');
xlabel('run length (mm)');
title ('N2 ortho');
saveas( 2, 'aib-cos.jpg'); 