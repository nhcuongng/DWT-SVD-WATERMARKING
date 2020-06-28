function [ncc, psnr, mse] = danhGiaChiTieu(img_truoc, img_sau)
    img_truoc = imresize(img_truoc, [512 512]);
    img_sau = imresize(img_sau, [512 512]);
    ncc = corr2(img_truoc, img_sau);
    psnr = PSNR(double(img_truoc), double(img_sau));
    mse = immse(img_truoc, img_sau);
end