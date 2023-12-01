clc;clear;close all;

% 定义时间序列参数
frame_rate = 100;
t = 0:1/frame_rate:100; % 时间向量
f = 10; % 频率，决定周期
A = 1; % 振幅

% 生成周期性时间序列（正弦波）
series = A * sin(2 * pi * f * t);

% 添加噪声
noise = 0 * randn(size(t)); % 噪声振幅为0.5
series_noisy = series + noise;

%
figure;
plot(t,series_noisy);
xlim([0,10]);
xlabel('t (s)');
ylabel('signal');
title(sprintf('frame rate: %d', frame_rate));

% 计算并绘制自相关
[acf, lags] = autocorr(series_noisy, 'NumLags', 100);
figure;
stem(lags, acf);
xlabel('Lag in frame');
ylabel('Autocorrelation');
title('Autocorrelation of the Noisy Time Series');
