clear all; close all;
% 采样率和信号频率
fs = 1000;        % 采样率 (Hz)
f0 = 50;          % 干扰频率 (Hz)
Q = 35;           % 品质因数

% 计算Notch滤波器的系数
wo = 2*pi*f0/fs;  % 角频率
bw = wo/Q;        % 带宽

% 计算系数
alpha = sin(wo)/(2*Q);
b0 = 1;
b1 = -2*cos(wo);
b2 = 1;
a0 = 1 + alpha;
a1 = -2*cos(wo);
a2 = 1 - alpha;

b = [b0, b1, b2] / a0;
a = [a0, a1, a2] / a0;

% 生成测试信号（带有50 Hz干扰）
t = 0:1/fs:1;                 % 时间向量
x = sin(2*pi*100*t) + sin(2*pi*f0*t); % 测试信号：100 Hz和50 Hz的正弦波

% 应用Notch滤波器
y = filter(b, a, x);

% 绘制结果
figure;
subplot(3,1,1);
plot(t, x);
title('原始信号');
xlabel('时间 (秒)');
ylabel('幅值');

subplot(3,1,2);
plot(t, y);
title('滤波后的信号');
xlabel('时间 (秒)');
ylabel('幅值');

% 频谱分析
N = length(x);
X = fft(x);
Y = fft(y);
f = (0:N-1)*(fs/N);

subplot(3,1,3);
plot(f, abs(X)/N, 'b');
hold on;
plot(f, abs(Y)/N, 'r');
title('频谱');
xlabel('频率 (Hz)');
ylabel('幅值');
legend('原始信号', '滤波后的信号');
xlim([0 200]);
