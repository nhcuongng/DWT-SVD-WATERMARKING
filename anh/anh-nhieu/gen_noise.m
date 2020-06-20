I = rgb2gray(imread('peppers.png'));
J = imnoise(I,'salt & pepper',0.02);
imwrite(J, strcat("peppers_noise", '.png'))