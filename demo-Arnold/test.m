im = double( im2bw( rgb2gray( imread( 'lena.png' ) ) ) );
arnold_test(im, 5)

% img_test = Arnold(im, 10);
% figure;
% subplot(2, 2, 1);
% imshow(im)
% subplot(2, 2, 2);
% imshow(img_test)
% subplot(2, 2, 3);
% imshow(IArnold(img_test, 10));


