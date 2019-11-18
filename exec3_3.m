#! /usr/bin/octave -qi

## file   = input("Enter path for a image in gray scale: ");
file = 'assets/barbara_gray.bmp';

im0 = imread(file);

f1 = [ 1/16, 2/16, 1/16,
       2/16, 4/16, 2/16,
       1/16, 2/16, 1];
f2 = [ 0,  1, 0,
       1, -4, 1,
       0,  1, 0];
f3 = [ 0,         0, -4/44,     0,   0,
       -4/44, 10/44, 20/44, 10/44, -4/44,
       0,         0, 10/44,     0,   0,
       0,         0, -4/44,     0,   0];

im1 = uint8(filter2(f1, int16(im0)));
im2 = uint8(filter2(f2, int16(im0)));
im3 = uint8(filter2(f3, int16(im0)));

imshow(im0);
imshow(im1);
imshow(im2);
imshow(im3);
