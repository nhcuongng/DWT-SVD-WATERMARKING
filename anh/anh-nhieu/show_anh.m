% figure;
% subplot(2,2,1);
% imshow('lena_noise.png')
% xlabel('lena noise.png')
% subplot(2,2,2);
% imshow('mandril_noise.png')
% xlabel('mandril noise.png')
% subplot(2,2,3);
% imshow('peppers_noise.png')
% xlabel('peppers noise.png')

first_image = "lena_noise.png";
second_image = "mandril_noise.png";
third_image = "peppers_noise.png";

if true
 figure;
subplot(3,3,1),imshow(first_image);
subplot(3,3,2),imshow(second_image);
subplot(3,3,3),imshow(third_image);
% subplot(2,2,4),imshow(fourth_image);
end
% for a 4x4 plot
