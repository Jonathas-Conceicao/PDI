#! /usr/bin/octave -qi

interpolation_message = ["Interpolation methods\n" ...
                         "1 - Nearest Neighbor\n" ...
                         "2 - Bilinear\n" ...
                         "Choose one:"];
# image   = input("Enter path for a image in gray scale: ");
image = 'assets/lena_cinza.bmp';
n_scale = input("Enter n scale: ");
## n_scale = 2;
m_scale = input("Enter m scale: ");
## m_scale = 2;
# interpolation = input(interpolation_message);
interpolation = 1;

function new_file = redimensionar (file, type, n_scale, m_scale)
  im = imread(file);
  rs = rows(im);
  cl = columns(im);

  m = cl * m_scale;
  n = rs * n_scale;
  new_im = zeros(m, n, "uint8");

  if type == 1
    type_name = "nearest_neighbor";
    
    for i = 1:rs
      for j = 1:cl
        p1 = im(i,j);
        if (i+1 <= rs)
          p2 = im(i+1, j);
        else
          p2 = im(i, j);
        endif
        val = p1+p2/2;

        for a = 1:n_scale;
          for b = 1:m_scale;
            in_i = (i-1) * n_scale + a;
            in_j = (j-1) * m_scale + b;
            new_im(in_i,in_j) = val;
          endfor
        endfor
      endfor
    endfor
  else
    type_name = "bilinear";
  endif
  new_file = sprintf("%s_%i_%i_%s.bmp",
                     regexprep(file, '\....$', ''),
                     n_scale,
                     m_scale,
                     type_name);
  imwrite(new_im, new_file, "bmp");
endfunction

new_file = redimensionar(image, interpolation, n_scale, m_scale);
printf("New file: %s\n", new_file);
