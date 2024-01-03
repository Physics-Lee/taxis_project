%1.before running this code, please check line11 to add or change save path
%2.check line18 to change i range(eg: for i = 2:9, we have 9 groups of data
%to be analyzed), then run the code.
% wrote by zbz

clear
close all
clc

%set file path for some figures and workspace files
desFolder = 'G:\wp\smd-minisog-ortho-exp';

%read
[pathname filename]=uigetfile('*.bat','choose a file');
str=[filename pathname];
createTimingInfoForFileSets(str);
eset1 = ExperimentSet.fromFiles; %load experiments
eset = eset1;

for i = 2:3
    [pathnamei filenamei]=uigetfile('*.bat','choose a file');
    str=[filenamei pathnamei];
    createTimingInfoForFileSets(str);
    eseti = ExperimentSet.fromFiles; %load experiments
    eset.expt(i) = eseti.expt;
    i = i+1;
end


%stitching tracks
maxFrameInterval=94;
maxDist=30;
eset.executeExperimentFunction('stitchTracks', maxFrameInterval, maxDist, 'interactive', true);

%cleaning up bad tracks
ecl = ESetCleaner();
ecl.minSpeed = 0.5; %minimum average speed of the track to be kept(use 1.0 for N2 and 0.3 for mutant) (points/s)
ecl.minDist = 100; %minimum distance must travel from the starting point to be kept (points)
ecl.minPts = 400; %minimum number of points to be kept (points)
ecl.clean(eset);

%trim tracks
timerange=[300 1200]; %[t0 t1], the range of times (seconds)
validrect=[]; %VALIDRECT: [x0 y0 x1 y1], the space of valid positions
eset.executeExperimentFunction('trimTracks', timerange, validrect);

%segment tracks into runs and reorientations
eset.executeExperimentFunction('segmentTracks');


%plot all the tracks with the start of tracks superposed at the center
figure
hold on;
eset.executeTrackFunction('plotPath', 'displacement'); % plot all paths
plot (0,0, 'r.', 'MarkerSize', 20); % put a red dot at 0,0
axis equal;

%calculate the thermotaxis index
xspeed=[];
t=[];
for i=1:length(eset.expt)
    for j=1:length(eset.expt(i).track)
        location=eset.expt(i).track(j).getDerivedQuantity('iloc');
        xk=location(1,:);
        tk=eset.expt(i).track(j).getDerivedQuantity('eti');
        xbb=xk-xk(1);
        xbb=xbb/20; % to mm per sec
        tbb=tk-tk(1);
        xp=xbb(end)/tbb(end);
        xspeed=[xspeed, xp];
        t=[t,tbb(end)];
    end
end

runsp = eset.gatherFromSubField('run', 'speed');
runsp=runsp/20;

%%%extract mean runspeed of each tracks
for i = 1:length(eset.expt)
    for j =1:length(eset.expt(i).track)
        runsp_individualWorm(i,j) = mean(eset.expt(i).track(j).dq.speed)/20;
    end
end
runsp_individualWorm = runsp_individualWorm';
runsp_individualWorm = nonzeros(runsp_individualWorm(:));
runsp_individualWorm = runsp_individualWorm';

%%%index of tracks
thermoindex=xspeed./runsp_individualWorm;
m = wmean(thermoindex,t);
n = length(thermoindex);
e=sqrt(var(thermoindex,t)/n);
disp(['    thermotaxis index  ' num2str(m) '   ' ' standard error  ' num2str(e)]);
w_thermoindex = ((thermoindex.*t)/sum(t))*n;


%calculate the chemotaxis index
yspeed=[];
t=[];
for i=1:length(eset.expt)
    for j=1:length(eset.expt(i).track)
        location=eset.expt(i).track(j).getDerivedQuantity('iloc');
        yk=location(2,:);
        tk=eset.expt(i).track(j).getDerivedQuantity('eti');
        ybb=yk-yk(1);
        ybb=ybb/20; % to mm per sec
        tbb=tk-tk(1);
        yp=ybb(end)/tbb(end);
        yspeed=[yspeed, yp];
        t=[t,tbb(end)];
    end
