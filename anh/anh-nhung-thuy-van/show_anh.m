act_lena = "lena_act.png";
act_lena_title = "Lena đã nhúng logo Act";
lena_copyright1 = "lena_copyright1.png";
lena_copyright1_title = "Lena đã nhúng logo copyright1";
lena_copyright2 = "lena_copyright2.png";
lena_copyright2_title = "Lena đã nhúng logo copyright2";

mandril_act = "mandril_act.png";
mandril_act_title = "Mandril đã nhúng logo logo Act";
mandril_copyright1 = "mandril_copyright1.png";
mandril_copyright1_title = "Mandril đã nhúng logo copyright1";
mandril_copyright2 = "mandril_copyright2.png";
mandril_copyright2_title = "Mandril đã nhúng logo copyright2";

pepper_act = "pepper_act.png";
pepper_act_title = "Pepper đã nhúng logo logo Act";
pepper_copyright1 = "pepper_copyright1.png";
pepper_copyright1_title = "Pepper đã nhúng logo copyright1";
pepper_copyright2 = "pepper_copyright2.png";
pepper_copyright2_title = "Pepper đã nhúng logo copyright2";


figure
%% Lena
subplot(3,3,1),imshow(act_lena);xlabel(act_lena_title);
subplot(3,3,2),imshow(lena_copyright1);xlabel(lena_copyright1_title);
subplot(3,3,3),imshow(lena_copyright2);xlabel(lena_copyright2_title);

%% Mandril
subplot(3,3,4),imshow(mandril_act);xlabel(mandril_act_title);
subplot(3,3,5),imshow(mandril_copyright1);xlabel(mandril_copyright1_title);
subplot(3,3,6),imshow(mandril_copyright2);xlabel(mandril_copyright2_title);

%% Peppers
subplot(3,3,7),imshow(pepper_act);xlabel(pepper_act_title);
subplot(3,3,8),imshow(pepper_copyright1);xlabel(pepper_copyright1_title);
subplot(3,3,9),imshow(pepper_copyright2);xlabel(pepper_copyright2_title);
