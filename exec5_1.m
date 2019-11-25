#! /usr/bin/octave -qi

pkg load image;

## file   = input("Enter path for a image in gray scale: ");
file = 'assets/lena_cinza.bmp';

im = imread(file);

disp("Default image");
imshow(im);
pause(3);

g1 = imnoise(im,      "gaussian", 0,  0.01);
g2 = imnoise(log(im), "gaussian", 30, 0.01);
g3 = imnoise(log(im), "gaussian", 50, 0.05);
disp("Gaussian variations");
imshow(g1, []);
pause(3);
imshow(g2, []);
pause(3);
imshow(g3, []);
pause(3);

p1 = imnoise(im, "poisson");
disp("Poisson variations");
imshow(p1);
pause(3);

sp1 = imnoise(im, "salt & pepper", 0.02);
sp2 = imnoise(im, "salt & pepper",  0.1);
disp("Salt & Pepper variations");
imshow(sp1, []);
pause(3);
imshow(sp2, []);
pause(3);