end

%%%index of tracks
chemoindex = yspeed./runsp_individualWorm;
m = wmean(chemoindex,t);
n = length(chemoindex);
e=sqrt(var(chemoindex,t)/n);
disp(['    chemotaxis index  ' num2str(m) '   ' ' standard error  ' num2str(e)]);
for i = 1:length(eset.expt)
    disp([num2str(length(eset.expt(i).track)),' tracks met critiria.'])
end
w_chemoindex = ((chemoindex.*t)/sum(t))*n;

%counts at different run directions
figure
hold on
thetaAxis = deg2rad(0:30:360);
eset.makeSubFieldHistogram('run', 'meanTheta', thetaAxis, 'polar', true, 'r2d', true);
title('counts at different run directions')

%run durationsm at different directions
figure
hold on
rundirection = eset.gatherSubField('run', 'meanTheta');
runduration = eset.gatherSubField('run', 'runTime');
scatter (rad2deg(rundirection), runduration);
ylabel('run durations/s');
xlabel('run directions/бу');
title('run durationsm at different directions');

%run speed at different directions
figure
hold on
thetaAxis = deg2rad(-180:0.1:180);
[newtheta, meanspeed] = eset.meanField2vsField1('theta', 'speed', thetaAxis, 'run');
scatter (rad2deg(newtheta), meanspeed);
ylabel('run speed');
xlabel('run directions/бу');
title('run speed at different directions');

fig = gcf;
hfig = fig;
[xdata,ydata] = extract_data_from_fig(hfig);
xdata  = deg2rad(xdata);
for i = 1:length(xdata)
    if xdata(1,i)>-pi/8 && xdata(1,i)<pi/8
        spup(i) = ydata(1,i);
    elseif xdata(1,i)<-pi*7/8  ||  xdata(1,i)>pi*7/8
        spdown(i) = ydata(1,i);
    end
end
d1 = mean(spup(spup~=0));
d2 = mean(spdown(spdown~=0));
u1 = std(spup(spup~=0));
u2 = std(spdown(spdown~=0));
o1 = u1/sqrt(length(spup(spup~=0)));
o2 = u2/sqrt(length(spdown(spdown~=0)));
spup = spup(spup~=0)/20;
spdown = spdown(spdown~=0)/20;
[H,P,CI] = ttest2(spup,spdown)

disp(['    up speed  ' num2str(d1) '   ' ' down speed  ' num2str(d2)]);

ms = mean(runsp);
e0 = sqrt(var(runsp)/length(runsp));
disp(['    thermotaxis meanspeed  ' num2str(ms) '   ' ' standard error  ' num2str(e0)]);

sp_mean=[d1 d2];
sp_err=[o1 o2];
figure;
bar(sp_mean);
hold on
errorbar(sp_mean, sp_err, 'xr');
ylabel ('mean run speed');
title('mean run speed');
set(gca,'XTickLabel',{'up','down'});

%quantity of sharpturns and reorientations
for i = 1:length(eset.expt)
    for j = 1:length(eset.expt(i).track)
        sharpTurn(i,j) = length(eset.expt(i).track(j).sharpTurn);
        reorientation(i,j) = length(eset.expt(i).track(j).reorientation);
    end
end
sum1 = sum(sharpTurn(: ));
sum2 = sum(reorientation(: ));
disp(['    sharpturn quantity  ' num2str(sum1) '   ' ' reorientation quantity  ' num2str(sum2)]);

for i = 1:length(eset.expt)
    for j = 1:length(eset.expt(i).track)
        mtracksharpturn (i,j) = mean(length(eset.expt(i).track(j).sharpTurn));
        mtrackesetreo(i,j) = mean(length(eset.expt(i).track(j).reorientation));
    end
