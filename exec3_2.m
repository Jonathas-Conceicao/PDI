#! /usr/bin/octave -qi

file   = input("Enter path for a image in gray scale: ");
## file = 'assets/barbara_gray.bmp';

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

function new_file = realce (file)
  im = imread(file);
  rs = rows(im);
  cl = columns(im);

  new_im = zeros(cl, rs, "uint8");

  ck = @checked_value;
  for i = 1:rs
    for j = 1:cl
      vec = [
             0               , ck(im, j, i-1)*1, 0,
             ck(im, j-1, i)*1, ck(im, j, i)*-4 , ck(im, j+1, i)*1,
             0               , ck(im, j, i+1)*1, 0,
      ];
      new_im(i, j) = sum(vec(:));
    endfor
  endfor

  new_file = sprintf("%s_realcada.bmp", regexprep(file, '\....$', ''));
  imwrite(new_im, new_file, "bmp");
endfunction

new_file = realce(file);
disp(new_file);
