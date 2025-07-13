function [H_binary] = Walsh_Hadamard(image_size, sample)
    % 生成Hadamard矩阵
    if bitand(image_size, image_size - 1) ~= 0 || image_size < 1
        error('Size must be a power of 2.');
    end

    n = image_size * image_size;
    % 生成指定阶数的Hadamard矩阵
    H = walsh(n);
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

function w = walsh(m)
    N = log2(m);
    x = hadamard(m);
    walsh = zeros(m);
    graycode = gen_gray_code(N);
    nh1 = zeros(m, N);

    for i = 1:m
        q = graycode(i, :);
        nh = 0;

        for j = N:-1:1
            nh1(i, j) = q(j) * 2 ^ (j - 1);
        end

        nh = sum(nh1(i, :));
        walsh(i, :) = x(nh + 1, :);
    end

    w = walsh;
end

function gray_code = gen_gray_code(N)
    sub_gray = [0; 1];

    for n = 2:N
        top_gray = [zeros(1, 2 ^ (n - 1))' sub_gray];
        bottom_gray = [ones(1, 2 ^ (n - 1))' sub_gray];
        bottom_gray = bottom_gray(end:-1:1, :);
        sub_gray = [top_gray; bottom_gray];
    end

    gray_code = sub_gray;
end
