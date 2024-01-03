Marc 和 Linjiao 留下的代码，算index时算的亦是加权平均数。只是，他们用轨迹的时间作为权重，我用轨迹的距离作为权重（差别不会很大，因为虫子爬行在实验时间尺度上是匀速的，我验证过）。

```matlab
m = wmean(thermoindex,t);
n = length(thermoindex);
e=sqrt(var(thermoindex,t)/n);
disp(['    thermotaxis index  ' num2str(m) '   ' ' standard error  ' num2str(e)]);
w_thermoindex = ((thermoindex.*t)/sum(t))*n;
```

