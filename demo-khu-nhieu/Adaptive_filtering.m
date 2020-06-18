RGB = imread('act_logo.tif');
I = rgb2gray(RGB);
J = imnoise(I,'gaussian',0,0.025);

K = wiener2(J,[5 5]);

figure;
subplot(2,1,1)
imshow(J);
title('Hình ảnh đã thêm Gaussian Noise');
subplot(2,1,2)
imshow(K);
title('Hình ảnh đã xoá nhiễu bởi Wiener Filter');
