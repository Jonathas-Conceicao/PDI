#! /usr/bin/octave -qi

file   = input("Enter path for a image in colors: ");
## file = 'assets/lena_color.bmp';

function [r_file, g_file, b_file] = colors (file)
  im = imread(file);

  black = zeros(rows(im), columns(im));

  r_chan = im(:, :, 1);
  g_chan = im(:, :, 2);
  b_chan = im(:, :, 3);

  r_im = cat(3, r_chan, black, black);
  g_im = cat(3, black, g_chan, black);
  b_im = cat(3, black, black, b_chan);

  base = regexprep(file, '\....$', '');
  r_file = sprintf("%s_red.bmp",   base);
  g_file = sprintf("%s_green.bmp", base);
  b_file = sprintf("%s_blue.bmp",  base);

  imwrite(r_im, r_file);
  imwrite(g_im, g_file);
  imwrite(b_im, b_file);
endfunction

[r, g, b] = colors(file);

disp([r; g; b]);
