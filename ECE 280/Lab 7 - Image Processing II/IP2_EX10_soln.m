x = imread('coins.png');
x = x(2:end, 2:end);
figure(1); clf
image(x); axis equal; colormap gray; colorbar

X = fft2(x);
Xs = fftshift(X);
figure(2); clf
imagesc(log10(abs(Xs))); axis equal; colormap gray; colorbar

[rows, cols] = size(x);
max_size = max(rows, cols);
rnorm = rows/max_size; cnorm = cols/max_size;
[v, u] = meshgrid(linspace(-cnorm, cnorm, cols),...
    linspace(-rnorm, rnorm, rows)) ;
filter = (((0.4>abs(u))&(abs(u)>0.2)) | ((0.5>abs(v))&(abs(v)>0.3))) & ~((abs(u) > 0.4)|(abs(v)>0.5));
figure(3); clf
imagesc(filter); axis equal; colormap gray; colorbar
title("filter (ay140)")

Xsfiltered = Xs.*filter;
figure(4); clf
imagesc(log10(abs(Xsfiltered))); axis equal; colormap gray; colorbar
title("filtered fft2 image (ay140)")

Xfiltered = ifftshift(Xsfiltered);
xfiltered = ifft2(Xfiltered);
figure(5); clf
imagesc(xfiltered); axis equal; colormap gray; colorbar
title("final filtered fft2 image (ay140)")