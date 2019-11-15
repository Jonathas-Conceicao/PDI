#! /usr/bin/octave -qi

interpolation_message = ["Interpolation methods\n" ...
                         "1 - Nearest Neighbor\n" ...
                         "2 - Bilinear\n" ...
                         "Choose one:"];
image   = input("Enter path for a image in gray scale: ");
## image = 'assets/lena_cinza.bmp';
n_scale = input("Enter n scale: ");
## n_scale = 3;
m_scale = input("Enter m scale: ");
## m_scale = 3;
interpolation = input(interpolation_message);
## interpolation = 2;

function val = nearest_neighbor (j, pj, qj, val_p, val_q)
  if ((j-pj) <= (qj-j))
    val = val_p;
  else
    val = val_q;
  endif
endfunction

function val = bilinear (j, pj, qj, val_p, val_q)
  val = val_p + (j-pj) * ((val_q-val_p) / (qj-pj));
endfunction

function new_file = redimensionar (file, type, n_scale, m_scale)
  im = imread(file);
  rs = rows(im);
  cl = columns(im);

  new_im = zeros(cl * m_scale,
                 rs * n_scale,
                 "uint8");

  if type == 1
    type_name = "nearest_neighbor";
  else
    type_name = "bilinear";
  endif

  for i = 1:rs
    for j = 1:cl
      p1 = im(j, i);
      if (j+1 <= rs)
        p2 = im(j+1, i);
      else
        p2 = im(j, i);
      endif

      for a = 1:n_scale;
        for b = 1:m_scale;
          in_i = (i-1) * n_scale + a;
          in_j = (j-1) * m_scale + b;
          if type == 1
            new_im(in_j,in_i) = nearest_neighbor(in_j, j, j+m_scale, p1, p2);
          else
            new_im(in_j,in_i) = bilinear(in_j, j, j+m_scale, p1, p2);
          endif
        endfor
      endfor
    endfor
  endfor

  new_file = sprintf("%s_%i_%i_%s.bmp",
                     regexprep(file, '\....$', ''),
                     n_scale,
                     m_scale,
                     type_name);
  imwrite(new_im, new_file, "bmp");
endfunction

new_file = redimensionar(image, interpolation, n_scale, m_scale);
printf("New file: %s\n", new_file);
