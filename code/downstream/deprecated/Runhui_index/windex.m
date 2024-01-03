clear
clc
close

load('D:\Nut_store\high throughout system\data\smd-rmd-coablation\Or\test\eset.mat')

%% thermo

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
e_thermo=sqrt(var(thermoindex,t)/n);
disp(['    thermotaxis index  ' num2str(m) '   ' ' standard error  ' num2str(e_thermo)]);
w_thermoindex = ((thermoindex.*t)/sum(t))*n;


%% chemo

yspeed=[];
t=[];
for i=1:length(eset.expt) 
    for j=1:length(eset.expt(i).track)
           location=eset.expt(i).track(j).getDerivedQuantity('iloc');
           xk=location(2,:);
           tk=eset.expt(i).track(j).getDerivedQuantity('eti');
           xbb=xk-xk(1);
           xbb=xbb/20; % to mm per sec
           tbb=tk-tk(1);
           xp=xbb(end)/tbb(end);
           yspeed=[yspeed, xp];
           t=[t,tbb(end)];
    end
end

%%%index of tracks
chemoindex=yspeed./runsp_individualWorm;
m = wmean(chemoindex,t);
n = length(chemoindex);
e_chemo=sqrt(var(chemoindex,t)/n);
disp(['    chemotaxis index  ' num2str(m) '   ' ' standard error  ' num2str(e_chemo)]);
w_chemoindex = ((chemoindex.*t)/sum(t))*n;