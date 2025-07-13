clc; clear; close all;
%% measurements
sample = 0.8; % 采样率`
N = 64; % 图像尺寸
x0 = im2double(im2gray((imread('graylena64.bmp'))));
x0_vec = x0(:); % 展平为向量
n = length(x0_vec);
m = round(sample * n); % 采样率
A = Walsh_Hadamard(N, sample); % 哈达玛测量矩阵
% A = Natural_Hadamard(N, sample);
A = A ./ vecnorm(A, 2, 2); % 每行归一化
y = A * x0_vec; % 单像素测量值
%% 重建
path(path, './Optimization');
% 初始解
x0_init = A' * y;
% 调用 Basis Pursuit 求解器     形式：l1eq_pd(x0, A, At, y, tol, max_iter)
recon = l1eq_pd(x0_init, A, A', y, 1e-4, 1000);

% === 4. 可视化结果 ===
figure;
subplot(1, 3, 1);
imshow(x0); title('原始图像');

subplot(1, 3, 2);
imshow(reshape(recon, N, N)); axis image;
title('Basis Pursuit 重建');

subplot(1, 3, 3);
imshow(abs(reshape(recon - x0_vec, N, N))); axis image;
title('误差图');
