#! /usr/bin/octave -qi

file   = input("Enter path for a image in gray scale: ");
## file = 'assets/lena_cinza.bmp';

function new_file = filtra_freq (file, mascara)
  im = imread(file);
  rs = rows(im);
  cl = columns(im);

  fft_im = fft2(im);
  fft_im = fftshift(fft_im);
  imwrite(fft_im, "spectre.bmp", "bmp");
  imshow(log(abs( fft_im )), []);

  for i = 1:rs
    for j = 1:cl
      fft_im(i,j) = fft_im(i,j);
    endfor
  endfor

  fft_im = ifftshift(fft_im);
  fft_im = ifft2(fft_im);

  imshow(log(abs( fft_im )), []);
  new_file = sprintf("%s_filtrada.bmp", regexprep(file, '\....$', ''));
  imwrite(log(abs( fft_im )), new_file);
endfunction

function out = passa_tudo (in)
  out = in
endfunction

new_file = filtra_freq(file, @passa_tudo);
disp(new_file);
