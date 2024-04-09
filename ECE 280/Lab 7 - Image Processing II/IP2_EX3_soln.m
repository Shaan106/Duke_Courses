x = imread('coins.png');

% 399x399 matrix of random numbers
% x = rand(399,399);

x = x(2:end, 2:end);
title('Original (ay140)');
figure(1); clf
image(x); axis equal; colormap gray; colorbar

X = fft2(x);
Xs = fftshift(X);
title('Filtered Image (ay140)');
figure(2); clf
imagesc(log10(abs(Xs))); axis equal; colormap gray; colorbar

[rows, cols] = size(x);
max_size = max(rows, cols);
rnorm = rows/max_size; cnorm = cols/max_size;
[v, u] = meshgrid(linspace(-cnorm, cnorm, cols),...
    linspace(-rnorm, rnorm, rows)) ;
filter = sqrt(u.^2+v.^2)<0.5;
title('Filtered Image (ay140)');
figure(3); clf
imagesc(filter); axis equal; colormap gray; colorbar

Xsfiltered = Xs.*filter;

Xfiltered = ifftshift(Xsfiltered);
xfiltered = ifft2(Xfiltered);
title('Filtered Image (ay140)');
figure(6); clf
imagesc(xfiltered, [0, 255]); axis equal; colormap gray; colorbar

title('Filtered Image (ay140)');
figure(4); clf
imagesc(log10(abs(Xsfiltered))); axis equal; colormap gray; colorbar
