#! /usr/bin/octave -qi

file   = input("Enter path for a image in colors: ");
## file = 'assets/lena_color.bmp';

function qimg = quantization(img, q)
  qimg = floor(img/q)*q+q/2;
endfunction

function new_file = quantiza (file, bitsR, bitsG, bitsB)
  im = imread(file);

  r_chan = im(:, :, 1);
  g_chan = im(:, :, 2);
  b_chan = im(:, :, 3);

  r_chan = quantization(r_chan, bitsR);
  g_chan = quantization(g_chan, bitsG);
  b_chan = quantization(b_chan, bitsB);

  new_im = cat(3, r_chan, g_chan, b_chan);

  new_file = sprintf("%s_quantizada.bmp", regexprep(file, '\....$', ''));
  imwrite(new_im, new_file);
endfunction

## new_file = quantiza(file, 16, 2, 2);
## new_file = quantiza(file, 2, 16, 2);
new_file = quantiza(file, 2, 2, 16);

disp(new_file);
