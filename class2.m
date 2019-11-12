#! /usr/bin/octave

# image   = input("Enter path for a image in gray scale: ");
image = 'assets/lena_contraste.bmp';
image = imread(image);
## hist(image);
imMax = max(max(image));
imMin = min(min(image));

function new_value = distribute(value, imMax, imMin)
	hi_scale = 255/imMax;
	lo_scale = 1/imMin;
	new_value = hi_scale * value + lo_scale * value;
endfunction

new_im = arrayfun(@distribute, image, imMax, imMin);
imshow(new_im);
