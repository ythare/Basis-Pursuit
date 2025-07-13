function [H_binary] = Natural_Hadamard(image_size, sample)
    % 生成Hadamard矩阵
    if bitand(image_size, image_size - 1) ~= 0 || image_size < 1
        error('Size must be a power of 2.');
    end

    n = image_size * image_size;
    % 生成指定阶数的Hadamard矩阵
    H = hadamard(n);
    % 将-1/+1转换为0/1
    H_binary = (H + 1) / 2;
    % 重塑为二维模式 (size_val x size_val)
    % 初始化三维数组存储所有模式
    patterns = zeros(round(n * sample), image_size * image_size);
    % 将每行重塑为二维模式
    for i = 1:round(n * sample)
        patterns(i, :) = H_binary(i, :);
    end

    H_binary = patterns;
end