end
m1 = mean(mtracksharpturn(mtracksharpturn~=0));
m2 =  mean(mtrackesetreo(mtrackesetreo~=0));
disp(['    mean track sharpturn  ' num2str(m1) '   ' ' mean track reorientation  ' num2str(m2)]);



%runlength: run_up run_down
runLength = [];
for i = 1:length(eset.expt)
    for j =1:length(eset.expt(i).track)
        runLength = nancat(2,runLength,getAllrunLengthFromOneTrack(eset.expt(i).track(j)));
    end
end

rundirection = [];
for i = 1:length(eset.expt)
    for j =1:length(eset.expt(i).track)
        rundirection = nancat(2,rundirection,getAllrundirectionFromOneTrack(eset.expt(i).track(j)));
    end
end

run_length_theta = nancat (1,runLength,rundirection);

% the data of runtime and runlength is stored in run_length_theta
runlen = [];
run_up = [];
run_down = [];
for i = 1:length(run_length_theta)
    % the first line is runtime(runlengrh);the second line is meantheta(each run)
    rundir =  run_length_theta(2,:);
    runlen =  run_length_theta(1,:);
    if rundir(i) > -pi/8 && rundir(i) < pi/8
        run_up=[run_up, runlen(i)];
    elseif rundir(i)<-pi*7/8 || rundir(i)>pi*7/8
        run_down=[run_down, runlen(i)];
    end
end


m_run_up = mean(run_up)
L_run_up = length(run_up);
s_run_up = std(run_up);
e_run_up = std(run_up)/sqrt(L_run_up);
m_run_down = mean(run_down)
L_run_down = length(run_down);
s_run_down = std(run_down);
e_run_down = std(run_down)/sqrt(L_run_down);
[H,P,CI] = ttest2(run_up,run_down)

run_mean=[m_run_up m_run_down];
run_err=[e_run_up e_run_down];
figure;
bar(run_mean);
hold on
errorbar(run_mean, run_err, 'xr');
ylabel ('mean run length (s)');
title('mean run length');
set(gca,'XTickLabel',{'runs up','runs down'});





n = get(gcf,'Number')  %get the number of figures
for i = 1:n
    hfig = figure(i);
    set(gca,'FontSize',18);
    box off;
    set(gca,'color','none');
end


%Save the file to a specific folde
save([desFolder,'\eset.mat'],'eset');
save([desFolder,'\spup.mat'],'spup');
save([desFolder,'\spdown.mat'],'spdown');
save([desFolder,'\sharpTurn.mat'],'sharpTurn');
save([desFolder,'\run_up.mat'],'run_up');
save([desFolder,'\run_down.mat'],'run_down');
save([desFolder,'\reorientation.mat'],'reorientation');
save([desFolder,'\thermoindex.mat'],'thermoindex');
save([desFolder,'\w_thermoindex.mat'],'w_thermoindex');
save([desFolder,'\chemoindex.mat'],'chemoindex');
save([desFolder,'\w_chemoindex.mat'],'w_chemoindex');
save([desFolder,'\runsp.mat'],'runsp');
save([desFolder,'\runsp_individualWorm.mat'],'runsp_individualWorm');
save([desFolder,'\t.mat'],'t');

%Save figures to a specific folde
% saveas(hfig, [desFolder,'\1.m']);
hfig = figure(1);
saveas(hfig, [desFolder,'\1.m']);
hfig = figure(2);
saveas(hfig, [desFolder,'\2.m']);
hfig = figure(3);
saveas(hfig, [desFolder,'\3.m']);
hfig = figure(4);
saveas(hfig, [desFolder,'\4.m']);
hfig = figure(5);
saveas(hfig, [desFolder,'\5.m']);
hfig = figure(6);
saveas(hfig, [desFolder,'\6.m']);
hfig = figure(10);
saveas(hfig, [desFolder,'\track.m']);

