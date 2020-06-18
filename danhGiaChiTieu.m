function [ncc, psnr, mse] = danhGiaChiTieu(img_truoc, img_sau)
    ncc = corr2(img_truoc, img_sau);
    psnr = PSNR(double(img_truoc), double(img_sau));
    mse = immse(img_truoc, img_sau);
end