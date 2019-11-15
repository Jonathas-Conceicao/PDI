#! /usr/bin/octave -qi

file   = input("Enter path for a image in gray scale: ");
## file = 'assets/lena_contraste.bmp';
image = imread(file);
imMax = max(max(image));
imMin = min(min(image));

function new_value = contraste(value, imMax, imMin)
  new_value = (imMax - value) * (255 / (imMax-imMin));
endfunction

new_im = arrayfun(@contraste, image, imMax, imMin);
imshow(new_im);
new_file = sprintf("%s_new.bmp", regexprep(file, '\....$', ''));
imwrite(new_im, new_file, "bmp");
printf("New image: %s\n", new_file);

hist(image, 256);
hist(new_im, 256);
