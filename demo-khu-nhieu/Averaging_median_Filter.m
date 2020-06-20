I = rgb2gray(imread('lena.png'));
J = imnoise(I,'salt & pepper',0.02);

Kaverage = filter2(fspecial('average',3),J)/255;
Kmedian = medfilt2(J);

figure;

subplot(2,2,1);
imshow(I);
xlabel('a. Hình ảnh ban đầu');

subplot(2,2,2);
imshow(J)
xlabel('b. Hình ảnh khi nhiễu');

subplot(2,2,3);
imshow(Kaverage);
xlabel('c. Hình ảnh dùng averaging filter');

subplot(2,2,4);
imshow(Kmedian);
xlabel('d. Hình ảnh dùng median filter');