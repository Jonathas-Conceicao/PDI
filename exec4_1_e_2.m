#! /usr/bin/octave -qi

file   = input("Enter path for a image in gray scale: ");
## file = 'assets/lena_cinza.bmp';
im = imread(file);

fft_im = fft2(im);

view1 = log(abs( fftshift(fft_im) ));
view2 = log(abs( ifft2(fft_im)    ));
imshow(view1, []);
imshow(view2, []);
