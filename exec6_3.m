#! /usr/bin/octave -qi

pkg load image;

file   = input("Enter path for a image in colors: ");
## file = 'assets/lena_color.bmp';

function qimg = quantization(img, q)
  qimg = floor(img/q)*q+q/2;
endfunction

function new_file = quantiza (file, bitsY, bitsCb, bitsCr)
  im = imread(file);

  yim = rgb2ycbcr(im);

  y_chan  = im(:, :, 1);
  cb_chan = im(:, :, 2);
  cr_chan = im(:, :, 3);

  y_chan  = quantization(y_chan,  bitsY);
  cb_chan = quantization(cb_chan, bitsCb);
  cr_chan = quantization(cr_chan, bitsCr);

  new_imy = cat(3, y_chan, cb_chan, cr_chan);
  new_im  = ycbcr2rgb(new_imy);

  new_file = sprintf("%s_quantizada_ycbcr.bmp", regexprep(file, '\....$', ''));
  imwrite(new_im, new_file);
endfunction

new_file = quantiza(file, 8, 2, 2);

disp(new_file);
