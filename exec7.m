#! /usr/bin/octave -qi

## Be warned:
## This script takes way too long to run

pkg load image;

## file   = input("Enter path for a image in gray scale: ");
file = 'assets/scan.jpg';

function val = checked_value(m, y, x)
  a = rows(m);
  b = columns(m);
  if x < 1 || x > a
    val = 0;
    return;
  endif
  if y < 1 || y > b
    val = 0;
    return;
  endif
  val = int16(m(x, y));
endfunction

function new_file = erosao (file, e_estruturante)
  im = imread(file);
  imbw = im2bw(im);
  rs = rows(im);
  cl = columns(im);
  e_rs = rows(e_estruturante);
  e_cl = columns(e_estruturante);

  new_im = zeros(cl, rs, "uint8");
  res = zeros(e_rs, e_cl, "int16");

  ck = @checked_value;
  for i = 1:rs
    for j = 1:cl

      for n = 1:e_rs
        for m = 1:e_cl
          n_ = n-floor(e_rs/2)-1;
          m_ = m-floor(e_cl/2)-1;

          if e_estruturante(n,m) == 1
            res(n, m) = ck(imbw, j+m_, i+n_);
          else
            res(n, m) = 1;
          endif
        endfor
      endfor

      if prod(res(:)) == 1
        new_im(i, j) = im(i, j);
      endif

    endfor
  endfor

  new_file = sprintf("%s_erosao.bmp", regexprep(file, '\....$', ''));
  imshow(new_im);
  imwrite(new_im, new_file, "bmp");
endfunction

function new_file = dilatacao (file, e_estruturante)
  im = imread(file);
  imbw = im2bw(im);
  rs = rows(im);
  cl = columns(im);
  e_rs = rows(e_estruturante);
  e_cl = columns(e_estruturante);

  new_im = zeros(cl, rs, "uint8");
  res = zeros(e_rs, e_cl, "int16");

  ck = @checked_value;
  for i = 1:rs
    for j = 1:cl

      for n = 1:e_rs
        for m = 1:e_cl
          n_ = n-floor(e_rs/2)-1;
          m_ = m-floor(e_cl/2)-1;

          if e_estruturante(n,m) == 1
            res(n, m) = ck(imbw, j+m_, i+n_);
          else
            res(n, m) = 0;
          endif
        endfor
      endfor

      if sum(res(:)) > 0
        new_im(i, j) = im(i, j);
      endif

    endfor
  endfor

  new_file = sprintf("%s_dilatacao.bmp", regexprep(file, '\....$', ''));
  imshow(new_im);
  imwrite(new_im, new_file, "bmp");
endfunction

est = [0, 1, 0; 1, 0, 1; 0, 1, 0];
new_file = erosao(file, est);
new_file = dilatacao(file, est);
disp(new_file);
