#! /usr/bin/octave

interpolation_message = ["Interpolation methods\n" ...
                         "1 - Nearest Neighbor\n" ...
                         "2 - Bilinear\n" ...
                         "Choose one:"];
# image   = input("Enter path for a image in gray scale: ");
image = 'assets/lena_color.bmp';
# x_scale = input("Enter x scale: ");
x_scale = 1;
# y_scale = input("Enter y scale: ");
y_scale = 1;
# interpolation = input(interpolation_message);
interpolation = 1;

function new_file = redimensionar (file, type, x_scale, y_scale)
	if type == 1
		type_name = "nearest_neighbor";
	else
		type_name = "bilinear";
	endif
	new_file = sprintf("%s_%i_%i_%s",
										 file,
										 x_scale,
										 y_scale,
										 type_name);
	im = imread(file);
endfunction

new_file = redimensionar(image, interpolation, x_scale, y_scale);
printf("New file: %s\n", new_file);
