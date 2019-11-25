#! /usr/bin/octave -qi

file   = input("Enter path for a image in gray scale: ");
## file = 'assets/lena_sal_e_pimenta.jpg';

function val = checked_value(m, y, x)
  a = rows(m);
  b = columns(m);
  if x < 1 || x > a
    val = 128;
    return;
  endif
  if y < 1 || y > b
    val = 128;
    return;
  endif
  val = int16(m(x, y));
endfunction

function new_file = restaura (file, border_size, filter)
  im = imread(file);
  rs = rows(im);
  cl = columns(im);

  new_im = zeros(cl, rs, "uint8");
  vec = zeros(border_size, border_size, "int16");

  ck = @checked_value;
  for i = 1:rs
    for j = 1:cl
      for n = -border_size:border_size
        for m = -border_size:border_size
          vec(n+border_size+1, m+border_size+1) = ck(im, j+m, i+n);
        endfor
      endfor
      new_im(i, j) = filter(vec(:));
    endfor
  endfor

  new_file = sprintf("%s_restaurada.bmp", regexprep(file, '\....$', ''));
  imwrite(new_im, new_file, "bmp");
endfunction

## Use one of the lines below, but not both, since the output file has the same name

new_file = restaura(file, 1, @mean);
# new_file = restaura(file, 1, @median);

disp(new_file);
