clear;clc;close;

load('windex_ablation_Or.mat')
ab_Or_the_windex=w_thermoindex;
ab_Or_che_windex=w_chemoindex;
ab_Or_the_e=e_thermo;
ab_Or_che_e=e_chemo;

clear w_chemoindex w_thermoindex e_thermo e_chemo

load('windex_mockkill_Or.mat')
mk_Or_the_windex=w_thermoindex;
mk_Or_che_windex=w_chemoindex;
mk_Or_the_e=e_thermo;
mk_Or_che_e=e_chemo;
clear w_chemoindex w_thermoindex

% std
ab_Or_the_ste=sqrt(var(ab_Or_the_windex));
ab_Or_che_ste=sqrt(var(ab_Or_che_windex));
mk_Or_the_ste=sqrt(var(mk_Or_the_windex));
mk_Or_che_ste=sqrt(var(mk_Or_che_windex));

%ttest2
[h_the,p_the,ci_the,stats_the] = ttest2(ab_Or_the_windex,mk_Or_the_windex,'Vartype','unequal','Tail','both');
[h_che,p_che,ci_che,stats_che] = ttest2(ab_Or_che_windex,mk_Or_che_windex,'Vartype','unequal','Tail','both');

%plot
groupname={'mockkill','SMD-RMD co-ablation'};

%
thermoIndexfig=figure();
hold on
indexmean_thermo=[mean(mk_Or_the_windex),mean(ab_Or_the_windex)];
indexse_thermo=[mk_Or_the_e,ab_Or_the_e];

bar(1,indexmean_thermo(1),0.5,'FaceColor',"#FFBA00");
bar(2,indexmean_thermo(2),0.5,'FaceColor',"#00A1F0");

errorbar(indexmean_thermo,indexse_thermo,'k','LineStyle','none','LineWidth',1.0)

% text(b.XEndPoints,(b.YEndPoints-0.05),mat2strcell(roundn(b.YData,-3),'%.3f'),...
%     'HorizontalAlignment','center','VerticalAlignment','bottom')
ylim([-0.3,0])
xticks([1,2])
xticklabels(groupname)
ylabel('Thermo-index in NT+NC')
% title('Thermotaxis Index (Mean±SEM)')

saveas(thermoIndexfig,'thermoIndex.fig')
saveas(thermoIndexfig,'thermoIndex.svg')
disp('>> Saved thermoIndexfig')

%
chemoIndexfig=figure();
hold on
indexmean_chemo=[mean(mk_Or_che_windex),mean(ab_Or_che_windex)];
indexse_chemo=[mk_Or_che_e,ab_Or_che_e];

bar(1,indexmean_chemo(1),0.5,'FaceColor',"#FFBA00");
bar(2,indexmean_chemo(2),0.5,'FaceColor',"#00A1F0");
errorbar(indexmean_chemo,indexse_chemo,'k','LineStyle','none','LineWidth',1.0)
% text(b.XEndPoints,(b.YEndPoints-0.05),mat2strcell(roundn(b.YData,-3),'%.3f'),...
%     'HorizontalAlignment','center','VerticalAlignment','bottom')
ylim([-0.3,0])
% xticks(b.XEndPoints)
xticks([1,2])
xticklabels(groupname)
ylabel('Chemo-index in NT+NC')
% title('Thermotaxis Index (Mean±SEM)')

saveas(chemoIndexfig,'chemoIndex.fig')
saveas(chemoIndexfig,'chemoIndex.svg')
disp('>> Saved thermoIndexfig')